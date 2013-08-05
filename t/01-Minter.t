
use strict;
use warnings;

use Test::More;
use FindBin;
use Path::Class qw( dir );
use Test::Output qw();
use JSON qw( from_json );

my ( $root, $corpus, $global );

BEGIN {
  $root   = dir("$FindBin::Bin")->parent->absolute;
  $corpus = $root->subdir('corpus');
  $global = $corpus->subdir('global');
}

$ENV{'GIT_AUTHOR_NAME'}  = $ENV{'GIT_COMMITTER_NAME'}  = 'Anon Y. Mus';
$ENV{'GIT_AUTHOR_EMAIL'} = $ENV{'GIT_COMMITTER_EMAIL'} = 'anonymus@example.org';

use Test::File::ShareDir 0.3.0 -share =>
  { -module => { 'Dist::Zilla::MintingProfile::Author::KENTNL' => $root->subdir('share')->subdir('profiles') }, };
use Test::DZil;

my $tzil;

subtest 'mint files' => sub {

  $tzil =
    Minter->_new_from_profile( [ 'Author::KENTNL' => 'default' ], { name => 'DZT-Minty', }, { global_config_root => $global }, );

  pass('Loaded minter config');

  $tzil->chrome->logger->set_debug(1);

  pass("set debug");

  $tzil->mint_dist;

  pass("minted dist");

  my $pm = $tzil->slurp_file('mint/lib/DZT/Minty.pm');

  pass('slurped file');

  my %expected_files = map { $_ => 1 } qw(
    lib/DZT/Minty.pm
    weaver.ini
    perlcritic.rc
    Changes
    .perltidyrc
    .gitignore
    dist.ini
  );

  my %got_files;

  for my $file ( @{ $tzil->files } ) {
    my $name = $file->name;
    $got_files{$name} = 0 if not exists $got_files{$name};
    $got_files{$name} += 1;
  }

  # system("find",$tzil->tempdir );

  for my $dir (qw( .git .git/refs .git/objects lib )) {
    ok( -e $tzil->tempdir->subdir('mint')->subdir($dir), "output dir $dir exists" );
  }

  note explain [ $tzil->log_messages ];

  note explain { got => \%got_files, expected => \%expected_files };

  is_deeply( \%got_files, \%expected_files, 'All expected mint files exist' );

};

use Capture::Tiny;
use Test::Fatal;

