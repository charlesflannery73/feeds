#!/usr/bin/perl

use warnings;
use strict;

sub Usage();

# check arg exists
if (@ARGV != 1) { Usage(); }

my $url = "http://openphish.com/feed.txt";
my @response = `wget $url -O - 2>/dev/null`;

if ($ARGV[0] eq 'ip') {
  foreach my $ip (@response) {
    if ($ip =~ /^http:\/\/([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})\//) {
      print "$1\n";
    }
  }
} elsif ($ARGV[0] eq 'domain') {
  foreach my $url (@response) {
    if ($url =~ /^http:\/\/(.*?)\//) {
      my $domain = $1;
      if ($domain =~ /[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/) {
        next;
      }
      $domain =~ s/^www\.//;
      print "$domain\n";
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
