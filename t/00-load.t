#!perl -T

use Test::More 0.63;

BEGIN {
    plan tests => 3;
    for ( '', qw(::Server ::Event) ) {
        my $module = "Simulation::DiscreteEvent$_";
        use_ok( $module, 0.03 ) || BAIL_OUT("Failed to load $module");
    }
}

diag("Testing Simulation::DiscreteEvent $Simulation::DiscreteEvent::VERSION, Perl $], $^X");
