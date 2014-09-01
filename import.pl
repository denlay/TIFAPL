#!/usr/local/bin/perl
use strict;
use v5.10.1;
use warnings;
use DBI;
use File::Basename;

=multiline
	1. ambil nama folder
	2. bikin schema 
	2. ambil banyaknya file .csv
=cut

require "sub_sql.pl";
system('clear');
print "=================================================================\n";
print "==========                  S T A R T                 ===========\n";
print "=================================================================\n";

my $dir = $ARGV[0];

opendir ( DIR, $dir ) || die "Error in opening dir $dir\n";

	# ambil nama folder
	while( (my $filename = readdir(DIR))){
		if (($filename eq '.') || ($filename eq '..')) {}
		else {
			
			#my $filenamefix = substr($filename, 0, index($filename, /(\S+)/g));
			my $vendor =  substr($filename, 7);	
			
			#bikin schema
			create_schema("$vendor");
		
			my $dirsub = $dir."$filename/";
	
	#ambil banyaknya file dari folder yang menyimpan csv	
		opendir ( DIRA, $dirsub ) || die "Error in opening dir $dirsub\n";
			
			while( (my $filename_csv = readdir(DIRA))){
				
				if (($filename_csv eq '.') || ($filename_csv eq '..')) {}
				else {
				    
					system("perl csvtotable.pl ".$dirsub.$filename_csv." ". $vendor);
				}
			
			}
			
		closedir(DIRA);
		
		}		
	}

closedir(DIR);


print "=================================================================\n";
print "==========                 F I N I S H                ===========\n";
print "=================================================================\n";
