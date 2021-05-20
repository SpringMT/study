#!/usr/bin/perl

use strict;
use warnings;
use Carp;

use IO::File;
use IO::Handle;

STDOUT->autoflush(1);
STDERR->autoflush(1);

use Log::Minimal;
use Fcntl qw(SEEK_SET :flock);
use Path::Class qw(file dir);
use Try::Tiny;
use POSIX qw(strftime :signal_h);
use Sys::Hostname;

my $log_file = './test_hoge';
my $logfh;
$log_file = $log_file.'.'.strftime('%Y%m%d', localtime);
open $logfh, '>>', $log_file
    or die "failed to open file: $log_file: $!";
autoflush $logfh 1;

print $logfh '-'x78, "\n";

my $logpos = tell $logfh;
die "failed to obtain position of log_file:$!"
    if $logpos == -1;
seek $logfh, $logpos, SEEK_SET
    or die "cannot seek within log_file:$!";

pipe my $logrh, my $logwh
  or die "failed to create pipe:$!";

$Log::Minimal::PRINT = sub {
    my ($time, $type, $message, $trace,$raw_message) = @_;
    chomp $message;
    $message =~ s/\\n$//;
    print {$logfh} "$time [$type] $message\n";
};

infof("starting: %s", 'test');

my $timeout = 3;

my $timeout_exceeded = 0;
if (my $pid = fork) {
    ## parent
    try {
        if ($timeout > 0) {
            POSIX::sigaction(SIGALRM,
                             POSIX::SigAction->new(
                                 sub {
                                     critf("timeout exceeded");
                                     send_notify(
                                         message       => "Timeout exceeded.\nProcess is still running.\n",
                                         log_file      => $log_file,
                                         logpos        => $logpos,
                                     );
                                 },
                             ),
                         );
            alarm $timeout;
        }

        close $logwh;
        warnf($_) while <$logrh>;
        close $logrh;
        while (wait == -1) {}
        my $exit_code = $?;
        if ($timeout > 0) {
            alarm 0;
        }
    } catch {
        critf("$_");

        warnf($_) while <$logrh>;
        close $logrh;
        while (wait == -1) {}
        my $exit_code = $?;
    };
} else {
    ## child
    if (defined $pid) {
        close $logrh;
        close $logfh;
        open STDERR, '>&', $logwh
            or die "failed to redirect STDERR to log_file";
        open STDOUT, '>&', $logwh
            or die "failed to redirect STDOUT to log_file";
        close $logwh;

        exec "ruby test_log.rb";
        die "exec(2) failed:$!:@ARGV";
    } else {
        close $logrh;
        close $logwh;
        critf("fork(2) failed:$!")
            unless defined $pid;
    }
}

sub send_notify {
  my %p = @_;
  my $log_file      = $p{log_file};
  my $logpos        = $p{logpos};
  my $log = "";
  if ($p{message}) {
    $log .= $p{message}."\n\n";
  }
  open my $fh, '<', $log_file
      or die "failed to open $log_file:$!";
  seek $fh, $logpos, SEEK_SET
      or die "failed to seek to the appropriate position in log_file:$!";

  $log .= do { local $/; <$fh> };
  close $fh;

  print $log;
}
