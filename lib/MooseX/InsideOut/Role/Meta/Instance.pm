package MooseX::InsideOut::Role::Meta::Instance;

use Moose::Role;

use Hash::Util::FieldHash::Compat qw(fieldhash);
use Scalar::Util qw(refaddr weaken);
use namespace::clean -except => 'meta';

fieldhash our %attr;

around create_instance => sub {
  my $next = shift;
  my $instance = shift->$next(@_);
  $attr{refaddr $instance} = {};
  return $instance;
};

sub get_slot_value {
  my ($self, $instance, $slot_name) = @_;

  return $attr{refaddr $instance}->{$slot_name};
}

sub set_slot_value {
  my ($self, $instance, $slot_name, $value) = @_;

  return $attr{refaddr $instance}->{$slot_name} = $value;
}

sub deinitialize_slot {
  my ($self, $instance, $slot_name) = @_;
  return delete $attr{refaddr $instance}->{$slot_name};
}

sub deinitialize_all_slots {
  my ($self, $instance) = @_;
  $attr{refaddr $instance} = {};
}

sub is_slot_initialized {
  my ($self, $instance, $slot_name) = @_;

  return exists $attr{refaddr $instance}->{$slot_name};
}

sub weaken_slot_value {
  my ($self, $instance, $slot_name) = @_;
  weaken $attr{refaddr $instance}->{$slot_name};
}

around inline_create_instance => sub {
  my $next = shift;
  my ($self, $class_variable) = @_;
  my $code = $self->$next($class_variable);
  $code = "do { my \$instance = ($code);";
  $code .= sprintf(
    '$%s::attr{Scalar::Util::refaddr($instance)} = {};',
    __PACKAGE__,
  );
  $code .= '$instance }';
  return $code;
};

sub inline_slot_access {
  my ($self, $instance, $slot_name) = @_;
  return sprintf '$%s::attr{Scalar::Util::refaddr(%s)}->{%s}',
    __PACKAGE__, $instance, $slot_name;
}

1;

__END__

=head1 DESCRIPTION

Meta-instance role implementing inside-out storage.

=method create_instance

=method get_slot_value

=method set_slot_value

=method deinitialize_slot

=method deinitialize_all_slots

=method is_slot_initialized

=method weaken_slot_value

=method inline_create_instance

=method inline_slot_access

See L<Class::MOP::Instance>.

=cut
