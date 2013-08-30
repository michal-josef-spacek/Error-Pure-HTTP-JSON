# Pragmas.
use strict;
use warnings;

# Modules.
use Test::More 'tests' => 3;
use Test::NoWarnings;

BEGIN {

	# Test.
	use_ok('Error::Pure::HTTP::JSON::Advance');
}

# Test.
require_ok('Error::Pure::HTTP::JSON::Advance');
