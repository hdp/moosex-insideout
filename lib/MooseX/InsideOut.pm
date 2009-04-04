use strict;
use warnings;

package MooseX::InsideOut;
# ABSTRACT: inside-out objects with Moose

use MooseX::InsideOut::Meta::Class;
BEGIN { require Moose }
use Carp;

sub import {
  my $class = shift;
  
  if (@_) { Carp::confess "$class has no exports" }

  my $into = caller;

  return if $into eq 'main';

  Moose::init_meta(
    $into,
    'Moose::Object',
    'MooseX::InsideOut::Meta::Class',
  );

  Moose->import({ into => $into });

  return;
}

1;
__END__

=head1 SYNOPSIS

  package My::Object;

  use MooseX::InsideOut;

  # ... normal Moose functionality
  # or ...

  package My::Subclass;

  use metaclass 'MooseX::InsideOut::Meta::Class';
  use Moose;
  extends 'Some::Other::Class';

=head1 DESCRIPTION

MooseX::InsideOut provides a metaclass and an instance metaclass for inside-out
objects.

You can use MooseX::InsideOut, as in the first example in the L</SYNOPSIS>.
This sets up the metaclass and instance metaclass for you, as well as importing
all of the normal Moose goodies.

You can also use the metaclass C<MooseX::InsideOut::Meta::Class> directly, as
in the second example.  This is most useful when extending a non-Moose class,
whose internals you either don't want to care about or aren't hash-based.

=head1 TODO

=over

=item * dumping (for debugging purposes)

=item * serialization (for e.g. storable)

=item * (your suggestions here)

=back

=cut