subtest 'build minting' => sub {

  my $tmpdir = $tzil->tempdir->subdir('mint')->absolute;

  pass("Got minted dir");

  subtest 'Mangle minted dist.ini for experimental purposes' => sub {

    my $old        = $tmpdir->file('dist.ini');
    my $new        = $tmpdir->file('dist.ini.new');
    my $distini    = $old->openr();
    my $newdistini = $new->openw();

    while ( defined( my $line = <$distini> ) ) {
      print $newdistini $line;
      if ( $line =~ /auto_prereqs_skip/ ) {
        note "Found skip line: ", explain( { line => $line } );
        pass "Found skip line: $.";
        print $newdistini "auto_prereqs_skip = Bogus\n";
        print $newdistini "auto_prereqs_skip = OtherBogus\n";
      }
    }

    close $distini;
    close $newdistini;

    $old->remove();

    rename "$new", "$old" or fail("Can't rename $new to $old");

  };

  my $pmfile;
  subtest 'Create fake pm with deps to be ignored' => sub {

    $pmfile = $tmpdir->subdir('lib')->subdir('DZT')->file('Mintiniator.pm');
    my $fh = $pmfile->openw();

    print $fh <<'EOF';
use strict;
use warnings;
package DZT::Mintiniator;

# ABSTRACT: Test package to test auto prerequisites skip behaviour

if(0){ # Stop it actually failing
  require Bogus;
  require OtherBogus;
  require SomethingReallyWanted;
}

1;
EOF

    pass('Generated file');
    note "$pmfile";
    ok( -f $pmfile, "Generated file exists" );

  };
  subtest "Add generated file to git" => sub {
    require Git::Wrapper;
    my $git = Git::Wrapper->new("$tmpdir");
    $git->add("$pmfile");
    is( eval { $git->commit( { message => "Test Commit" } ); 'pass' }, 'pass', "Committed Successfully" );
    my (@files) = $git->ls_files();
    is( ( scalar grep { $_ =~ /Mintiniator\.pm$/ } @files ), 1, "Exactly one copy of Mintiniator.pm is found by git" );

  };

  my $bzil = Builder->from_config( { dist_root => $tmpdir }, {}, { global_config_root => $global }, );

  pass("Loaded builder configuration");

  $bzil->chrome->logger->set_debug(1);

  pass("Set debug");

  $bzil->build;

  pass("Built Dist");

  # NOTE: ->test doesn't work atm due to various reasons unknown, so doing it manually.

  my $exception;
  my $target;
  my ( $stdout, $stderr ) = Capture::Tiny::capture(
    sub {
      $exception = exception {
        require File::pushd;
        $target = File::pushd::pushd( dir( $bzil->tempdir )->subdir('build') );
        system( $^X , 'Build.PL' ) and die "error with Build.PL\n";
        system( $^X , 'Build' )    and die "error running $^X Build\n";
        system( $^X , 'Build', 'test', '--verbose' ) and die "error running $^X Build test\n";
      };
    }
  );
  note explain { 'output was' => { out => $stdout, err => $stderr } };

  if ( defined $exception ) {
    note explain $exception;

    #  system("urxvt -e bash"); # XXX DEVELOPMENT
    die $@;
  }

  #  system("find",$bzil->tempdir );

  my %expected_files = map { $_ => 1 } qw(
    lib/DZT/Minty.pm
    lib/DZT/Mintiniator.pm
    weaver.ini
    perlcritic.rc
    Changes
    .perltidyrc
    dist.ini
    Build.PL
    Changes
    LICENSE
    MANIFEST
    META.json
    META.yml
    README
    t/00-compile.t
    t/000-report-versions-tiny.t
    xt/author/critic.t
    xt/release/cpan-changes.t
    xt/release/distmeta.t
    xt/release/eol.t
    xt/release/kwalitee.t
    xt/release/minimum-version.t
    xt/release/pod-coverage.t
    xt/release/pod-syntax.t
  );

  my %got_files;
  my %got_files_refs;
  for my $file ( @{ $bzil->files } ) {
    my $name = $file->name;
    $got_files{$name} = 0 if not exists $got_files{$name};
    $got_files{$name} += 1;
    $got_files_refs{$name} = $file;
  }

  note explain { got => \%got_files, expected => \%expected_files };

  note explain [ $bzil->log_messages ];

  is_deeply( \%got_files, \%expected_files, 'All expected mint files exist' );

  my $data = from_json( dir( $bzil->tempdir )->subdir('build')->file('META.json')->slurp() );

  note explain $data;
  require version;

  is_deeply(
    $data->{prereqs},
    {
      build     => { requires => { 'Module::Build' => $Module::Build::VERSION }, },
      configure => { requires => { 'Module::Build' => $Module::Build::VERSION }, },
      develop   => {
        recommends => { 'Dist::Zilla::PluginBundle::Author::KENTNL::Lite' => 'v1.3.0' },
        requires   => {
          'Dist::Zilla::PluginBundle::Author::KENTNL::Lite' => 0,
          'Test::Pod::Coverage'                             => '1.08',
          'Test::Pod'                                       => '1.41',
          'Pod::Coverage::TrustPod'                         => 0,
          'version'                                         => '0.9901',
          'Test::CPAN::Meta'                                => 0,
          'Test::CPAN::Changes'                             => '0.19',
        },
        suggests => {
          'Dist::Zilla::PluginBundle::Author::KENTNL' =>
            version->parse( Dist::Zilla::PluginBundle::Author::KENTNL->VERSION )->normal
        },
      },
      runtime => {
        requires => {
          'Moose'                 => 0,
          'SomethingReallyWanted' => 0,
          'perl'                  => 'v5.10.0',
          'warnings'              => 0,
          'strict'                => 0,
        },
      },
      test => {
        requires => {
          'blib' =>  0,
          'Capture::Tiny' => 0,
          'Test::More' => $Test::More::VERSION,
        },
      }
    },
    'Autodetected pre-reqs are sane'
  );

};

done_testing;
