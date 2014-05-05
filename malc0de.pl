#!/usr/bin/perl

use warnings;
use strict;

sub Usage();

# check arg exists
if (@ARGV != 1) { Usage(); }

# note libwww-perl user agent is blocked so using command line wget
if ($ARGV[0] eq 'ip') {
  my $url = "http://malc0de.com/bl/IP_Blacklist.txt";
  my @response = `wget $url -O - 2>/dev/null`;
  #filter out things that aren't ip addresses
  foreach my $ip (@response) {
    if ($ip =~ /([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})$/) {
      print "$1\n";
    }
  }
} elsif ($ARGV[0] eq 'domain') {
  my $url = "http://malc0de.com/bl/ZONES";
  my @response = `wget $url -O - 2>/dev/null`;
  foreach my $domain (@response) {
    if ($domain =~ /zone \"(.*)\" *\{type/) {
      print "$1\n";
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
