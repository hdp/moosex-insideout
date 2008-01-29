use strict;
use warnings;

package MooseX::InsideOut::Meta::Instance;

use Moose;
extends 'Moose::Meta::Instance';

use Hash::Util::FieldHash::Compat qw(fieldhash);
use Scalar::Util qw(refaddr weaken);

# don't touch this or I beat you
# this is only a package variable for inlinability
fieldhash our %__attr;

sub create_instance {
  my ($self) = @_;

  #my $instance = \(my $dummy);
  my $instance = $self->SUPER::create_instance;

  $__attr{refaddr $instance} = {};
  return bless $instance => $self->associated_metaclass->name;
}

sub get_slot_value {
  my ($self, $instance, $slot_name) = @_;

  return $__attr{refaddr $instance}->{$slot_name};
}

sub set_slot_value {
  my ($self, $instance, $slot_name, $value) = @_;

  return $__attr{refaddr $instance}->{$slot_name} = $value;
}

sub deinitialize_slot {
  my ($self, $instance, $slot_name) = @_;

  return delete $__attr{refaddr $instance}->{$slot_name};
}

sub is_slot_initialized {
  my ($self, $instance, $slot_name) = @_;

  return exists $__attr{refaddr $instance}->{$slot_name};
}

sub weaken_slot_value {
  my ($self, $instance, $slot_name) = @_;

  weaken $__attr{refaddr $instance}->{$slot_name};
}

sub inline_create_instance { 
  my ($self, $class_variable) = @_;
  return join '',
    #'my $instance = \(my $dummy);',
    # hardcoding superclass -- can't think of a good way to avoid that
    'my $instance = Moose::Meta::Instance->create_instance;',
    sprintf(
      '$%s::__attr{%s} = {};',
      __PACKAGE__,
      'Scalar::Util::refaddr($instance)',
    ),
    sprintf(
      'bless $instance => %s;',
      $class_variable,
    ),
  ;
}

sub inline_slot_access {
  my ($self, $instance, $slot_name) = @_;
  return sprintf '$%s::__attr{%s}->{%s}',
    __PACKAGE__,
    'Scalar::Util::refaddr ' . $instance,
    $slot_name,
  ;
}

sub __dump {
  my ($class, $instance) = @_;
  require Data::Dumper;
  return Data::Dumper::Dumper($__attr{refaddr $instance});
}

1;
