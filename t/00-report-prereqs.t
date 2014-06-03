#!perl

use strict;
use warnings;

# This test was generated by Dist::Zilla::Plugin::Test::ReportPrereqs 0.013

use Test::More tests => 1;

use ExtUtils::MakeMaker;
use File::Spec::Functions;
use List::Util qw/max/;
use version;

# hide optional CPAN::Meta modules from prereq scanner
# and check if they are available
my $cpan_meta = "CPAN::Meta";
my $cpan_meta_req = "CPAN::Meta::Requirements";
my $HAS_CPAN_META = eval "require $cpan_meta"; ## no critic
my $HAS_CPAN_META_REQ = eval "require $cpan_meta_req; $cpan_meta_req->VERSION('2.120900')";

# Verify requirements?
my $DO_VERIFY_PREREQS = 1;

sub _merge_requires {
    my ($collector, $prereqs) = @_;
    for my $phase ( qw/configure build test runtime develop/ ) {
        next unless exists $prereqs->{$phase};
        if ( my $req = $prereqs->{$phase}{'requires'} ) {
            my $cmr = CPAN::Meta::Requirements->from_string_hash( $req );
            $collector->add_requirements( $cmr );
        }
    }
}

my %include = map {; $_ => 1 } qw(

);

my %exclude = map {; $_ => 1 } qw(

);

