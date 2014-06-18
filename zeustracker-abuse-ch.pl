#!/usr/bin/perl

use warnings;
use strict;

sub Usage();

# check arg exists
if (@ARGV != 1) { Usage(); }

if ($ARGV[0] eq 'ip') {
  my $url = "https://zeustracker.abuse.ch/blocklist.php?download=badips";
  my @response = `wget $url -O - 2>/dev/null`;
  #filter out things that aren't ip addresses
  foreach my $ip (@response) {
    if ($ip =~ /([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})$/) {
      print "$1\n";
    }
  }
} elsif ($ARGV[0] eq 'domain') {
  my $url = "https://zeustracker.abuse.ch/blocklist.php?download=baddomains";
  my @response = `wget $url -O - 2>/dev/null`;
  foreach my $domain (@response) {
    chomp $domain;
    if ($domain =~ /^#/) { next ; }
    if ($domain =~ /^$/) { next ; }
    print "$domain\n";
  }
} else {
  Usage();
}

sub Usage(){
  print "Usage:\n";
  print "$0 ip\n";
  print "$0 domain\n";
  exit(0);
}
