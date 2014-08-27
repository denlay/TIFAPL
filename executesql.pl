#!/usr/local/bin/perl
use strict;
use warnings;
use DBI;

require "connect.pl";

my $dbh = dbi_connect(); # connect doing here


foreach (@ARGV) { # every argument 
	
	my $param = $_;
	# read file sql

	$/ = undef;
	
	print "Open ", $param, "\n";
	
	open FILE, $param or die $!;
	#print SCRIPT;
	print "Open ", $param, "\n";

	my $query = $dbh->prepare(<FILE>);
	
	print "Begin Execute ", $param, "\n";
	
	$query->execute();
	
	undef($query);
	
	print "Finish Execute ", $param, "\n";
}

$dbh->disconnect();

$dbh = undef;

print "Gw Ganteng \n";
