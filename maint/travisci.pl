#!/usr/bin/env perl
# ABSTRACT: Munge travis.ci options
sub {
  my ($yaml) = @_;
  splice @{ $yaml->{before_install} }, 1, 0, ('git --version');

  #  @{ $yaml->{matrix}->{include} } = grep { $_->{perl} ne '5.8' }  @{ $yaml->{matrix}->{include} };
};

