use strict;
use warnings;

use Test::More qw(no_plan);

use ok 'Simulation::DiscreteEvent';

my $sim = Simulation::DiscreteEvent->new();

isa_ok $sim, 'Simulation::DiscreteEvent';
is $sim->time, 0, "time is 0";

alarm 5;
$sim->run;
alarm 0;
ok 1, "simulation exited as queue empty";

