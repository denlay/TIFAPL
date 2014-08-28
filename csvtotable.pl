#!/usr/local/bin/perl
use strict;
use warnings;
use DBI;
use File::Basename;

#require "inspira.pl";
require "connect.pl";
my $dbh = dbi_connect(); # connect doing here
my %cfg = dbi_cfg(); # connect doing here

=multi line comment
	terima input path file csv
	dapatkan line pertama
	dapatkan nama file csv 
	explode separator
	buat table
	
	# version if $option eq "-v" or $option eq "--version";
=cut	


foreach (@ARGV) { 
	
	my $path = $_; #get p persatuan
	
	my($filename, $dirs, $suffix) = fileparse($path, '.csv');
	
	open FILE, $path or die $!;
	
	my @header = split(',',<FILE>);
	
	my @column = (); # variable penampung header
	
	foreach my $val (@header) { # loop header
		
		push(@column, "$val character(20)");
	}
	
	# finish the create code
	my $cols = join(', ', @column);
	
	my $sql = "DROP TABLE IF EXISTS $filename;";
	my $query = $dbh->prepare($sql);
	$query->execute();
	undef($query);
	
	$sql = "CREATE TABLE $filename (" . $cols . ") WITH ( OIDS=FALSE ); ALTER TABLE $filename OWNER TO ".$cfg{user}.";";
	$query = $dbh->prepare($sql);
	$query->execute();
	undef($query);
	
	$sql = "COPY  $filename FROM '".$path."' DELIMITER ',' CSV HEADER;";
	$query = $dbh->prepare($sql);
	$query->execute();
	undef($query);
	
	close FILE;
}


print "gw ganteng\n";
