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

sub test_set {
    my %specs = @_;
    my ( $inputs, $expects, $desc ) = @specs{qw/ inputs expects desc /};

    my $p_port = empty_port;
    my $p_proc = run_memcached_server($p_port);
    my $p_memd = create_memcached_client($p_port);
    my $c_port = empty_port;
    my $c_proc = run_memcached_server($c_port);
    my $c_memd = create_memcached_client($c_port);

    my $t_memd = Cache::Memcached::Transparent->new(+{parent => "localhost:$p_port", child => "localhost:$c_port"});

    subtest $desc => sub {
        $t_memd->set($inputs->{key}, $inputs->{value}, 30);
        is ($p_memd->get($inputs->{key}), $expects, 'parent expects ok');
        is ($c_memd->get($inputs->{key}), $expects, 'child  expects ok');
        done_testing;
    };
}

test_set (
    inputs  => +{key => "spring", value => "OK"},
    expects => "OK",
    desc    => "test set",
);

done_testing;
