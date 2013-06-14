#/usr/bin/perl

use strict;
use warnings;

use List::Util qw( shuffle );
use Data::Dumper;
use Net::Twitter;
use URI::Escape qw/uri_escape_utf8/;
use HTML::Entities qw/encode_entities/;
use HTML::Entities;
use utf8;
#use Web::Scraper;

my $twitter = Net::Twitter->new(
    traits => [qw/API::REST OAuth WrapError/],
    consumer_key    => '',
    consumer_secret => '',
);

$twitter->access_token       ('');
$twitter->access_token_secret('');
my $text = 'fooさんが、"hogehoge"をはじめました。';
print uri_escape_utf8($text)."\n";
print encode_entities($text)."\n";
print decode_entities($text)."\n";
print HTML::Entities::encode($text)."\n";
print HTML::Entities::decode($text)."\n";

#$twitter->update( $text );
#my $array_ref = $twitter->friends();
#print Dumper($array_ref);
