
use strict;
use warnings;

use 5.008009;

use ExtUtils::MakeMaker 6.30;

use File::ShareDir::Install;
install_share module => "Dist::Zilla::MintingProfile::Author::CHIM", "profiles";


my %WriteMakefileArgs = (
  "ABSTRACT" => "Dist::Zilla configuration the way CHIM does it",
  "AUTHOR" => "Anton Gerasimov <chim\@cpan.org>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30",
    "File::ShareDir::Install" => "0.03"
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
    "Dist::Zilla::Plugin::Test::EOL" => "0.08",
    "Dist::Zilla::Plugin::Test::Kwalitee" => "2.03",
    "Dist::Zilla::Plugin::Test::NoTabs" => "0.04",
    "Dist::Zilla::Plugin::Test::Version" => "0.002004",
    "Moose" => "2.0",
    "Pod::Coverage::TrustPod" => 0,
    "Test::CPAN::Meta" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "File::Temp" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => 0
  },
  "VERSION" => "0.04",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  my $tr = delete $WriteMakefileArgs{TEST_REQUIRES};
  my $br = $WriteMakefileArgs{BUILD_REQUIRES};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

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

{
package
MY;
use File::ShareDir::Install qw(postamble);
}


