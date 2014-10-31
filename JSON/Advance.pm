package Error::Pure::HTTP::JSON::Advance;

# Pragmas.
use base qw(Exporter);
use strict;
use warnings;

# Modules.
use Error::Pure::Output::JSON qw(err_json);
use Error::Pure::Utils qw(err_helper);
use List::MoreUtils qw(none);
use Readonly;

# Constants.
Readonly::Array our @EXPORT_OK => qw(err);
Readonly::Scalar my $EVAL => 'eval {...}';

# Version.
our $VERSION = 0.04;

# Global variables.
our %ERR_PARAMETERS;

# Ignore die signal.
$SIG{__DIE__} = 'IGNORE';

# Process error.
sub err {
	my @msg = @_;

	# Get errors structure.
	my @errors = err_helper(@msg);

	# Finalize in main on last err.
	my $stack_ar = $errors[-1]->{'stack'};
	if ($stack_ar->[-1]->{'class'} eq 'main'
		&& none { $_ eq $EVAL || $_ =~ /^eval '/ms }
		map { $_->{'sub'} } @{$stack_ar}) {

		# Construct error structure.
		my $err_hr = {
			'error-pure' => \@errors,
		};
		foreach my $key (keys %ERR_PARAMETERS) {
			$err_hr->{$key} = $ERR_PARAMETERS{$key};
		}

		# Print out.
		print "Content-type: application/json\n\n";
		print err_json($err_hr);
		return;

	# Die for eval.
	} else {
		my $e = $errors[-1]->{'msg'}->[0];
		if (! defined $e) {
			$e = 'undef';
		} else {
			chomp $e;
		}
		die "$e\n";
	}

	return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

Error::Pure::HTTP::JSON::Advance - Error::Pure module for JSON output with additional parameters over HTTP.

=head1 SYNOPSIS

 use Error::Pure::HTTP::JSON::Advance qw(err);
 err 'This is a fatal error', 'name', 'value';

=head1 SUBROUTINES

=over 8

=item B<err(@messages)>

 Process error in JSON format with messages @messages.
 Output affects $Error::Pure::Output::JSON::PRETTY variable.

=back

=head1 EXAMPLE1

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use Error::Pure::HTTP::JSON::Advance qw(err);

 # Additional parameters.
 %Error::Pure::HTTP::JSON::Advance::ERR_PARAMETERS = (
         'status' => 1,
         'message' => 'Foo bar',
 );

 # Error.
 err '1';

 # Output like:
 # Content-type: application/json
 #
 # {"status":1,"error-pure":[{"msg":["1"],"stack":[{"sub":"err","prog":"example1.pl","args":"(1)","class":"main","line":17}]}],"message":"Foo bar"}

=head1 EXAMPLE2

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use Error::Pure::HTTP::JSON::Advance qw(err);

 # Additional parameters.
 %Error::Pure::HTTP::JSON::Advance::ERR_PARAMETERS = (
         'status' => 1,
         'message' => 'Foo bar',
 );

 # Error.
 err '1', '2', '3';

 # Output like:
 # Content-type: application/json
 #
 # {"status":1,"error-pure":[{"msg":["1","2","3"],"stack":[{"sub":"err","prog":"example2.pl","args":"(1, 2, 3)","class":"main","line":17}]}],"message":"Foo bar"}

=head1 EXAMPLE3

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

=head1 DEPENDENCIES

L<Error::Pure::Utils>,
L<Error::Pure::Output::JSON>,
L<Exporter>,
L<List::MoreUtils>,
L<Readonly>.

=head1 SEE ALSO

L<Error::Pure>,
L<Error::Pure::AllError>,
L<Error::Pure::Always>,
L<Error::Pure::Die>,
L<Error::Pure::Error>,
L<Error::Pure::ErrorList>,
L<Error::Pure::HTTP::AllError>,
L<Error::Pure::HTTP::Error>,
L<Error::Pure::HTTP::ErrorList>,
L<Error::Pure::HTTP::JSON>,
L<Error::Pure::HTTP::Print>,
L<Error::Pure::JSON>,
L<Error::Pure::JSON::Advance>,
L<Error::Pure::NoDie>,
L<Error::Pure::Output::JSON>,
L<Error::Pure::Output::Text>,
L<Error::Pure::Utils>.

=head1 REPOSITORY

L<https://github.com/tupinek/Error-Pure-JSON>

=head1 AUTHOR

Michal Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

BSD license.

=head1 VERSION

0.04

=cut
