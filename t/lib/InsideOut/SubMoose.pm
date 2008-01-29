use strict;
use warnings;

package InsideOut::SubMoose;

use metaclass 'MooseX::InsideOut::Meta::Class';
use Moose;
extends 'InsideOut::BaseMoose';

has sub_foo => ( is => 'rw' );

1;

