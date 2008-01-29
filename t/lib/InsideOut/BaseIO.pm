use strict;
use warnings;

package InsideOut::BaseIO;

use Moose;
extends 'MooseX::InsideOut';

has base_foo => (
  is => 'rw',
);

1;
