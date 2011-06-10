use strict;
use warnings;
use lib 'lib';
use lib 't/lib';

use Test::More;
use MyApp;

sub is_loaded_module {
    my $module = shift;
    my $file = join( '/' => split '::' => $module ) . '.pm';
    ok( exists $INC{$file}, sprintf('module %s is loaded', $module) );
}

isa_ok( 'MyApp', 'My::Module::Pluggable' );
can_ok( 'MyApp', qw/load_plugins/ );

my @plugins = MyApp->load_plugins(qw/Foo Bar +Other::Plugins::Baz/);

for ( @plugins ) {
    is_loaded_module( $_ );
}

done_testing;

# Local Variables:
# mode: perl
# perl-indent-level: 4
# indent-tabs-mode: nil
# coding: utf-8-unix
# End:
#
# vim: expandtab shiftwidth=4:
