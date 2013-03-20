package Dist::Zilla::PluginBundle::Author::CHIM;

# ABSTRACT: Dist::Zilla configuration the way CHIM does it
our $AUTHORITY = 'cpan:CHIM'; # AUTHORITY
our $VERSION = '0.02'; # VERSION

use strict;
use warnings;
use Moose;

use Dist::Zilla 4.3;
with 'Dist::Zilla::Role::PluginBundle::Easy';

has dist => (
    is       => 'ro',
    isa      => 'Str',
    lazy     => 1,
    default  => sub { $_[0]->payload->{dist} },
);

has authority => (
    is       => 'ro',
    isa      => 'Str',
    lazy     => 1,
    default  => sub { $_[0]->payload->{authority} || 'cpan:CHIM' },
);

has github_username => (
    is       => 'ro',
    isa      => 'Str',
    lazy     => 1,
    default  => sub { $_[0]->payload->{github_username} || 'Wu-Wu' },
);

has github_reponame => (
    is       => 'ro',
    isa      => 'Str',
    lazy     => 1,
    default  => sub { $_[0]->payload->{github_reponame} || $_[0]->dist },
);

has github_repopath => (
    is       => 'ro',
    isa      => 'Str',
    lazy     => 1,
    default  => sub { join '/' => 'github.com', $_[0]->github_username, $_[0]->github_reponame },
);

sub configure {
    my ($self) = @_;

    $self->add_plugins(
        [ 'GatherDir'               => {} ],
        [ 'PruneCruft'              => {} ],

        # modified files
        [ 'OurPkgVersion'           => {} ],
        [ 'PodWeaver'               => {} ],
        [ 'NextRelease'             => {
                'time_zone' => 'UTC',
                'format'    => '%-7v %{EEE MMM d HH:mm:ss yyyy ZZZ}d'
            }
        ],
        [ 'Authority'               => {
                'authority'      => $self->authority,
                'do_metadata'    => 1,
                'locate_comment' => 1,
            }
        ],

        # generated files
        [ 'License'                 => {} ],
        [ 'ReadmeFromPod'           => {} ],
        [ 'ReadmeAnyFromPod'        => {} ],
        [ 'ReadmeAnyFromPod'        =>
            'ReadmePodInRoot' => {
                'type'     => 'pod',
                'filename' => 'README.pod',
                'location' => 'root',
            },
        ],

        [ 'MetaNoIndex'             => {
                'directory' => [qw(t xt eg examples corpus)],
                'package'   => [qw(DB)],
                'namespace' => [qw(t::lib)],
            },
        ],

        # set META resources
        [ 'MetaResources'           => {
                'homepage'        => 'https://metacpan.org/release/' . $self->dist,
                'repository.url'  => 'git://'   . $self->github_repopath . '.git',
                'repository.web'  => 'https://' . $self->github_repopath,
                'bugtracker.web'  => 'https://' . $self->github_repopath . '/issues',
                'repository.type' => 'git',
            },
        ],

        # add 'provides' to META
        [ 'MetaProvides::Package'   => {
                'meta_noindex' => 1,
            },
        ],

        # META files
        [ 'MetaYAML'                => {} ],
        [ 'MetaJSON'                => {} ],

        # t tests
        [ 'Test::Compile'           => {
                'fake_home' => 1
            }
        ],

        # xt tests
        [ 'ExtraTests'              => {} ],
        [ 'MetaTests'               => {} ],
        [ 'PodSyntaxTests'          => {} ],
        [ 'PodCoverageTests'        => {} ],
        [ 'Test::Version'           => {} ],
        [ 'Test::Kwalitee'          => {} ],

        # build
        [ 'MakeMaker'               => {} ],
        [ 'Manifest'                => {} ],

        # release
        [ 'ConfirmRelease'          => {} ],
        [ 'UploadToCPAN'            => {} ],

    );
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::PluginBundle::Author::CHIM - Dist::Zilla configuration the way CHIM does it

=head1 VERSION

version 0.02

=head1 DESCRIPTION

This is a L<Dist::Zilla> PluginBundle. It is roughly equivalent to the
following dist.ini:

    [GatherDir]
    [PruneCruft]

    ;; modified files
    [OurPkgVersion]
    [PodWeaver]
    [NextRelease]
    time_zone = UTC
    format    = %-7v %{EEE MMM d HH:mm:ss yyyy ZZZ}d
    [Authority]
    authority      = %{authority}
    do_metadata    = 1
    locate_comment = 1

    ;; generated files
    [License]
    [ReadmeFromPod]
    [ReadmeAnyFromPod]
    [ReadmeAnyFromPod / ReadmePodInRoot]
    type     = pod
    filename = README.pod
    location = root

    [MetaNoIndex]
    directory = t
    directory = xt
    directory = eg
    directory = examples
    directory = corpus
    package   = DB
    namespace = t::lib

    ;; set META resources
    [MetaResources]
    homepage        = https://metacpan.org/release/%{dist}
    repository.url  = git://%{github_repopath}.git
    repository.web  = https://%{github_repopath}
    bugtracker.web  = https://%{github_repopath}/issues
    repository.type = git

    ;; add 'provides' to META
    [MetaProvides::Package]
    meta_noindex = 1

    ;; META files
    [MetaYAML]
    [MetaJSON]

    ;; t tests
    [Test::Compile]
    fake_home = 1

    ;; xt tests
    [ExtraTests]
    [MetaTests]
    [PodSyntaxTests]
    [PodCoverageTests]
    [Test::Version]
    [Test::Kwalitee]

    ;; build
    [MakeMaker]
    [Manifest]

    ;; release
    [ConfirmRelease]
    [UploadToCPAN]

=head1 SYNOPSYS

    # in dist.ini
    [@Author::CHIM]
    dist            = My-Very-Cool-Module
    authority       = cpan:CHIM
    github_username = Wu-Wu
    github_reponame = perl5-My-Very-Cool-Module

=head1 ATTRIBUTES

=head2 dist

The name of the distribution. Required.

=head2 authority

This one is used to set name the CPAN author of the distibution. It should be something like C<cpan:PAUSEID>.
Default value is I<cpan:CHIM>.

=head2 github_username

Indicates github.com's account name. Default value is I<Wu-Wu>.

=head2 github_reponame

Indicates github.com's repository name. Default value is set to value of the I<dist>-attribute name.

=head1 METHODS

=head2 configure

Bundle's configuration for role L<Dist::Zilla::Role::PluginBundle::Easy>.

=head1 SEE ALSO

L<Dist::Zilla>

L<Dist::Zilla::Role::PluginBundle::Easy>

L<Dist::Zilla::Plugin::Authority>

=head1 AUTHOR

Anton Gerasimov <chim@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Anton Gerasimov.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
