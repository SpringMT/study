package My::Class::Pluggable;

use strict;
use warnings;

our $VERSION = '0.01';
use UNIVERSAL::require;

sub load_plugins {
    my ( $proto, @args ) = @_;
    my $opts;
    if ( ref $args[0] eq 'HASH' ) {
        $opts = $args[0];
        $opts->{search_path} ||= $proto->default_search_path;
    }
    else {
        my $search_path = $proto->default_search_path;
        $opts = +{ plugins => [ @args ], search_path => $search_path };
    }

    my @plugins = @{$opts->{plugins}};

    for my $plugin (@plugins) {
         my $module = $opts->{search_path}  . $plugin;
         $module->require or return;
    }
    return @plugins;
}

sub default_search_path {
    my $proto = shift;
    my $search_path;
    my $suffix = "::Plugins::";

    if ( $proto->isa("My::Class::Pluggable") ) {
        $search_path = __PACKAGE__ . $suffix;
    }
    else {
        if ( ! ref $proto ) {
            $search_path = $proto . $suffix;
        }
        else {
            my $class = ref $proto;
            $search_path = $class . $suffix;
        }
    }

    return $search_path;
}

1;
__END__

=head1 NAME

My::Class::Pluggable - Write pluggable module easily.

=head1 SYNOPSIS

  package My::Dispatcher;
  use parent qw(My::Class::Pluggable);

  package My::WebApp;
  My::Dispatcher->load_plugins(qw/Exact Regex URI::Template +Your::CustomRule/);

=head1 DESCRIPTION

My::Class::Pluggable is

=head1 AUTHOR

Toru Yamaguchi E<lt>zigorou@cpan.orgE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
