#!/usr/bin/perl

use warnings;
use strict;

sub Usage();

# check arg exists
if (@ARGV != 1) { Usage(); }

my @response = `wget "http://cybercrime-tracker.net/index.php?s=0&m=6000" -O - 2>/dev/null`;

my @urls;
my @ips;
my @domains;

my $num = 0;
foreach my $line (@response) {
  if ($line =~ /^<tr><td>.*<\/td>/) {
    my $domain = $response[$num + 1];
    my $url = $response[$num + 1];
    my $ip = $response[$num + 2];

    $domain =~ s/^.*<td>//;
    $domain =~ s/http:\/\///;
    $domain =~ s/\/.*$//;
    $domain =~ s/:.*$//;
    $domain =~ s/<//;
    $domain =~ s/^.* //;

    $url =~ s/^.*<td>//;
    $url =~ s/<\/td>.*$//;
    $url =~ s/\(.*\) //;
    $url =~ s/ \(.*\)//;
    $url =~ s/ .*$//;
    $url =~ s/&amp;/&/g;

    $ip =~ s/^.*_blank\">//;
    $ip =~ s/<\/a><\/td>//;

    if ($domain =~ /([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})/) { 
      push (@ips, $1);
    } else {
      push (@domains, $domain);
    }
    if ($ip =~ /([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})/) { 
      push (@ips, $1);
    }
    push (@urls, $url);
  }
  $num++;
}

if ($ARGV[0] eq 'ip') {
  foreach my $ip (@ips) {print "$ip\n";}
} elsif ($ARGV[0] eq 'domain') {
  foreach my $domain (@domains) {print $domain;}
} elsif ($ARGV[0] eq 'url') {
  foreach my $url (@urls) {print $url;}
} else {
  Usage();
}

sub Usage(){
  print "Usage:\n";
  print "$0 ip\n";
  print "$0 domain\n";
  print "$0 url\n";
  exit(0);
}

#<tr><td>12-06-2014</td>
#                  <td>securetalk.cwsurf.de/cp.php?m=login</td>
#                                  <td><a href="https://www.virustotal.com/en/ip-address/85.195.104.22/information/" target="_blank">85.195.104.22</a></td>
#                                  <td>ZeuS</td>
#                                  <td><a href="https://www.virustotal.com/latest-scan/http://securetalk.cwsurf.de/cp.php?m=login" target="_blank"><img src='vt.png' alt='Scan with VirusTotal' width='13' height='12' border='0' longdesc='Scan with VirusTotal' /></a> <a href="http://cybercrime-tracker.net/index.php?s=0&m=40&search=ZeuS" ><img src='vwicn008.gif' alt='Search the family' width='13' height='12' border='0' longdesc='Search the family' /></a></tr></td>

