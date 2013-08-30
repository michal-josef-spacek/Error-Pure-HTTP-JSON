# Pragmas.
use strict;
use warnings;

# Modules.
use inc::Module::Install;

# Definition.
abstract 'Perl module for HTTP JSON output for structured errors.';
author 'Michal Špaček <skim@cpan.org>';
license 'bsd';
name 'Error-Pure-HTTP-JSON';
requires 'Error::Pure::Utils' => 0.11;
requires 'Error::Pure::Output::JSON' => 0.01;
requires 'Readonly' => 0;
resources 'bugtracker' => 'https://rt.cpan.org/Public/Dist/Display.html'.
	'?Name=Error-Pure-HTTP-JSON';
resources 'homepage' => 'https://github.com/tupinek/Error-Pure-HTTP-JSON';
resources 'repository' => 'git://github.com/tupinek/Error-Pure-HTTP-JSON';
test_requires 'English' => 0;
test_requires 'File::Object' => 0.05;
test_requires 'Test::More' => 0;
test_requires 'Test::NoWarnings' => 0;
test_requires 'Test::Pod' => 0;
test_requires 'Test::Pod::Coverage' => 0;
tests_recursive;
version '0.02';

# Run.
WriteAll();
