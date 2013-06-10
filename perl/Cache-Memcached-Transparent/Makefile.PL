use inc::Module::Install;
name 'Cache-Memcached-Transparent';
all_from 'lib/Cache/Memcached/Transparent.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
