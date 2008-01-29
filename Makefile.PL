use inc::Module::Install;

name     'MooseX-InsideOut';
all_from 'lib/MooseX/InsideOut.pm';
author   'Hans Dieter Pearcey <hdp@pobox.com>';

build_requires 'Test::More';

requires 'Moose'                         => '0.35';
requires 'Hash::Util::FieldHash::Compat' => 0;
requires 'Task::Weaken'                  => 0;

auto_install;

WriteAll;