# Add static prereqs to the included modules list
my $static_prereqs = do { my $x = {
       'configure' => {
                        'recommends' => {
                                          'ExtUtils::MakeMaker' => '6.98'
                                        },
                        'requires' => {
                                        'ExtUtils::MakeMaker' => '6.30',
                                        'File::ShareDir::Install' => '0.08'
                                      }
                      },
       'develop' => {
                      'requires' => {
                                      'Dist::Zilla' => '5.019',
                                      'Dist::Zilla::Plugin::Authority' => '0',
                                      'Dist::Zilla::Plugin::AutoPrereqs' => '5.019',
                                      'Dist::Zilla::Plugin::Bootstrap::lib' => '1.000001',
                                      'Dist::Zilla::Plugin::BumpVersionAfterRelease' => '0.002',
                                      'Dist::Zilla::Plugin::CheckPrereqsIndexed' => '0.012',
                                      'Dist::Zilla::Plugin::ConfirmRelease' => '5.019',
                                      'Dist::Zilla::Plugin::EOLTests' => '0.02',
                                      'Dist::Zilla::Plugin::Git::Check' => '2.022',
                                      'Dist::Zilla::Plugin::Git::Commit' => '2.022',
                                      'Dist::Zilla::Plugin::Git::CommitBuild' => '2.022',
                                      'Dist::Zilla::Plugin::Git::GatherDir' => '2.022',
                                      'Dist::Zilla::Plugin::Git::NextRelease' => '0.002010',
                                      'Dist::Zilla::Plugin::Git::Tag' => '2.022',
                                      'Dist::Zilla::Plugin::GithubMeta' => '0.46',
                                      'Dist::Zilla::Plugin::License' => '5.019',
                                      'Dist::Zilla::Plugin::MakeMaker' => '5.019',
                                      'Dist::Zilla::Plugin::Manifest' => '5.019',
                                      'Dist::Zilla::Plugin::ManifestSkip' => '5.019',
                                      'Dist::Zilla::Plugin::MetaConfig' => '5.019',
                                      'Dist::Zilla::Plugin::MetaData::BuiltWith' => '1.000000',
                                      'Dist::Zilla::Plugin::MetaJSON' => '5.019',
                                      'Dist::Zilla::Plugin::MetaProvides::Package' => '2.000001',
                                      'Dist::Zilla::Plugin::MetaTests' => '5.019',
                                      'Dist::Zilla::Plugin::MetaYAML' => '5.019',
                                      'Dist::Zilla::Plugin::MinimumPerl' => '1.003',
                                      'Dist::Zilla::Plugin::ModuleShareDirs' => '5.019',
                                      'Dist::Zilla::Plugin::PodCoverageTests' => '5.019',
                                      'Dist::Zilla::Plugin::PodSyntaxTests' => '5.019',
                                      'Dist::Zilla::Plugin::PodWeaver' => '4.005',
                                      'Dist::Zilla::Plugin::Prereqs' => '5.019',
                                      'Dist::Zilla::Plugin::Prereqs::AuthorDeps' => '0.003',
                                      'Dist::Zilla::Plugin::Prereqs::MatchInstalled::All' => '1.000000',
                                      'Dist::Zilla::Plugin::Prereqs::Recommend::MatchInstalled' => '0.001000',
                                      'Dist::Zilla::Plugin::ReadmeAnyFromPod' => '0.141120',
                                      'Dist::Zilla::Plugin::ReadmeFromPod' => '0.21',
                                      'Dist::Zilla::Plugin::RemovePhasedPrereqs' => '0.002',
                                      'Dist::Zilla::Plugin::RewriteVersion::Sanitized' => '0.001000',
                                      'Dist::Zilla::Plugin::RunExtraTests' => '0.021',
                                      'Dist::Zilla::Plugin::Test::CPAN::Changes' => '0.008',
                                      'Dist::Zilla::Plugin::Test::Compile::PerFile' => '0.002000',
                                      'Dist::Zilla::Plugin::Test::Kwalitee' => '2.07',
                                      'Dist::Zilla::Plugin::Test::MinimumVersion' => '2.000005',
                                      'Dist::Zilla::Plugin::Test::Perl::Critic' => '2.112410',
                                      'Dist::Zilla::Plugin::Test::ReportPrereqs' => '0.013',
                                      'Dist::Zilla::Plugin::TestRelease' => '5.019',
                                      'Dist::Zilla::Plugin::Twitter' => '0.025',
                                      'Dist::Zilla::Plugin::UploadToCPAN' => '5.019',
                                      'Pod::Coverage::TrustPod' => '0.100003',
                                      'Test::CPAN::Changes' => '0.27',
                                      'Test::CPAN::Meta' => '0.23',
                                      'Test::Kwalitee' => '1.18',
                                      'Test::Pod' => '1.48',
                                      'Test::Pod::Coverage' => '1.08'
                                    },
                      'suggests' => {
                                      'Dist::Zilla::App::Command::bakeini' => '0.001000',
                                      'Dist::Zilla::PluginBundle::Author::KENTNL::Lite' => 'v1.7.2'
                                    }
                    },
       'runtime' => {
                      'recommends' => {
                                        'Data::Difference' => '0',
                                        'Dist::Zilla::Plugin::Git::NextVersion::Sanitized' => '0',
                                        'Dist::Zilla::Plugin::MakeMaker' => '0',
                                        'Dist::Zilla::Plugin::ModuleBuild' => '0',
                                        'Dist::Zilla::Plugin::ModuleBuildTiny' => '0',
                                        'Dist::Zilla::Plugin::Prereqs::MatchInstalled' => '0',
                                        'Dist::Zilla::Plugin::Prereqs::Recommend::MatchInstalled' => '0',
                                        'Net::GitHub' => '0',
                                        'Perl::Critic::Bangs' => '0',
                                        'Perl::Critic::Compatibility' => '0',
                                        'Perl::Critic::Deprecated' => '0',
                                        'Perl::Critic::Itch' => '0',
                                        'Perl::Critic::Lax' => '0',
                                        'Perl::Critic::More' => '0',
                                        'Perl::Critic::Policy::Variables::ProhibitUnusedVarsStricter' => '0',
                                        'Perl::Critic::Pulp' => '0',
                                        'Perl::Critic::StricterSubs' => '0',
                                        'Perl::Critic::Swift' => '0',
                                        'Perl::Critic::Tics' => '0'
                                      },
                      'requires' => {
                                      'Carp' => '0',
                                      'Dist::Zilla' => '5.019',
                                      'Dist::Zilla::File::FromCode' => '5.019',
                                      'Dist::Zilla::Plugin::Authority' => '1.006',
                                      'Dist::Zilla::Plugin::AutoPrereqs' => '5.019',
                                      'Dist::Zilla::Plugin::Bootstrap::lib' => '1.000001',
                                      'Dist::Zilla::Plugin::BumpVersionAfterRelease' => '0.002',
                                      'Dist::Zilla::Plugin::ConfirmRelease' => '5.019',
                                      'Dist::Zilla::Plugin::EOLTests' => '0.02',
                                      'Dist::Zilla::Plugin::Git::Check' => '2.022',
                                      'Dist::Zilla::Plugin::Git::Commit' => '2.022',
                                      'Dist::Zilla::Plugin::Git::CommitBuild' => '2.022',
                                      'Dist::Zilla::Plugin::Git::GatherDir' => '2.022',
                                      'Dist::Zilla::Plugin::Git::NextRelease' => '0.002010',
                                      'Dist::Zilla::Plugin::Git::Tag' => '2.022',
                                      'Dist::Zilla::Plugin::GithubMeta' => '0.46',
                                      'Dist::Zilla::Plugin::License' => '5.019',
                                      'Dist::Zilla::Plugin::MakeMaker' => '5.019',
                                      'Dist::Zilla::Plugin::Manifest' => '5.019',
                                      'Dist::Zilla::Plugin::ManifestSkip' => '5.019',
                                      'Dist::Zilla::Plugin::MetaConfig' => '5.019',
                                      'Dist::Zilla::Plugin::MetaData::BuiltWith' => '1.000000',
                                      'Dist::Zilla::Plugin::MetaJSON' => '5.019',
                                      'Dist::Zilla::Plugin::MetaProvides::Package' => '2.000001',
                                      'Dist::Zilla::Plugin::MetaTests' => '5.019',
                                      'Dist::Zilla::Plugin::MetaYAML' => '5.019',
                                      'Dist::Zilla::Plugin::MinimumPerl' => '1.003',
                                      'Dist::Zilla::Plugin::PerlTidy' => '0.16',
                                      'Dist::Zilla::Plugin::PodCoverageTests' => '5.019',
                                      'Dist::Zilla::Plugin::PodSyntaxTests' => '5.019',
                                      'Dist::Zilla::Plugin::PodWeaver' => '4.005',
                                      'Dist::Zilla::Plugin::Prereqs' => '5.019',
                                      'Dist::Zilla::Plugin::Prereqs::Recommend::MatchInstalled' => '0.001000',
                                      'Dist::Zilla::Plugin::ReadmeAnyFromPod' => '0.141120',
                                      'Dist::Zilla::Plugin::ReadmeFromPod' => '0.21',
                                      'Dist::Zilla::Plugin::RewriteVersion::Sanitized' => '0.001000',
                                      'Dist::Zilla::Plugin::RunExtraTests' => '0.021',
                                      'Dist::Zilla::Plugin::Test::CPAN::Changes' => '0.008',
                                      'Dist::Zilla::Plugin::Test::Compile::PerFile' => '0.002000',
                                      'Dist::Zilla::Plugin::Test::Kwalitee' => '2.07',
                                      'Dist::Zilla::Plugin::Test::MinimumVersion' => '2.000005',
                                      'Dist::Zilla::Plugin::Test::Perl::Critic' => '2.112410',
                                      'Dist::Zilla::Plugin::Test::ReportPrereqs' => '0.013',
                                      'Dist::Zilla::Plugin::TestRelease' => '5.019',
                                      'Dist::Zilla::Plugin::Twitter' => '0.025',
                                      'Dist::Zilla::Plugin::UploadToCPAN' => '5.019',
                                      'Dist::Zilla::Role::BundleDeps' => '0.001001',
                                      'Dist::Zilla::Role::FileGatherer' => '5.019',
                                      'Dist::Zilla::Role::MintingProfile::ShareDir' => '5.019',
                                      'Dist::Zilla::Role::PluginBundle' => '5.019',
                                      'Dist::Zilla::Util::CurrentCmd' => '0.001000',
                                      'Dist::Zilla::Util::EmulatePhase' => '1.000000',
                                      'IO::Socket::SSL' => '1.992',
                                      'LWP::Protocol::https' => '6.04',
                                      'Moose' => '2.1208',
                                      'Moose::Util::TypeConstraints' => '2.1208',
                                      'MooseX::AttributeShortcuts' => '0.024',
                                      'MooseX::Has::Sugar' => '1.000000',
                                      'MooseX::StrictConstructor' => '0.19',
                                      'MooseX::Types' => '0.44',
                                      'Net::SSLeay' => '1.63',
                                      'Perl::PrereqScanner' => '1.019',
                                      'Pod::Coverage::TrustPod' => '0.100003',
                                      'Pod::Elemental::PerlMunger' => '0.200002',
                                      'String::Formatter' => '0.102084',
                                      'Test::CPAN::Meta' => '0.23',
                                      'Test::EOL' => '1.5',
                                      'Test::Perl::Critic' => '1.02',
                                      'Test::Pod' => '1.48',
                                      'Test::Pod::Coverage' => '1.08',
                                      'namespace::autoclean' => '0.15',
                                      'perl' => '5.008',
                                      'strict' => '0',
                                      'utf8' => '0',
                                      'version' => '0.9908',
                                      'warnings' => '0'
                                    }
                    },
       'test' => {
                   'recommends' => {
                                     'CPAN::Meta' => '2.141520',
                                     'CPAN::Meta::Requirements' => '2.125',
                                     'ExtUtils::MakeMaker' => '6.98',
                                     'Test::More' => '1.001003'
                                   },
                   'requires' => {
                                   'Capture::Tiny' => '0.24',
                                   'Dist::Zilla::Plugin::Git::NextVersion::Sanitized' => '0',
                                   'Dist::Zilla::Plugin::ModuleBuild' => '0',
                                   'Dist::Zilla::Plugin::Prereqs::MatchInstalled' => '0',
                                   'ExtUtils::MakeMaker' => '0',
                                   'File::Spec::Functions' => '0',
                                   'File::pushd' => '1.007',
                                   'FindBin' => '0',
                                   'Git::Wrapper' => '0.032',
                                   'JSON' => '2.90',
                                   'List::Util' => '1.38',
                                   'Module::Build' => '0',
                                   'Module::Metadata' => '1.000023',
                                   'Path::Class::Dir' => '0.33',
                                   'Path::Tiny' => '0.054',
                                   'Test::DZil' => '5.019',
                                   'Test::Fatal' => '0.013',
                                   'Test::File::ShareDir' => '1.000000',
                                   'Test::More' => '0.89',
                                   'Test::Output' => '1.03',
                                   'lib' => '0'
                                 }
                 }
     };
  $x;
 };

