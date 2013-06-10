#!/usr/bin/perl
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Data::Dumper;
use Test::More;
use Test::TCP qw(test_tcp empty_port wait_port);
use Test::Skip::UnlessExistsExecutable;

use Cache::Memcached::Fast;
use File::Which qw(which);
use Proc::Guard;

use Cache::Memcached::Transparent;

skip_all_unless_exists 'memcached';

sub run_memcached_server {
    my $port = shift;
    my $proc = proc_guard( scalar which('memcached'), '-p', $port, '-U', 0 );
    wait_port($port);
    return $proc;
}

sub create_memcached_client {
    my $port = shift;
    return Cache::Memcached::Fast->new(
        +{ servers => [ 'localhost:' . $port ] } );
}

sub test_get {
    my %specs = @_;
    my ( $inputs, $expects, $desc ) = @specs{qw/ inputs expects desc /};
    my $key    = $inputs->{key};
    my @child  = @{$inputs->{child}};
    my @parent = @{$inputs->{parent}};

    my $p_port = empty_port;
    my $p_proc = run_memcached_server($p_port);
    my $p_memd = create_memcached_client($p_port);
    my $c_port = empty_port;
    my $c_proc = run_memcached_server($c_port);
    my $c_memd = create_memcached_client($c_port);

    $c_memd->set($key, @child) if @child;
    $p_memd->set($key, @parent) if @parent;

    my $t_memd = Cache::Memcached::Transparent->new(+{parent => "localhost:$p_port", child => "localhost:$c_port"});

    subtest $desc => sub {
        is ($t_memd->get($key), $expects->{child},  'child  expects ok');
        is ($t_memd->get($key), $expects->{parent}, 'parent expects ok');
        done_testing;
    };
}

test_get (
    inputs  => +{
        key    => "Spring_MT",
        child  => ["single", 30],
        parent => ["single", 30],
    },
    expects => +{
        child  => "single",
        parent => "single",
    },
    desc    => "test get by setting child and parent",
);

test_get (
    inputs  => +{
        key    => "Spring_MT",
        child  => [],
        parent => ["single", 30],
    },
    expects => +{
        child  => "single",
        parent => "single",
    },
    desc    => "test get by setting only parent",
);

done_testing;
