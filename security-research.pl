#!/usr/bin/perl

use warnings;
use strict;

sub Usage();

# check arg exists
if (@ARGV != 1) { Usage(); }

my $url = "http://security-research.dyndns.org/pub/malware-feeds/ponmocup-infected-domains-CIF-latest.txt";
my @response = `wget $url -O - 2>/dev/null`;

if ($ARGV[0] eq 'ip') {
  foreach my $ip (@response) {
    if ($ip =~ /^([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}) /) {
      $ip = $1;
      if ($ip ne '0.0.0.0') {
        print "$ip\n";
      }
    }
  }
} elsif ($ARGV[0] eq 'domain') {
  foreach my $domain (@response) {
    if ($domain =~ /^[0-9\.]* (.*) .* (.*)$/) {
      print "$1\n";
      print "$2\n";
    }
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
