use strict;
use warnings;

package MooseX::InsideOut;

use MooseX::InsideOut::Meta::Class;
BEGIN { require Moose }
use Carp;

our $VERSION = '0.003';

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

=head1 NAME

MooseX::InsideOut - inside-out objects with Moose

=head1 VERSION

Version 0.003

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

=head1 AUTHOR

Hans Dieter Pearcey, C<< <hdp at pobox.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-moosex-insideout at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=MooseX-InsideOut>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc MooseX::InsideOut


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=MooseX-InsideOut>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/MooseX-InsideOut>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/MooseX-InsideOut>

=item * Search CPAN

L<http://search.cpan.org/dist/MooseX-InsideOut>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2008 Hans Dieter Pearcey.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
