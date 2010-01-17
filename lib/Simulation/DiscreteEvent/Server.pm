package Simulation::DiscreteEvent::Server;

use Moose;
our $VERSION = '0.02';
use Moose::Util::MetaRole;
BEGIN {
    extends 'MooseX::MethodAttributes::Inheritable';
}
use namespace::clean -except => ['meta'];

=head1 NAME

Simulation::DiscreteEvent::Server - Moose role for implementing servers

=head1 SYNOPSIS

    package MyServer;
    use Moose;
    use parent 'Simulation::DiscreteEvent::Server';
    sub handler1 : Event(start) {
        # handle start event here
    }
    sub handler2 : Event(stop) {
        # handle stop event here
    }
    no Moose;
    __PACKAGE__->meta->make_immutable;

=head1 Description

This is a Moose role that used to implement servers for L<Simulation::DiscreteEvent> models.

=head1 SUBROUTINES/METHODS

=cut

has model => ( is => 'ro', isa => 'Simulation::DiscreteEvent' );

=head2 $self->name([$name])

Allows you to get/set the name of the server

=cut
has name => ( is => 'rw', isa => 'Str' );

=head2 $self->handle($event, @args)

Invokes handler for I<$event> and passes I<@args> as arguments.

=cut
sub handle {
    my $self = shift;
    my $event = shift;
    my $handler = $self->_dispatch($event);
    die "Unknown event type" unless $handler;
    $handler->($self, @_);
}

my $_dispatch_table = {};

sub _dispatch {
    my $self = shift;
    my $event = shift;
    my $class = ref $self;
    unless (defined $_dispatch_table->{$class}) {
        _build_dispatch_table($class);
    }
    $_dispatch_table->{$class}{$event};
}

sub _build_dispatch_table {
    my $class = shift;
    $_dispatch_table->{$class} = {};
    for ( $class->meta->get_all_methods_with_attributes ) {
        my ($handles) = map { /^Event\((.+)\)$/; $1 } grep { /^Event\(.*\)$/ } @{ $_->attributes };
        next unless $handles;
        $_dispatch_table->{$class}{$handles} = $class->can( $_->name );
    }
    return;
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

