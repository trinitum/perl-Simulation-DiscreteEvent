use strict;
use warnings;

use Test::More qw(no_plan);
use Test::Exception;

use ok 'Simulation::DiscreteEvent::Server';

my $invalid_object = {};

{
    package Test::Server;
    use Moose;
    with 'Simulation::DiscreteEvent::Server';
    
    sub type { 'Test Server' };
    sub _dispatch {
        my $self = shift;
        my $event_type = shift;
        if ($event_type eq 'start') {
            return \&start;
        }
        if ($event_type eq 'stop') {
            return \&stop;
        }
        return;
    }
    sub start { return 'Started' }
    sub stop { return $_[1] }
}

my $server = Test::Server->new( 
    name => 'Server1',
);

isa_ok $server, 'Test::Server', 'server is created';
is $server->type, 'Test Server', 'server type is correct';
is $server->handle('start', undef), 'Started', 'start event is handled correctly';
is $server->handle('stop', 'Stopped'), 'Stopped', 'stop event is handled correctly';
throws_ok { $server->handle('die', undef) } qr/unknown event/i, 'server has died on unknown event type';

