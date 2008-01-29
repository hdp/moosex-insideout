use strict;
use warnings;

package InsideOut::SubIO;

use metaclass 'MooseX::InsideOut::Meta::Class';
use Moose;
extends 'InsideOut::BaseIO';

has sub_foo => ( is => 'rw' );

1;
