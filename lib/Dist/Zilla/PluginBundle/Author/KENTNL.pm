use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Dist::Zilla::PluginBundle::Author::KENTNL;

# ABSTRACT: BeLike::KENTNL when you build your distributions.

our $VERSION = '2.017001';

our $AUTHORITY = 'cpan:KENTNL'; # AUTHORITY

use Moose qw( with has );
use Moose::Util::TypeConstraints qw(enum);
use MooseX::StrictConstructor;
use MooseX::AttributeShortcuts;
use Dist::Zilla::Util::CurrentCmd qw( current_cmd );

with 'Dist::Zilla::Role::PluginBundle';
with 'Dist::Zilla::Role::BundleDeps';

use namespace::autoclean;

























sub mvp_multivalue_args { return qw( auto_prereqs_skip copyfiles ) }











has 'plugins' => ( 'is' => 'ro' =>, 'isa' => 'ArrayRef', 'init_arg' => undef, 'lazy' => 1, 'builder' => sub { [] } );











has 'normal_form' => ( 'is' => ro =>, 'isa' => 'Str', 'required' => 1 );    #builder => sub { 'numify' } );











has 'mantissa' => (
  'is'      => ro =>,
  'isa'     => 'Int',
  'lazy'    => 1,
  'builder' => sub {
    my ($self) = @_;
    if ( 'numify' eq $self->normal_form ) {
      require Carp;
      return Carp::croak('mantissa required but not specified');
    }
    return 6;
  },
);




















has 'git_versions' => ( is => 'ro', isa => enum( [1] ), required => 1, );









has 'authority' => ( is => 'ro', isa => 'Str', lazy => 1, builder => sub { 'cpan:KENTNL' }, );









has 'auto_prereqs_skip' => (
  is        => 'ro',
  isa       => 'ArrayRef',
  predicate => 'has_auto_prereqs_skip',
  lazy      => 1,
  builder   => sub { [] },
);









has 'twitter_extra_hash_tags' => (
  is        => 'ro',
  'isa'     => 'Str',
  lazy      => 1,
  predicate => 'has_twitter_extra_hash_tags',
  builder   => sub { q[] },
);









has 'twitter_hash_tags' => (
  is      => 'ro',
  isa     => 'Str',
  lazy    => 1,
  builder => sub {
    my ($self) = @_;
    return '#perl #cpan' unless $self->has_twitter_extra_hash_tags;

    return '#perl #cpan ' . $self->twitter_extra_hash_tags;
  },
);









