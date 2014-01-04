use 5.006;    # warning pragma
use strict;
use warnings;

package Dist::Zilla::MintingProfile::Author::KENTNL;
BEGIN {
  $Dist::Zilla::MintingProfile::Author::KENTNL::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::MintingProfile::Author::KENTNL::VERSION = '2.007002';
}

# ABSTRACT: KENTNL's Minting Profile

use Moose qw( meta with );
use namespace::autoclean;
with 'Dist::Zilla::Role::MintingProfile::ShareDir';



__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::MintingProfile::Author::KENTNL - KENTNL's Minting Profile

=head1 VERSION

version 2.007002

=head1 SYNOPSIS

    dzil new -P Author::KENTNL Some::Dist::Name

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Dist::Zilla::MintingProfile::Author::KENTNL",
    "inherits":"Moose::Object",
    "does":"Dist::Zilla::Role::MintingProfile::ShareDir",
    "interface":"class"
}


=end MetaPOD::JSON

=head1 AUTHOR

Kent Fredric <kentnl@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Kent Fredric.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
