package Dist::Zilla::MintingProfile::Author::CHIM;

# ABSTRACT: Make new modules like CHIM does

use strict;
use warnings;

our $VERSION = '0.04'; # VERSION
our $AUTHORITY = 'cpan:CHIM'; # AUTHORITY

use Moose;
with 'Dist::Zilla::Role::MintingProfile::ShareDir';

__PACKAGE__->meta->make_immutable;
no Moose;

1; # End of Dist::Zilla::MintingProfile::Author::CHIM

__END__

=pod

=head1 NAME

Dist::Zilla::MintingProfile::Author::CHIM - Make new modules like CHIM does

=head1 VERSION

version 0.04

=head1 DESCRIPTION

This installs a Dist::Zilla minting profile used by CHIM.

=head1 SYNOPSYS

    % dzil new -P Author::CHIM Pretty::Cool::Module

=head1 SEE ALSO

L<Dist::Zilla>

L<Dist::Zilla::PluginBundle::Author::CHIM>

=head1 AUTHOR

Anton Gerasimov <chim@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Anton Gerasimov.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
