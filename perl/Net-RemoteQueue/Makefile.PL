use inc::Module::Install;
name 'Net-RemoteQueue';
all_from 'lib/Net/RemoteQueue.pm';

requires 'Class::Accessor::Lite';
requires 'IO::File';
requires 'IO::Socket::INET';
requires 'JSON::XS';
requires 'Parallel::Prefork';
requires 'Log::Minimal';

tests_recursive 't';
author_tests 'xt';
install_script 'script/remote_queue_server.pl';

test_requires 'Test::More';
test_requires 'Test::LoadAllModules';
auto_set_repository;
auto_include;
WriteAll;