delete $static_prereqs->{develop} if not $ENV{AUTHOR_TESTING};
$include{$_} = 1 for map { keys %$_ } map { values %$_ } values %$static_prereqs;

# Merge requirements for major phases (if we can)
my $all_requires;
if ( $DO_VERIFY_PREREQS && $HAS_CPAN_META_REQ ) {
    $all_requires = $cpan_meta_req->new;
    _merge_requires($all_requires, $static_prereqs);
}


# Add dynamic prereqs to the included modules list (if we can)
my ($source) = grep { -f } 'MYMETA.json', 'MYMETA.yml';
if ( $source && $HAS_CPAN_META ) {
  if ( my $meta = eval { CPAN::Meta->load_file($source) } ) {
    my $dynamic_prereqs = $meta->prereqs;
    delete $dynamic_prereqs->{develop} if not $ENV{AUTHOR_TESTING};
    $include{$_} = 1 for map { keys %$_ } map { values %$_ } values %$dynamic_prereqs;

    if ( $DO_VERIFY_PREREQS && $HAS_CPAN_META_REQ ) {
        _merge_requires($all_requires, $dynamic_prereqs);
    }
  }
}
else {
  $source = 'static metadata';
}

my @modules = sort grep { ! $exclude{$_} } keys %include;
my @reports = [qw/Version Module/];
my @dep_errors;
my $req_hash = defined($all_requires) ? $all_requires->as_string_hash : {};

