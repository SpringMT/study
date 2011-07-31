use strict;
use warnings;
use lib 't/lib';
use lib 'lib';

use Test::More;
use My::Class::Pluggable;

sub test_default_search_path {
    my ( $stuff, $expected_search_path ) = @_;
    my $got_search_path = My::Class::Pluggable::default_search_path( $stuff );
    is( $got_search_path, $expected_search_path, sprintf('default search path of %s is %s', ref $stuff ? 'blessed ' . ref $stuff : $stuff) );
}

test_default_search_path( 'My::Class::Pluggable' => 'My::Class::Pluggable::Plugins::' );
test_default_search_path( bless({} => 'My::Class::Pluggable') => 'My::Class::Pluggable::Plugins::' );
test_default_search_path( 'MyApp::Web' => 'MyApp::Web::Plugins::' );
test_default_search_path( bless({} => 'MyApp::Web') => 'MyApp::Web::Plugins::' );

done_testing;

# Local Variables:
# mode: perl
# perl-indent-level: 4
# indent-tabs-mode: nil
# coding: utf-8-unix
# End:
#
# vim: expandtab shiftwidth=4:
