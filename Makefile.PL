use inc::Module::Install;

name     'Simulation-DiscreteEvent';
all_from 'lib/Simulation/DiscreteEvent.pm';
author   q{Pavel Shaydo <zwon@cpan.org>};
license  'perl';

build_requires 'Test::More' => 0.63;

requires Moose => 0;
requires 'Module::Load' => 0;
requires 'MooseX::MethodAttributes' => 0.19;
requires 'namespace::clean' => 0;

WriteAll;

