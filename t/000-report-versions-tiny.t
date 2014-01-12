use strict;
use warnings;
use Test::More 0.88;
# This is a relatively nice way to avoid Test::NoWarnings breaking our
# expectations by adding extra tests, without using no_plan.  It also helps
# avoid any other test module that feels introducing random tests, or even
# test plans, is a nice idea.
our $success = 0;
END { $success && done_testing; }

# List our own version used to generate this
my $v = "\nGenerated by Dist::Zilla::Plugin::ReportVersions::Tiny v1.10\n";

eval {                     # no excuses!
    # report our Perl details
    my $want = '5.008';
    $v .= "perl: $] (wanted $want) on $^O from $^X\n\n";
};
defined($@) and diag("$@");

# Now, our module version dependencies:
sub pmver {
    my ($module, $wanted) = @_;
    $wanted = " (want $wanted)";
    my $pmver;
    eval "require $module;";
    if ($@) {
        if ($@ =~ m/Can't locate .* in \@INC/) {
            $pmver = 'module not found.';
        } else {
            diag("${module}: $@");
            $pmver = 'died during require.';
        }
    } else {
        my $version;
        eval { $version = $module->VERSION; };
        if ($@) {
            diag("${module}: $@");
            $pmver = 'died during VERSION check.';
        } elsif (defined $version) {
            $pmver = "$version";
        } else {
            $pmver = '<undef>';
        }
    }

    # So, we should be good, right?
    return sprintf('%-45s => %-10s%-15s%s', $module, $pmver, $wanted, "\n");
}

