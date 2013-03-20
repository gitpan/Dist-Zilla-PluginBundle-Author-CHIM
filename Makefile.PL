
use strict;
use warnings;

use 5.010001;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Dist::Zilla configuration the way CHIM does it",
  "AUTHOR" => "Anton Gerasimov <chim\@cpan.org>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Dist-Zilla-PluginBundle-Author-CHIM",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Dist::Zilla::PluginBundle::Author::CHIM",
  "PREREQ_PM" => {
    "Dist::Zilla" => "4.300030",
    "Dist::Zilla::Plugin::Authority" => "1.006",
    "Dist::Zilla::Plugin::MetaProvides::Package" => "1.14000001",
    "Dist::Zilla::Plugin::OurPkgVersion" => "0.004000",
    "Dist::Zilla::Plugin::PodWeaver" => "3.101641",
    "Dist::Zilla::Plugin::ReadmeAnyFromPod" => "0.120120",
    "Dist::Zilla::Plugin::ReadmeFromPod" => "0.18",
    "Dist::Zilla::Plugin::Test::Compile" => "2.001",
    "Dist::Zilla::Plugin::Test::Kwalitee" => "2.03",
    "Dist::Zilla::Plugin::Test::Version" => "0.002004",
    "Moose" => "2.0",
    "Pod::Coverage::TrustPod" => 0,
    "Test::CPAN::Meta" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.02",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



