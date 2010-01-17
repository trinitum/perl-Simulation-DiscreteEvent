package Simulation::DiscreteEvent::Event;

use Moose;
use Moose::Util::TypeConstraints;
our $VERSION = '0.02';

=head1 NAME

Simulation::DiscreteEvent::Event - module for discrete-event simulation

=head1 SYNOPSIS

    use Simulation::DiscreteEvent::Event;
    my $event = Simulation::DiscreteEvent::Event->new(
        time    => $event_time,
        server  => $server,
        type    => $event_type,
        message => $data,
    );
    $event->handle();

=head1 DESCRIPTION

This module is used internally by L<Simulation::DiscreteEvent>. You generally
have no need to use it.

=head1 SUBROUTINES/METHODS

=cut

subtype EventTime => as Num => where { $_ >= 0 } => message { "Time should be non-negative number" };

=head2 $self->time([$time])

Get/set time of the event

=cut
has time => ( is => 'rw', isa => 'EventTime', required => 1 );

=head2 $self->server([$server])

Get/set server that should handle this event

=cut
has server => ( is => 'rw', isa => 'Simulation::DiscreteEvent::Server', required => 1 );

=head2 $self->type([$type])

Get/set event type

=cut
has type => ( is => 'rw', isa => 'Str', required => 1 );

=head2 $self->message([$message])

Get/set message that should be passed to server's event handler.

=cut
has message => ( is => 'rw' );

=head2 $self->handle

Invoke server's event handler and pass event type and message to it.

=cut
sub handle {
    my $self = shift;
    $self->server->handle($self->type, $self->message);
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;


__END__

=head1 AUTHOR

Pavel Shaydo, C<< <zwon at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-simulation-discreteevent at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Simulation-DiscreteEvent>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Simulation::DiscreteEvent


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Simulation-DiscreteEvent>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Simulation-DiscreteEvent>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Simulation-DiscreteEvent>

=item * Search CPAN

L<http://search.cpan.org/dist/Simulation-DiscreteEvent/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2010 Pavel Shaydo.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

