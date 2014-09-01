#!/usr/local/bin/perl
use strict;
use v5.10.1;
use warnings;
use DBI;
use File::Basename;

require "connect.pl";
require "sub_sql.pl";
my $dbh = dbi_connect(); # connect doing here
my %cfg = dbi_cfg(); # connect doing here

=multi line comment
	terima input path file csv
	dapatkan line pertama
	rubah nama di line pertama yang ada charater kosong
	dapatkan nama file csv 
	rubah nama yang mengandung -	
	explode separator
	buat table
=cut	
foreach ($ARGV[0]) {

	my $path 	= $ARGV[0];	#get path persatuan

	my $vendor 	= $ARGV[1];	#get vendor name

	my($filename, $dirs, $suffix) = fileparse($path, '.csv');

	#ex:file MSC_MANTAP14-8-07-14-8-07.csv menjadi table MSC_MANTAP
	my $filenamefix = substr($filename, 0, index($filename, /(\d+)/g));
	
	print "IMPORT ".$path;
	
	open FILE, $path or die $!;

	my @header = split(',',<FILE>);

	my @column = (); 	# variable penampung header
	my @column_csv = (); 	# variable penampung header

	# loop header
	foreach my $val (@header) {
		
		# rubah nama yang ada charater kosong
		my $pos = index($val, ' ');
		
		if ($pos > 0) {  
			
			my $val = substr( $val, 0, $pos); 
		}
		
		push(@column_csv, '"'.$val.'"');
		
		push(@column, '"'.$val.'" text');	
	}
	# end loop header
	 
	my $cols_csv = join(', ', @column_csv);	#col di csv
		
	push(@column, "created_date timestamp default now()"); #tambah kolom untuk tanggal import/input csv to table

	my $cols = join(', ', @column);

	create_table($vendor, $filenamefix, $cols, $cfg{user});	 #create table ke postgres

	copy_csv_to_table($vendor, $filenamefix, $cols_csv, $path); #copy data dari csv ke database

	close FILE;
	
	print " FINISH \n";
}