eval { $v .= pmver('Capture::Tiny','0.23') };
eval { $v .= pmver('Carp','any version') };
eval { $v .= pmver('Dist::Zilla','5.010') };
eval { $v .= pmver('Dist::Zilla::File::FromCode','5.010') };
eval { $v .= pmver('Dist::Zilla::Plugin::Authority','1.006') };
eval { $v .= pmver('Dist::Zilla::Plugin::AutoPrereqs','5.010') };
eval { $v .= pmver('Dist::Zilla::Plugin::Bootstrap::lib','0.04000002') };
eval { $v .= pmver('Dist::Zilla::Plugin::ConfirmRelease','5.010') };
eval { $v .= pmver('Dist::Zilla::Plugin::EOLTests','0.02') };
eval { $v .= pmver('Dist::Zilla::Plugin::Git::Check','2.019') };
eval { $v .= pmver('Dist::Zilla::Plugin::Git::Commit','2.019') };
eval { $v .= pmver('Dist::Zilla::Plugin::Git::CommitBuild','2.019') };
eval { $v .= pmver('Dist::Zilla::Plugin::Git::GatherDir','2.019') };
eval { $v .= pmver('Dist::Zilla::Plugin::Git::NextRelease','0.001000') };
eval { $v .= pmver('Dist::Zilla::Plugin::Git::NextVersion::Sanitized','0.001000') };
eval { $v .= pmver('Dist::Zilla::Plugin::Git::Tag','2.019') };
eval { $v .= pmver('Dist::Zilla::Plugin::GithubMeta','0.42') };
eval { $v .= pmver('Dist::Zilla::Plugin::License','5.010') };
eval { $v .= pmver('Dist::Zilla::Plugin::Manifest','5.010') };
eval { $v .= pmver('Dist::Zilla::Plugin::ManifestSkip','5.010') };
eval { $v .= pmver('Dist::Zilla::Plugin::MetaConfig','5.010') };
eval { $v .= pmver('Dist::Zilla::Plugin::MetaData::BuiltWith','0.04000002') };
eval { $v .= pmver('Dist::Zilla::Plugin::MetaJSON','5.010') };
eval { $v .= pmver('Dist::Zilla::Plugin::MetaProvides::Package','1.15000002') };
eval { $v .= pmver('Dist::Zilla::Plugin::MetaTests','5.010') };
eval { $v .= pmver('Dist::Zilla::Plugin::MetaYAML','5.010') };
eval { $v .= pmver('Dist::Zilla::Plugin::MinimumPerl','1.003') };
eval { $v .= pmver('Dist::Zilla::Plugin::ModuleBuild','5.010') };
eval { $v .= pmver('Dist::Zilla::Plugin::PerlTidy','0.14') };
eval { $v .= pmver('Dist::Zilla::Plugin::PkgVersion','5.010') };
eval { $v .= pmver('Dist::Zilla::Plugin::PodCoverageTests','5.010') };
eval { $v .= pmver('Dist::Zilla::Plugin::PodSyntaxTests','5.010') };
eval { $v .= pmver('Dist::Zilla::Plugin::PodWeaver','4.005') };
eval { $v .= pmver('Dist::Zilla::Plugin::Prereqs','5.010') };
eval { $v .= pmver('Dist::Zilla::Plugin::Prereqs::MatchInstalled','v0.1.6') };
eval { $v .= pmver('Dist::Zilla::Plugin::ReadmeAnyFromPod','0.133360') };
eval { $v .= pmver('Dist::Zilla::Plugin::ReadmeFromPod','0.21') };
eval { $v .= pmver('Dist::Zilla::Plugin::ReportVersions::Tiny','1.10') };
eval { $v .= pmver('Dist::Zilla::Plugin::RunExtraTests','0.016') };
eval { $v .= pmver('Dist::Zilla::Plugin::Test::CPAN::Changes','0.008') };
eval { $v .= pmver('Dist::Zilla::Plugin::Test::Compile::PerFile','0.001001') };
eval { $v .= pmver('Dist::Zilla::Plugin::Test::Kwalitee','2.07') };
eval { $v .= pmver('Dist::Zilla::Plugin::Test::MinimumVersion','2.000005') };
eval { $v .= pmver('Dist::Zilla::Plugin::Test::Perl::Critic','2.112410') };
eval { $v .= pmver('Dist::Zilla::Plugin::TestRelease','5.010') };
eval { $v .= pmver('Dist::Zilla::Plugin::Twitter','0.024') };
eval { $v .= pmver('Dist::Zilla::Plugin::UploadToCPAN','5.010') };
eval { $v .= pmver('Dist::Zilla::Role::BundleDeps','0.001001') };
eval { $v .= pmver('Dist::Zilla::Role::FileGatherer','5.010') };
eval { $v .= pmver('Dist::Zilla::Role::MintingProfile::ShareDir','5.010') };
eval { $v .= pmver('Dist::Zilla::Role::PluginBundle','5.010') };
eval { $v .= pmver('Dist::Zilla::Util::EmulatePhase','0.01025803') };
eval { $v .= pmver('File::pushd','1.005') };
eval { $v .= pmver('FindBin','any version') };
eval { $v .= pmver('Git::Wrapper','0.030') };
eval { $v .= pmver('IO::Socket::SSL','1.962') };
eval { $v .= pmver('JSON','2.90') };
eval { $v .= pmver('LWP::Protocol::https','6.04') };
eval { $v .= pmver('Module::Build','0.4204') };
eval { $v .= pmver('Module::Metadata','1.000019') };
eval { $v .= pmver('Moose','2.1201') };
eval { $v .= pmver('Moose::Util::TypeConstraints','2.1201') };
eval { $v .= pmver('MooseX::AttributeShortcuts','0.022') };
eval { $v .= pmver('MooseX::Has::Sugar','0.05070422') };
eval { $v .= pmver('MooseX::StrictConstructor','0.19') };
eval { $v .= pmver('MooseX::Types','0.41') };
eval { $v .= pmver('Net::SSLeay','1.57') };
eval { $v .= pmver('Path::Class::Dir','0.33') };
eval { $v .= pmver('Path::Tiny','0.051') };
eval { $v .= pmver('Perl::PrereqScanner','1.019') };
eval { $v .= pmver('Pod::Coverage::TrustPod','0.100003') };
eval { $v .= pmver('Pod::Elemental::PerlMunger','0.200000') };
eval { $v .= pmver('String::Formatter','0.102084') };
eval { $v .= pmver('Test::CPAN::Meta','0.23') };
eval { $v .= pmver('Test::DZil','5.010') };
eval { $v .= pmver('Test::EOL','1.5') };
eval { $v .= pmver('Test::Fatal','0.013') };
eval { $v .= pmver('Test::File::ShareDir','v0.4.1') };
eval { $v .= pmver('Test::More','1.001002') };
eval { $v .= pmver('Test::Output','1.03') };
eval { $v .= pmver('Test::Perl::Critic','1.02') };
eval { $v .= pmver('Test::Pod','1.48') };
eval { $v .= pmver('Test::Pod::Coverage','1.08') };
eval { $v .= pmver('lib','any version') };
eval { $v .= pmver('namespace::autoclean','0.15') };
eval { $v .= pmver('strict','any version') };
eval { $v .= pmver('utf8','any version') };
eval { $v .= pmver('version','0.9906') };
eval { $v .= pmver('warnings','any version') };


# All done.
$v .= <<'EOT';

Thanks for using my code.  I hope it works for you.
If not, please try and include this output in the bug report.
That will help me reproduce the issue and solve your problem.

EOT

diag($v);
ok(1, "we really didn't test anything, just reporting data");
$success = 1;

# Work around another nasty module on CPAN. :/
no warnings 'once';
$Template::Test::NO_FLUSH = 1;
exit 0;
