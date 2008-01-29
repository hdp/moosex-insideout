use strict;
use warnings;

package MooseX::InsideOut::Meta::Class;

# need to load this before loading Moose and using it as a metaclass, because
# of circularity
use MooseX::InsideOut::Meta::Instance;
use Moose;
extends 'Moose::Meta::Class';

sub initialize {
  my $class = shift;
  my $pkg   = shift;
  $class->SUPER::initialize(
    $pkg,
    instance_metaclass => 'MooseX::InsideOut::Meta::Instance',
    @_,
  );
}

# this seems like it should be part of Moose::Meta::Class
sub construct_instance {
  my ($class, %params) = @_;
  my $meta_instance = $class->get_meta_instance;
  my $instance      = $params{'__INSTANCE__'}
    || $meta_instance->create_instance();
  foreach my $attr ($class->compute_all_applicable_attributes()) {
    my $meta_instance = $attr->associated_class->get_meta_instance;
    $attr->initialize_instance_slot($meta_instance, $instance, \%params);
  }
  return $instance;
}

1;
