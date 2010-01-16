package Simulation::DiscreteEvent::Server;

use Moose::Role;
our $VERSION = '0.02';

=head1 NAME

Simulation::DiscreteEvent::Server - Moose role for implementing servers

=head1 SYNOPSIS

    package MyServer;
    use Moose;
    with 'Simulation::DiscreteEvent::Server';
    sub _dispatch { { event => \&handler }->{$_[1]} };
    sub handler {
        # handle event here
    }
    no Moose;
    __PACKAGE__->meta->make_immutable;

=head1 Description

This is a Moose role that used to implement servers for L<Simulation::DiscreteEvent> models.

=head1 SUBROUTINES/METHODS

=cut

=head2 _dispatch($event)

Subclasses are required to implement _dispatch. This method takes an event name
as argument and should return reference to event handler, or undef. This is
likely to be replaced in future versions with more convenient mechanism.

=cut
requires '_dispatch';

has model => ( is => 'ro', isa => 'Simulation::DiscreteEvent' );

=head2 name([$name])

Allows you to get/set the name of the server

=cut
has name => ( is => 'rw', isa => 'Str' );

=head2 handle($event, @args)

Invokes handler for I<$event> and passes I<@args> as arguments.

=cut
sub handle {
    my $self = shift;
    my $event = shift;
    my $handler = $self->_dispatch($event);
    die "Unknown event type" unless $handler;
    $handler->($self, @_);
}

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

