use strict;
use warnings;

package InsideOut::SubArray;

use metaclass 'MooseX::InsideOut::Meta::Class';
use Moose;
extends 'InsideOut::BaseArray';

has sub_foo => ( is => 'rw' );

1;

