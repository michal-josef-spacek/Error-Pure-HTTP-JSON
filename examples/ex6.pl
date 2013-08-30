#!/usr/bin/env perl

# Pragmas.
use strict;
use warnings;

# Modules.
use Error::Pure::Output::JSON;
use Error::Pure::HTTP::JSON::Advance qw(err);

# Additional parameters.
%Error::Pure::HTTP::JSON::Advance::ERR_PARAMETERS = (
        'status' => 1,
        'message' => 'Foo bar',
);

# Pretty print.
$Error::Pure::Output::JSON::PRETTY = 1;

# Error.
err '1';

# Output like:
# Content-type: application/json
#
# {
#    "status" : 1,
#    "error-pure" : [
#       {
#          "msg" : [
#             "1"
#          ],
#          "stack" : [
#             {
#                "sub" : "err",
#                "prog" : "example3.pl",
#                "args" : "(1)",
#                "class" : "main",
#                "line" : 21
#             }
#          ]
#       }
#    ],
#    "message" : "Foo bar"
# }