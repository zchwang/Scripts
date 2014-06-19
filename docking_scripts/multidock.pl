#!/usr/bin/perl
# Script: multidock.pl
# Description: sets up automated docking for multiple chemicals 
# Author: Steven Ahrendt
# email: sahrendt0@gmail.com
# Date: 05.22.2014
##################################
use warnings;
use strict;
use Getopt::Long;
use lib '/rhome/sahrendt/Scripts';

#####-----Global Variables-----#####
my $input;
my ($help,$verb);
my $dir = ".";
GetOptions ('i|input=s' => \$input,
            'h|help'   => \$help,
            'v|verbose' => \$verb);
my $usage = "Usage: multidock.pl\n";
die $usage if $help;
#die "No input.\n$usage" if (!$input);

#####-----Main-----#####
opendir(DIR,$dir);
my @compounds = sort grep {/\.sdf$/} readdir(DIR);
closedir(DIR);

chomp @compounds;
foreach my $cmpd (@compounds)
{
  next if ($cmpd =~ /sim/);
  print $cmpd,"\n";
  my @tmp = split(/\./,$cmpd);
  pop @tmp;
  my $dirname = join(".",@tmp);
  print `mkdir $dirname`;
  print `mv $cmpd $dirname`;
  print `babel -i sdf ./$dirname/$cmpd -o mol2 ./$dirname/$dirname\.mol2`;
  #print $dirname,"\n";
  #print `mkdir $dirname`;
}
warn "Done.\n";
exit(0);

#####-----Subroutines-----#####
