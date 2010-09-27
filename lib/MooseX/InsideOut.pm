use strict;
use warnings;

package MooseX::InsideOut;
# ABSTRACT: inside-out objects with Moose

use Moose ();
use Moose::Exporter;
use Moose::Util::MetaRole;
use MooseX::InsideOut::Role::Meta::Instance;

Moose::Exporter->setup_import_methods(
  also => [ 'Moose' ],
);

sub init_meta {
  shift;
  my %p = @_;
  Moose->init_meta(%p);
  Moose::Util::MetaRole::apply_metaroles(
    for             => $p{for_class},
    class_metaroles => {
        instance => [ 'MooseX::InsideOut::Role::Meta::Instance' ],
    },
  );
}

1;
__END__

=head1 SYNOPSIS

  package My::Object;

  use MooseX::InsideOut;

  # ... normal Moose functionality
  # or ...

  package My::Subclass;

  use MooseX::InsideOut;
  extends 'Some::Other::Class';

=head1 DESCRIPTION

MooseX::InsideOut provides metaroles for inside-out objects.  That is, it sets
up attribute slot storage somewhere other than inside C<$self>.  This means
that you can extend non-Moose classes, whose internals you either don't want to
care about or aren't hash-based.

=method init_meta

Apply the instance metarole necessary for inside-out storage.

=head1 TODO

=over

=item * dumping (for debugging purposes)

=item * serialization (for e.g. storable)

=item * (your suggestions here)

=back

=cut
