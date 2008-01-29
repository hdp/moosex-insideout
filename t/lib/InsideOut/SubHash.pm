use strict;
use warnings;

package InsideOut::SubHash;

use metaclass 'MooseX::InsideOut::Meta::Class';
use Moose;
extends 'InsideOut::BaseHash';

has sub_foo => ( is => 'rw' );

1;
