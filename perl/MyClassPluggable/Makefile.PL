use inc::Module::Install;
name 'My-Class-Pluggable';
all_from 'lib/My/Class/Pluggable.pm';

requires 'parent';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