has 'tweet_url' => (
  is      => 'ro',
  isa     => 'Str',
  lazy    => 1,
  builder => sub {
    ## no critic (RequireInterpolationOfMetachars)
    return q[https://metacpan.org/release/{{$AUTHOR_UC}}/{{$DIST}}-{{$VERSION}}{{$TRIAL}}#whatsnew];
  },
);





















has 'toolkit_hardness' => (
  is => ro =>,
  isa => enum( [ 'hard', 'soft' ] ),
  lazy    => 1,
  builder => sub { 'hard' },
);



















has 'toolkit' => (
  is => ro =>,
  isa => enum( [ 'mb', 'mbtiny', 'eumm' ] ),
  lazy    => 1,
  builder => sub { 'mb' },
);










has 'bumpversions' => (
  is      => ro  =>,
  isa     => 'Bool',
  lazy    => 1,
  builder => sub { undef },
);













has copyfiles => (
  is      => ro  =>,
  isa     => 'ArrayRef[ Str ]',
  lazy    => 1,
  builder => sub { [] },
);









has srcreadme => (
  is => ro =>,
  isa => enum( [ 'pod', 'mkdn', 'none' ] ),
  lazy    => 1,
  builder => sub { return 'mkdn'; },
);







sub add_plugin {
  my ( $self, $suffix, $conf ) = @_;
  if ( not defined $conf ) {
    $conf = {};
  }
  if ( not ref $conf or not 'HASH' eq ref $conf ) {
    require Carp;
    Carp::croak('Conf must be a hash');
  }
  ## no critic (RequireInterpolationOfMetachars)
  push @{ $self->plugins }, [ q{@Author::KENTNL/} . $suffix, 'Dist::Zilla::Plugin::' . $suffix, $conf ];
  return;
}







sub add_named_plugin {
  my ( $self, $name, $suffix, $conf ) = @_;
  if ( not defined $conf ) {
    $conf = {};
  }
  if ( not ref $conf or not 'HASH' eq ref $conf ) {
    require Carp;
    Carp::croak('Conf must be a hash');
  }
  ## no critic (RequireInterpolationOfMetachars)
  push @{ $self->plugins }, [ q{@Author::KENTNL/} . $name, 'Dist::Zilla::Plugin::' . $suffix, $conf ];
  return;
}







sub _is_bake { return ( current_cmd() and 'bakeini' eq current_cmd() ) }

sub _configure_bumpversions_version {
  my ( $self, ) = @_;
  return if $self->bumpversions;
  $self->add_plugin(
    'Git::NextVersion::Sanitized' => {
      version_regexp => '^(.*)-source$',
      first_version  => '0.001000',
      normal_form    => $self->normal_form,
      mantissa       => $self->mantissa,
    },
  );
  return;
}

sub _configure_basic_metadata {
  my ( $self, ) = @_;

  $self->add_plugin( 'MetaConfig'            => {}, );
  $self->add_plugin( 'GithubMeta'            => { issues => 1 }, );
  $self->add_plugin( 'MetaProvides::Package' => { ':version' => '1.14000001' }, );

  my $builtwith_options = { show_config => 1 };

  if ( 'linux' eq $^O ) {
    $builtwith_options->{show_uname} = 1;
    $builtwith_options->{uname_args} = q{-s -o -r -m -i};
  }

  $self->add_plugin( 'MetaData::BuiltWith' => $builtwith_options );
  $self->add_plugin(
    'Git::Contributors' => {
      ':version'       => '0.006',
      include_authors  => 0,
      include_releaser => 0,
      order_by         => 'name',
    },
  );

  return;
}

sub _configure_basic_files {
  my ($self)         = @_;
  my (@ignore_files) = qw( README README.mkdn README.pod );

  push @ignore_files, @{ $self->copyfiles };

  $self->add_plugin(
    'Git::GatherDir' => {
      include_dotfiles => 1,
      exclude_filename => [@ignore_files],
    },
  );
  $self->add_plugin( 'License' => {} );

  $self->add_plugin( 'MetaJSON' => {} );
  $self->add_plugin( 'MetaYAML' => {} );
  $self->add_plugin( 'Manifest' => {} );

  if ( @{ $self->copyfiles } ) {
    $self->add_named_plugin( 'CopyXBuild' => 'CopyFilesFromBuild', { copy => [ @{ $self->copyfiles } ] } );
  }

  return;
}

sub _configure_basic_tests {
  my ($self) = @_;
  $self->add_plugin( 'MetaTests'              => {} );
  $self->add_plugin( 'PodCoverageTests'       => {} );
  $self->add_plugin( 'PodSyntaxTests'         => {} );
  $self->add_plugin( 'Test::ReportPrereqs'    => {} );
  $self->add_plugin( 'Test::Kwalitee'         => {} );
  $self->add_plugin( 'EOLTests'               => { trailing_whitespace => 1, } );
  $self->add_plugin( 'Test::MinimumVersion'   => {} );
  $self->add_plugin( 'Test::Compile::PerFile' => {} );
  $self->add_plugin( 'Test::Perl::Critic'     => {} );
  return;
}

sub _configure_pkgversion_munger {
  my ($self) = @_;
  if ( not $self->bumpversions ) {
    $self->add_plugin( 'PkgVersion' => {} );
    return;
  }
  $self->add_plugin(
    'RewriteVersion::Sanitized' => {
      normal_form => $self->normal_form,
      mantissa    => $self->mantissa,
    },
  );
  return;
}

sub _configure_bundle_develop_suggests {
  my ($self) = @_;
  my $deps = {
    -phase => 'develop',
    -type  => 'suggests',
  };
  if ( _is_bake() ) {
    $deps->{'Dist::Zilla::PluginBundle::Author::KENTNL'} = $VERSION;
    $deps->{'Dist::Zilla::App::Command::bakeini'}        = '0.001000';
  }
  else {
    $deps->{'Dist::Zilla::PluginBundle::Author::KENTNL::Lite'} = '1.3.0';
  }
  $self->add_named_plugin( 'BundleDevelSuggests' => 'Prereqs' => $deps );
  return;
}

sub _configure_bundle_develop_requires {
  my ($self) = @_;
  return if _is_bake();
  $self->add_named_plugin(
    'BundleDevelRequires' => 'Prereqs' => {
      -phase                                      => 'develop',
      -type                                       => 'requires',
      'Dist::Zilla::PluginBundle::Author::KENTNL' => $VERSION,
    },
  );
  return;
}

sub _configure_toolkit {
  my ($self) = @_;
  my $tk = $self->toolkit;
  if ( 'mb' eq $tk ) {
    $self->add_plugin( 'ModuleBuild' => { default_jobs => 10 } );
    return;
  }
  if ( 'eumm' eq $tk ) {
    $self->add_plugin( 'MakeMaker' => { default_jobs => 10 } );
    return;
  }
  if ( 'mbtiny' eq $tk ) {
    $self->add_plugin( 'ModuleBuildTiny' => { default_jobs => 10 } );
    return;
  }
  return;
}

sub _configure_toolkit_prereqs {
  my ($self) = @_;

  my @extra_match_installed = qw( Test::More );
  unshift @extra_match_installed, 'Module::Build'       if 'mb' eq $self->toolkit;
  unshift @extra_match_installed, 'Module::Build::Tiny' if 'mbtiny' eq $self->toolkit;
  unshift @extra_match_installed, 'ExtUtils::MakeMaker' if 'eumm' eq $self->toolkit;

  if ( 'hard' eq $self->toolkit_hardness ) {
    $self->add_plugin(
      'Prereqs::MatchInstalled' => {
        modules => \@extra_match_installed,
      },
    );
  }
  if ( 'soft' eq $self->toolkit_hardness ) {
    $self->add_plugin(
      'Prereqs::Recommend::MatchInstalled' => {
        modules => \@extra_match_installed,
      },
    );
  }

  my $applymap = [ 'develop.requires = develop.requires', ];

  $applymap = [ 'develop.suggests = develop.suggests', ] if _is_bake();

  my @bundles = ('Dist::Zilla::PluginBundle::Author::KENTNL');

  push @bundles, 'Dist::Zilla::App::Command::bakeini' if _is_bake();

  $self->add_named_plugin(
    'always_latest_develop_bundle' => 'Prereqs::Recommend::MatchInstalled' => {
      applyto_map   => $applymap,
      applyto_phase => [ 'develop', ],
      modules       => [@bundles],
    },
  );
  return;
}

sub _configure_readmes {
  my ($self) = @_;

  $self->add_plugin( 'ReadmeFromPod' => {} );

  my $type = $self->srcreadme;

  return if 'none' eq $type;

  my $map = {};
  $map->{mkdn} = { type => 'markdown', filename => 'README.mkdn' };
  $map->{pod}  = { type => 'pod',      filename => 'README.pod' };

  if ( not exists $map->{$type} ) {
    require Carp;
    return Carp::confess("No known readme type $type");
  }

  $self->add_plugin( 'ReadmeAnyFromPod' => { location => 'root', %{ $map->{$type} } }, );

  return;
}

sub configure {
  my ($self) = @_;

  # Version
  $self->_configure_bumpversions_version;

  # MetaData
  $self->_configure_basic_metadata;

  # Gather Files
  $self->_configure_basic_files;
  $self->_configure_basic_tests;

  # Prune files

  $self->add_plugin( 'ManifestSkip' => {} );

  # Mungers
  $self->_configure_pkgversion_munger;
  $self->add_plugin(
    'PodWeaver' => {
      replacer => 'replace_with_blank',
    },
  );

  # Prereqs

  {
    my $autoprereqs_hash = {};
    $autoprereqs_hash->{skips} = $self->auto_prereqs_skip if $self->has_auto_prereqs_skip;
    $self->add_plugin( 'AutoPrereqs' => $autoprereqs_hash );
  }

  $self->_configure_bundle_develop_suggests();
  $self->_configure_bundle_develop_requires();

  $self->add_plugin( 'MinimumPerl' => {} );
  $self->add_plugin(
    'Authority' => {
      ':version'     => '1.006',
      authority      => $self->authority,
      do_metadata    => 1,
      locate_comment => 1,
    },
  );

  $self->_configure_toolkit;

  $self->_configure_readmes;

  $self->add_plugin( 'Test::CPAN::Changes' => {} );
  $self->add_plugin( 'RunExtraTests'       => { default_jobs => 10 } );
  $self->add_plugin( 'TestRelease'         => {} );
  $self->add_plugin( 'ConfirmRelease'      => {} );

  $self->add_plugin( 'Git::Check' => { filename => 'Changes' } );
  $self->add_named_plugin( 'commit_dirty_files' => 'Git::Commit' => {} );
  $self->add_named_plugin( 'tag_master', => 'Git::Tag' => { tag_format => '%v-source' } );
  $self->add_plugin( 'Git::NextRelease' => { time_zone => 'UTC', format => q[%v %{yyyy-MM-dd'T'HH:mm:ss}dZ] } );
  if ( $self->bumpversions ) {
    $self->add_plugin( 'BumpVersionAfterRelease' => {} );
  }
  $self->add_named_plugin(
    'commit_release_changes' => 'Git::Commit' => {
      allow_dirty_match => '^lib/',
    },
  );

  $self->add_plugin( 'Git::CommitBuild' => { release_branch => 'releases' } );
  $self->add_named_plugin( 'tag_release', 'Git::Tag' => { branch => 'releases', tag_format => '%v' } );
  $self->add_plugin( 'UploadToCPAN' => {} );
  $self->add_plugin(
    'Twitter' => {
      hash_tags     => $self->twitter_hash_tags,
      tweet_url     => $self->tweet_url,
      url_shortener => 'none',
    },
  );

  $self->_configure_toolkit_prereqs;

  return;
}

sub bundle_config {
  my ( $self, $section ) = @_;
  my $class = ( ref $self ) || $self;

  my $wanted_version;
  if ( exists $section->{payload}->{':version'} ) {
    $wanted_version = delete $section->{payload}->{':version'};
  }
  my $instance = $class->new( $section->{payload} );

  $instance->configure();

  return @{ $instance->plugins };
}

__PACKAGE__->meta->make_immutable;
no Moose;
no Moose::Util::TypeConstraints;



























































































1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::PluginBundle::Author::KENTNL - BeLike::KENTNL when you build your distributions.

=head1 VERSION

version 2.017001

=head1 SYNOPSIS

    [@Author::KENTNL]
    git_versions = 1      ; Mandatory flag indicating the dist is adjusted to use git tag versioning
                          ; otherwise use an older bundle version.

    normal_form  = numify ; Mandatory for this bundle indicating normal form.
                          ; see DZP::Git::NextVersion::Sanitized

    mantissa     = 6      ; Mandatory for this bundle if normal_form is numify.
                          ; see DZP::Git::NextVersion::Sanitized

    authority    = cpan:KENTNL ; Optional, defaults to cpan:KENTNL

    auto_prereqs_skip   = Some::Module  ; Hide these from autoprereqs
    auto_prereqs_skip   = Other::Module

    toolkit     = mb   ; Which toolkit to use. Either eumm or mb
                         ; mb is default.

    toolkit_hardness = hard ; Whether to upgrade *require* deps to the latest
                            ; or wether to make them merely recomendations.
                            ; Either 'soft' ( recommend ) or 'hard' ( require )
                            ; default is 'hard'

    twitter_extra_hash_tags = #foo #bar ; non-default hashtags to append to the tweet

=head1 DESCRIPTION

This is the plug-in bundle that KENTNL uses. It exists mostly because he is very lazy
and wants others to be using what he's using if they want to be doing work on his modules.

=head1 NAMING SCHEME

As I blogged about on L<< C<blog.fox.geek.nz> : Making a Minting Profile as a CPANized Dist |http://bit.ly/hAwl4S >>,
this bundle advocates a new naming system for people who are absolutely convinced they want their C<Author-Centric> distribution
uploaded to CPAN.

As we have seen with Dist::Zilla there have been a slew of PluginBundles with CPANID's in their name, to the point that there is
a copious amount of name-space pollution in the PluginBundle name-space, and more Author bundles than task-bundles, which was
really what the name-space was designed for, and I'm petitioning you to help reduce this annoyance in future modules.

From a CPAN testers perspective, the annoyance of lots of CPANID-dists is similar to the annoyance of the whole DPCHRIST::
subspace, and that if this pattern continues, it will mean for the testers who do not wish to test everyones personal modules,
that they will have to work hard to avoid this. If DPCHRIST:: had used something like Author::DPCHRIST:: instead, I doubt so many
people would be horrified by it, because you can just have a policy/rule that excludes ^Author::, and everyone else who goes that
way can be quietly ignored.

Then we could probably rationally add that same restriction to the irc announce bots, the "recent modules" list and so-forth, and
possibly even apply special indexing restrictions or something so people wouldn't even have to know those modules exist on cpan!

So, for the sake of cleanliness, semantics, and general global sanity, I ask you to join me with my Author:: naming policy to
voluntarily segregate modules that are most likely of only personal use from those that have more general application.

    Dist::Zilla::Plugin::Foo                    # [Foo]                 dist-zilla plugins for general use
    Dist::Zilla::Plugin::Author::KENTNL::Foo    # [Author::KENTNL::Foo] foo that only KENTNL will probably have use for
    Dist::Zilla::PluginBundle::Classic          # [@Classic]            A bundle that can have practical use by many
    Dist::Zilla::PluginBundle::Author::KENTNL   # [@Author::KENTNL]     KENTNL's primary plugin bundle
    Dist::Zilla::MintingProfile::Default        # A minting profile that is used by all
    Dist::Zilla::MintingProfile::Author::KENTNL # A minting profile that only KENTNL will find of use.

=head2 Current Proponents

I wish to give proper respect to the people out there already implementing this scheme:

=over 4

=item L<< C<@Author::DOHERTY> |Dist::Zilla::PluginBundle::Author::DOHERTY >> - Mike Doherty's, Author Bundle.

=item L<< C<@Author::OLIVER> |Dist::Zilla::PluginBundle::Author::OLIVER >> - Oliver Gorwits', Author Bundle.

=item L<< C<Dist::Zilla::PluginBundle::Author::> namespace |http://bit.ly/dIovQI >> - Oliver Gorwit's blog on the subject.

=item L<< C<@Author::LESPEA> |Dist::Zilla::PluginBundle::Author::LESPEA >> - Adam Lesperance's, Author Bundle.

=item L<< C<@Author::ALEXBIO> |Dist::Zilla::PluginBundle::Author::ALEXBIO >> - Alessandro Ghedini's, Author Bundle.

=item L<< C<@Author::RWSTAUNER> |Dist::Zilla::PluginBundle::Author::RWSTAUNER >> - Randy Stauner's, Author Bundle.

=item L<< C<@Author::WOLVERIAN> |Dist::Zilla::PluginBundle::Author::WOLVERIAN >> - Ilmari Vacklin's, Author Bundle.

=item L<< C<@Author::YANICK> |Dist::Zilla::PluginBundle::Author::YANICK >> - Yanick Champoux's, Author Bundle.

=item L<< C<@Author::RUSSOZ> |Dist::Zilla::PluginBundle::Author::RUSSOZ >> - Alexei Znamensky's, Author Bundle.

=back

=head1 METHODS

=head2 C<bundle_config>

See L<< the C<PluginBundle> role|Dist::Zilla::Role::PluginBundle >> for what this is for, it is a method to satisfy that role.

=head2 C<add_plugin>

    $bundle_object->add_plugin("Basename" => { config_hash } );

=head2 C<add_named_plugin>

    $bundle_object->add_named_plugin("alias" => "Basename" => { config_hash } );

=head2 C<configure>

Called by in C<bundle_config> after C<new>

=head1 ATTRIBUTES

=head2 C<plugins>

B<INTERNAL>.

  ArrayRef, ro, default = [], no init arg.

Populated during C<< $self->configure >> and returned from C<< ->bundle_config >>

=head2 C<normal_form>

  Str, ro, required

A C<normal_form> to pass to L<< C<[Git::NextVersion::Sanitized]>|Dist::Zilla::Plugin::Git::NextVersion::Sanitized >>.

See L<< C<[::Role::Version::Sanitize]>|Dist::Zilla::Role::Version::Sanitize >>

=head2 C<mantissa>

  Int, ro, required if normal_form eq 'numify'

Defines the length of the mantissa when normal form is C<numify>.

See L<< C<[Git::NextVersion::Sanitized]>|Dist::Zilla::Plugin::Git::NextVersion::Sanitized >> and L<< C<[::Role::Version::Sanitize]>|Dist::Zilla::Role::Version::Sanitize >>

=head2 C<git_versions>

  enum([1]), ro, required

=over 4

=item * B<MUST BE SPECIFIED>

=item * B<< MUST BE C<1> >>

=back

Setting as such indicates that the distribution in question is safe to use with C<Git::NextVersion>.

As no logic exists any more to support using anything other than C<Git::NextVersion> with this bundle,
this parameter must be turned on and you must use Git::NextVersion.

=head2 C<authority>

  Str, ro, default = cpan:KENTNL

An authority string to use for C<< [Authority] >>.

=head2 C<auto_prereqs_skip>

  ArrayRef, ro, multivalue, default = []

A list of prerequisites to pass to C<< [AutoPrereqs].skips >>

=head2 C<twitter_extra_hash_tags>

  Str, ro, default = ""

Additional hash tags to append to twitter

=head2 C<twitter_hash_tags>

  Str, ro, default = '#perl #cpan' . extras()

Populates C<extras> from C<twitter_extra_hash_tags>

=head2 C<tweet_url>

  Str, ro, default =  q[https://metacpan.org/release/{{$AUTHOR_UC}}/{{$DIST}}-{{$VERSION}}{{$TRIAL}}#whatsnew]

The C<URI> to tweet to C<@kentnlrelease>

=head2 C<toolkit_hardness>

  enum( hard, soft ), ro, default = hard

=over 4

=item * C<hard>

Copy the versions of important toolkit components the author was using as C<required> dependencies,
forcing consumers to update aggressively on those parts.

=item * C<soft>

Copy the versions of important toolkit components the author was using as C<recommended> dependencies,
so that only consumers who are installing with C<--with-recommended> get given the forced upgrade path.

=back

=head2 C<toolkit>

  enum( mb, mbtiny, eumm ), ro, default = mb

Determines which tooling to generate the distribution with

=over 4

=item * C<mb> : L<< C<Module::Build>|Module::Build >>

=item * C<mbtiny> : L<< C<Module::Build::Tiny>|Module::Build::Tiny >>

=item * C<eumm> : L<< C<ExtUtils::MakeMaker>|ExtUtils::MakeMaker >>

=back

=head2 C<bumpversions>

  bumpversions = 1

If true, use C<[BumpVersionAfterRelease]>  and C<[RewriteVersions::Sanitized]> instead of C<[PkgVersion]> and
C<[Git::NextVersion::Sanitized]>

=head2 C<copyfiles>

An array of files generated by C<Dist::Zilla> build to copy from the built dist back to the source dist

  copyfiles = LICENSE
  ; Warning: These two are presently bad ideas
  ; and will ultimately give version mismatches
  copyfiles = Makefile.PL
  copyfiles = META.json

=head2 C<srcreadme>

  srcreadme = pod  ; # generate README.pod on the source side
  srcreadme = mkdn ; # generate README.mkdn on the source side
  srcreadme = none ; # don't generate README on the source side

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Dist::Zilla::PluginBundle::Author::KENTNL",
    "interface":"class",
    "inherits":"Moose::Object",
    "does":"Dist::Zilla::Role::PluginBundle"
}


=end MetaPOD::JSON

=for Pod::Coverage   mvp_multivalue_args
  bundle_config_inner

=head1 AUTHOR

Kent Fredric <kentnl@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Kent Fredric.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