for my $mod ( @modules ) {
  next if $mod eq 'perl';
  my $file = $mod;
  $file =~ s{::}{/}g;
  $file .= ".pm";
  my ($prefix) = grep { -e catfile($_, $file) } @INC;
  if ( $prefix ) {
    my $ver = MM->parse_version( catfile($prefix, $file) );
    $ver = "undef" unless defined $ver; # Newer MM should do this anyway
    push @reports, [$ver, $mod];

    if ( $DO_VERIFY_PREREQS && $all_requires ) {
      my $req = $req_hash->{$mod};
      if ( defined $req && length $req ) {
        if ( ! defined eval { version->parse($ver) } ) {
          push @dep_errors, "$mod version '$ver' cannot be parsed (version '$req' required)";
        }
        elsif ( ! $all_requires->accepts_module( $mod => $ver ) ) {
          push @dep_errors, "$mod version '$ver' is not in required range '$req'";
        }
      }
    }

  }
  else {
    push @reports, ["missing", $mod];

    if ( $DO_VERIFY_PREREQS && $all_requires ) {
      my $req = $req_hash->{$mod};
      if ( defined $req && length $req ) {
        push @dep_errors, "$mod is not installed (version '$req' required)";
      }
    }
  }
}

if ( @reports ) {
  my $vl = max map { length $_->[0] } @reports;
  my $ml = max map { length $_->[1] } @reports;
  splice @reports, 1, 0, ["-" x $vl, "-" x $ml];
  diag "\nVersions for all modules listed in $source (including optional ones):\n",
    map {sprintf("  %*s %*s\n",$vl,$_->[0],-$ml,$_->[1])} @reports;
}

if ( @dep_errors ) {
  diag join("\n",
    "\n*** WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING ***\n",
    "The following REQUIRED prerequisites were not satisfied:\n",
    @dep_errors,
    "\n"
  );
}

pass;

# vim: ts=4 sts=4 sw=4 et:
