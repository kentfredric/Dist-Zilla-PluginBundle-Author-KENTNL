
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.014.
use strict;
use warnings;

use 5.008;

use ExtUtils::MakeMaker 6.30;

use File::ShareDir::Install;
install_share module => "Dist::Zilla::MintingProfile::Author::KENTNL", "share\/profiles";


my %WriteMakefileArgs = (
  "ABSTRACT" => "BeLike::KENTNL when you build your distributions.",
  "AUTHOR" => "Kent Fredric <kentnl\@cpan.org>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30",
    "File::ShareDir::Install" => "0.08"
  },
  "DISTNAME" => "Dist-Zilla-PluginBundle-Author-KENTNL",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Dist::Zilla::PluginBundle::Author::KENTNL",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Dist::Zilla" => "5.014",
    "Dist::Zilla::File::FromCode" => "5.014",
    "Dist::Zilla::Plugin::Authority" => "1.006",
    "Dist::Zilla::Plugin::AutoPrereqs" => "5.014",
    "Dist::Zilla::Plugin::Bootstrap::lib" => "0.04000002",
    "Dist::Zilla::Plugin::ConfirmRelease" => "5.014",
    "Dist::Zilla::Plugin::EOLTests" => "0.02",
    "Dist::Zilla::Plugin::Git::Check" => "2.020",
    "Dist::Zilla::Plugin::Git::Commit" => "2.020",
    "Dist::Zilla::Plugin::Git::CommitBuild" => "2.020",
    "Dist::Zilla::Plugin::Git::GatherDir" => "2.020",
    "Dist::Zilla::Plugin::Git::NextRelease" => "0.002010",
    "Dist::Zilla::Plugin::Git::NextVersion::Sanitized" => "0.001000",
    "Dist::Zilla::Plugin::Git::Tag" => "2.020",
    "Dist::Zilla::Plugin::GithubMeta" => "0.42",
    "Dist::Zilla::Plugin::License" => "5.014",
    "Dist::Zilla::Plugin::MakeMaker" => "5.014",
    "Dist::Zilla::Plugin::Manifest" => "5.014",
    "Dist::Zilla::Plugin::ManifestSkip" => "5.014",
    "Dist::Zilla::Plugin::MetaConfig" => "5.014",
    "Dist::Zilla::Plugin::MetaData::BuiltWith" => "0.04000002",
    "Dist::Zilla::Plugin::MetaJSON" => "5.014",
    "Dist::Zilla::Plugin::MetaProvides::Package" => "2.000001",
    "Dist::Zilla::Plugin::MetaTests" => "5.014",
    "Dist::Zilla::Plugin::MetaYAML" => "5.014",
    "Dist::Zilla::Plugin::MinimumPerl" => "1.003",
    "Dist::Zilla::Plugin::PerlTidy" => "0.15",
    "Dist::Zilla::Plugin::PkgVersion" => "5.014",
    "Dist::Zilla::Plugin::PodCoverageTests" => "5.014",
    "Dist::Zilla::Plugin::PodSyntaxTests" => "5.014",
    "Dist::Zilla::Plugin::PodWeaver" => "4.005",
    "Dist::Zilla::Plugin::Prereqs" => "5.014",
    "Dist::Zilla::Plugin::Prereqs::Recommend::MatchInstalled" => "0.001000",
    "Dist::Zilla::Plugin::ReadmeAnyFromPod" => "0.133360",
    "Dist::Zilla::Plugin::ReadmeFromPod" => "0.21",
    "Dist::Zilla::Plugin::RunExtraTests" => "0.018",
    "Dist::Zilla::Plugin::Test::CPAN::Changes" => "0.008",
    "Dist::Zilla::Plugin::Test::Compile::PerFile" => "0.001001",
    "Dist::Zilla::Plugin::Test::Kwalitee" => "2.07",
    "Dist::Zilla::Plugin::Test::MinimumVersion" => "2.000005",
    "Dist::Zilla::Plugin::Test::Perl::Critic" => "2.112410",
    "Dist::Zilla::Plugin::Test::ReportPrereqs" => "0.013",
    "Dist::Zilla::Plugin::TestRelease" => "5.014",
    "Dist::Zilla::Plugin::Twitter" => "0.025",
    "Dist::Zilla::Plugin::UploadToCPAN" => "5.014",
    "Dist::Zilla::Role::BundleDeps" => "0.001001",
    "Dist::Zilla::Role::FileGatherer" => "5.014",
    "Dist::Zilla::Role::MintingProfile::ShareDir" => "5.014",
    "Dist::Zilla::Role::PluginBundle" => "5.014",
    "Dist::Zilla::Util::EmulatePhase" => "0.01025803",
    "IO::Socket::SSL" => "1.969",
    "LWP::Protocol::https" => "6.04",
    "Moose" => "2.1204",
    "Moose::Util::TypeConstraints" => "2.1204",
    "MooseX::AttributeShortcuts" => "0.022",
    "MooseX::Has::Sugar" => "1.000000",
    "MooseX::StrictConstructor" => "0.19",
    "MooseX::Types" => "0.44",
    "Net::SSLeay" => "1.58",
    "Perl::PrereqScanner" => "1.019",
    "Pod::Coverage::TrustPod" => "0.100003",
    "Pod::Elemental::PerlMunger" => "0.200001",
    "String::Formatter" => "0.102084",
    "Test::CPAN::Meta" => "0.23",
    "Test::EOL" => "1.5",
    "Test::Perl::Critic" => "1.02",
    "Test::Pod" => "1.48",
    "Test::Pod::Coverage" => "1.08",
    "namespace::autoclean" => "0.15",
    "strict" => 0,
    "utf8" => 0,
    "version" => "0.9908",
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Capture::Tiny" => "0.24",
    "Dist::Zilla::Plugin::ModuleBuild" => 0,
    "Dist::Zilla::Plugin::Prereqs::MatchInstalled" => 0,
    "ExtUtils::MakeMaker" => 0,
    "File::Spec::Functions" => 0,
    "File::pushd" => "1.005",
    "FindBin" => 0,
    "Git::Wrapper" => "0.031",
    "JSON" => "2.90",
    "List::Util" => "1.38",
    "Module::Build" => 0,
    "Module::Metadata" => "1.000019",
    "Path::Class::Dir" => "0.33",
    "Path::Tiny" => "0.052",
    "Test::DZil" => "5.014",
    "Test::Fatal" => "0.013",
    "Test::File::ShareDir" => "1.000000",
    "Test::More" => "0.89",
    "Test::Output" => "1.03",
    "lib" => 0
  },
  "VERSION" => "2.012001",
  "test" => {
    "TESTS" => "t/*.t t/00-compile/*.t"
  }
);


my %FallbackPrereqs = (
  "Capture::Tiny" => "0.24",
  "Carp" => 0,
  "Dist::Zilla" => "5.014",
  "Dist::Zilla::File::FromCode" => "5.014",
  "Dist::Zilla::Plugin::Authority" => "1.006",
  "Dist::Zilla::Plugin::AutoPrereqs" => "5.014",
  "Dist::Zilla::Plugin::Bootstrap::lib" => "0.04000002",
  "Dist::Zilla::Plugin::ConfirmRelease" => "5.014",
  "Dist::Zilla::Plugin::EOLTests" => "0.02",
  "Dist::Zilla::Plugin::Git::Check" => "2.020",
  "Dist::Zilla::Plugin::Git::Commit" => "2.020",
  "Dist::Zilla::Plugin::Git::CommitBuild" => "2.020",
  "Dist::Zilla::Plugin::Git::GatherDir" => "2.020",
  "Dist::Zilla::Plugin::Git::NextRelease" => "0.002010",
  "Dist::Zilla::Plugin::Git::NextVersion::Sanitized" => "0.001000",
  "Dist::Zilla::Plugin::Git::Tag" => "2.020",
  "Dist::Zilla::Plugin::GithubMeta" => "0.42",
  "Dist::Zilla::Plugin::License" => "5.014",
  "Dist::Zilla::Plugin::MakeMaker" => "5.014",
  "Dist::Zilla::Plugin::Manifest" => "5.014",
  "Dist::Zilla::Plugin::ManifestSkip" => "5.014",
  "Dist::Zilla::Plugin::MetaConfig" => "5.014",
  "Dist::Zilla::Plugin::MetaData::BuiltWith" => "0.04000002",
  "Dist::Zilla::Plugin::MetaJSON" => "5.014",
  "Dist::Zilla::Plugin::MetaProvides::Package" => "2.000001",
  "Dist::Zilla::Plugin::MetaTests" => "5.014",
  "Dist::Zilla::Plugin::MetaYAML" => "5.014",
  "Dist::Zilla::Plugin::MinimumPerl" => "1.003",
  "Dist::Zilla::Plugin::ModuleBuild" => 0,
  "Dist::Zilla::Plugin::PerlTidy" => "0.15",
  "Dist::Zilla::Plugin::PkgVersion" => "5.014",
  "Dist::Zilla::Plugin::PodCoverageTests" => "5.014",
  "Dist::Zilla::Plugin::PodSyntaxTests" => "5.014",
  "Dist::Zilla::Plugin::PodWeaver" => "4.005",
  "Dist::Zilla::Plugin::Prereqs" => "5.014",
  "Dist::Zilla::Plugin::Prereqs::MatchInstalled" => 0,
  "Dist::Zilla::Plugin::Prereqs::Recommend::MatchInstalled" => "0.001000",
  "Dist::Zilla::Plugin::ReadmeAnyFromPod" => "0.133360",
  "Dist::Zilla::Plugin::ReadmeFromPod" => "0.21",
  "Dist::Zilla::Plugin::RunExtraTests" => "0.018",
  "Dist::Zilla::Plugin::Test::CPAN::Changes" => "0.008",
  "Dist::Zilla::Plugin::Test::Compile::PerFile" => "0.001001",
  "Dist::Zilla::Plugin::Test::Kwalitee" => "2.07",
  "Dist::Zilla::Plugin::Test::MinimumVersion" => "2.000005",
  "Dist::Zilla::Plugin::Test::Perl::Critic" => "2.112410",
  "Dist::Zilla::Plugin::Test::ReportPrereqs" => "0.013",
  "Dist::Zilla::Plugin::TestRelease" => "5.014",
  "Dist::Zilla::Plugin::Twitter" => "0.025",
  "Dist::Zilla::Plugin::UploadToCPAN" => "5.014",
  "Dist::Zilla::Role::BundleDeps" => "0.001001",
  "Dist::Zilla::Role::FileGatherer" => "5.014",
  "Dist::Zilla::Role::MintingProfile::ShareDir" => "5.014",
  "Dist::Zilla::Role::PluginBundle" => "5.014",
  "Dist::Zilla::Util::EmulatePhase" => "0.01025803",
  "ExtUtils::MakeMaker" => 0,
  "File::Spec::Functions" => 0,
  "File::pushd" => "1.005",
  "FindBin" => 0,
  "Git::Wrapper" => "0.031",
  "IO::Socket::SSL" => "1.969",
  "JSON" => "2.90",
  "LWP::Protocol::https" => "6.04",
  "List::Util" => "1.38",
  "Module::Build" => 0,
  "Module::Metadata" => "1.000019",
  "Moose" => "2.1204",
  "Moose::Util::TypeConstraints" => "2.1204",
  "MooseX::AttributeShortcuts" => "0.022",
  "MooseX::Has::Sugar" => "1.000000",
  "MooseX::StrictConstructor" => "0.19",
  "MooseX::Types" => "0.44",
  "Net::SSLeay" => "1.58",
  "Path::Class::Dir" => "0.33",
  "Path::Tiny" => "0.052",
  "Perl::PrereqScanner" => "1.019",
  "Pod::Coverage::TrustPod" => "0.100003",
  "Pod::Elemental::PerlMunger" => "0.200001",
  "String::Formatter" => "0.102084",
  "Test::CPAN::Meta" => "0.23",
  "Test::DZil" => "5.014",
  "Test::EOL" => "1.5",
  "Test::Fatal" => "0.013",
  "Test::File::ShareDir" => "1.000000",
  "Test::More" => "0.89",
  "Test::Output" => "1.03",
  "Test::Perl::Critic" => "1.02",
  "Test::Pod" => "1.48",
  "Test::Pod::Coverage" => "1.08",
  "lib" => 0,
  "namespace::autoclean" => "0.15",
  "strict" => 0,
  "utf8" => 0,
  "version" => "0.9908",
  "warnings" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

{
package
MY;
use File::ShareDir::Install qw(postamble);
}

