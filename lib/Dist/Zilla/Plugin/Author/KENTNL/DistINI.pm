use 5.008;    # utf8
use strict;
use warnings;
use utf8;

=encoding UTF-8

=cut

package Dist::Zilla::Plugin::Author::KENTNL::DistINI;

# ABSTRACT: Generate a dist.ini for @Author::KENTNL projects.

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Dist::Zilla::Plugin::Author::KENTNL::DistINI",
    "interface":"class",
    "inherits":"Moose::Object",
    "does":"Dist::Zilla::Role::FileGatherer"
}

=end MetaPOD::JSON

=cut

use Moose qw( with );

with qw(Dist::Zilla::Role::FileGatherer);

=head1 SYNOPSIS

  ; ~/.dzil/profiles/default/profile.ini
  [Author::KENTNL::DistINI]

  ; ~/.dzil/config.ini
  [%Rights]
  license_class = Perl_5
  copyright_holder = Kent Fredric <kentnl@cpan.org>

  [%PAUSE]
  user = KENTNL
  password = ; you don't think I'm stupid do you?

  ; ~/.netrc
  machine api.twitter.com
    login kentnlrelease
    password ; still not quite stupid enough

Then

  dzil new Some-Distname
  # start hacking.

This sets up [@Author::KENTNL] packages the way KENTNL likes it.

This involves initial configuration of the parameters that get
passed through to AutoVersion::Relative to provide the
relative frame of reference.

=head1 NAMING RATIONALE

  Plugin::DistINI::KENTNL # Argh, too pollutive of the ::DistINI subspace
  Plugin::DistINI::Author::KENTNL
    # Argh, its going to result in lots of 'Author' subspaces ;(
  Plugin::Author::KENTNL::* # Low pollution, well clustered.

As it is, the following stuff is starting to get to me in terms of
name-space pollution:

  Plugin::EOLTests  # Would prefer Plugin::Test::EOL
  Plugin::PodSyntaxTests # Would prefer Plugin::Test::Pod::Syntax

And I have half a mind to rename L<< C<Dist::Zilla::PluginBundle::KENTNL>|Dist::Zilla::PluginBundle::KENTNL >> to be
C<Dist::Zilla::PluginBundle::Author::KENTNL> just to keep the top level cleaner, for stuff where bundles of plug-ins are useful
for people other than ... well.. me. Call me a counter-egotist, if you will.

=head1 THEFT

This code is mostly stolen from the L<< C<DistINI>|Dist::Zilla::Plugin::DistINI >> plug-in. Blame C<rjbs> if its broken C<< ☺ >>.

=cut

use Dist::Zilla::File::FromCode;
use String::Formatter named_stringf => {
  -as   => 'str_rf',
  codes => {
    s => sub { "$_" },
    S => sub { q{"} . "$_" . q{"} },
    n => sub { int $_ },
  },
};

=method C<gather_files>

generates a C<dist.ini> file.

=cut

sub gather_files {
  my ( $self, ) = @_;
  my $zilla     = $self->zilla;
  my $empty     = q{};
  my $template;
  {
    ## no critic (RequireInterpolationOfMetachars)
    $template = join qq{\n}, (
      q(; Generated by %{GENPACKAGE}s version %{GENVERSION}s at %{GENTIME}s),    #
      'name             = %{name}s',                                             #
      'author           = %{author}s',                                           #
      'license          = %{license}s',                                          #
      'copyright_holder = %{copyrightholder}s',                                  #
      $empty,                                                                    #
      q(; Uncomment this to bootstrap via self),                                 #
      q(; [Bootstrap::lib]),                                                     #
      $empty,                                                                    #
      '[@Author::KENTNL]',                                                       #
      ':version          = 1.2.0',                                               #
      'git_versions      = 1',                                                   #
      'normal_form       = numify',
      'mantissa          = 6',
      '; version_major     = 0',                                                 #
      '; version_minor     = 1',                                                 #
      q(; the following data denotes when this minor was minted),                #
      '; version_rel_year  = %{rel_year}n',                                      #
      '; version_rel_month = %{rel_month}n',                                     #
      '; version_rel_day   = %{rel_day}n',                                       #
      '; version_rel_hour  = %{rel_hour}n',                                      #
      '; version_rel_time_zone = %{tz}s',                                        #
      'twitter_hash_tags = %{tags}s',                                            #
      '; auto_prereqs_skip = File::Find',                                        #
      $empty,                                                                    #
      '[Prereqs]',                                                               #
      $empty,                                                                    #
    );
  }
  my $code = sub {
    ## no critic (RegularExpressions)
    my $license = ref $zilla->license;
    if ( $license =~ /^Software::License::(.+)$/ ) {
      $license = $1;
    }
    else {
      $license = "=$license";
    }

    # TODO: support >1 authors. Too lazy atm, its just me. -- Kentnl - 2010-06-10
    # TODO: Actually workout whatever localtime is where Kentnl lives. Atm, its overkill. -- Kentnl - 2010-06-10
    my $content = str_rf(
      $template,
      {
        GENPACKAGE      => __PACKAGE__,
        GENVERSION      => ( __PACKAGE__->VERSION || '(unversioned:dist)' ),
        GENTIME         => ( scalar localtime ),
        name            => $zilla->name,
        author          => $zilla->authors->[0],
        license         => $license,
        copyrightholder => $zilla->copyright_holder,
        rel_year        => (localtime)[5] + 1900,
        rel_month       => (localtime)[4] + 1,
        rel_day         => (localtime)[3],
        rel_hour        => (localtime)[2],
        tz              => 'Pacific/Auckland',
        tags            => '#perl #cpan',
      },
    );
    return $content;
  };
  my $file = Dist::Zilla::File::FromCode->new(
    {
      name => 'dist.ini',
      code => $code,
    },
  );
  $self->add_file($file);
  return 1;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;
