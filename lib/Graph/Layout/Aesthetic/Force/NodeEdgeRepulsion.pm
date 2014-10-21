package Graph::Layout::Aesthetic::Force::NodeEdgeRepulsion;
use 5.006001;
use strict;
use warnings;

our $VERSION = '0.01';
use base qw(Graph::Layout::Aesthetic::Force);

__PACKAGE__->new->register;

1;
__END__

=head1 NAME

Graph::Layout::Aesthetic::Force::NodeEdgeRepulsion - nodes repel each other

=head1 SYNOPSIS

  use Graph::Layout::Aesthetic;
  $aglo = Graph::Layout::Aesthetic->new($topology);
  $aglo->add_force("NodeEdgeRepulsion", 1);

=head1 DESCRIPTION

This module provides an aesthetic force for use by the 
L<Graph::Layout::Aesthetic package|Graph::Layout::Aesthetic>. It's normally
implicitly loaded by using L<add_force|Graph::Layout::Aesthetic/add_force>.

The aesthetic force is that it tries to not place nodes close to edges. It does
this by imagining a line through the edge endpoints and finding the point on
the line closest to the node under consideration. If this point is between the 
two edge endpoints there is a force between them that's the inverse of their
distance.

=head1 METHODS

This class inherits from 
L<Graph::Layout::Aesthetic::Force|Graph::Layout::Aesthetic::Force> and adds
no methods of its own.

=head1 EXPORT

None.

=head1 SEE ALSO

L<Graph::Layout::Aesthetic>,
L<Graph::Layout::Aesthetic::Force>

=head1 AUTHOR

Ton Hospel, E<lt>Graph::Layout::Aesthetic@ton.iguana.be<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2004 by Ton Hospel

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.6.1 or,
at your option, any later version of Perl 5 you may have available.

Much of the underlying XS code is derived from C code copyrighted by
D. Stott Parker, who released it under the GNU GENERAL PUBLIC LICENSE
(version 1).

=cut
