use strict;
use warnings;

use Test::More;
eval "use Devel::Leak";
plan skip_all => 'This test requires Devel::Leak' if $@;
    plan 'no_plan';

use ok 'Simulation::DiscreteEvent';

my $invalid_object = {};

{
    package Test::DE::Server;
    use Moose;
    BEGIN { extends 'Simulation::DiscreteEvent::Server' };
 
    sub type { 'Test Server' }
    sub start : Event(start) { return 'Started' }
    no Moose;
    __PACKAGE__->meta->make_immutable;
}

{
    my $model = Simulation::DiscreteEvent->new;
    $model->add('Test::DE::Server');
}
my $handle;
my $count;
$count = Devel::Leak::NoteSV($handle);
{
    my $model = Simulation::DiscreteEvent->new;
    $model->add('Test::DE::Server');
}
is Devel::Leak::CheckSV($handle) - $count, 0, "no leak";


