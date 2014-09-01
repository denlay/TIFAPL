# sub routine sql
use 5.10.1;
use strict;
use warnings;
use DBI;

require "connect.pl";

my $dbh = dbi_connect(); # connect doing here
my %cfg = dbi_cfg(); # connect doing here

# CONFIG VARIABLES
my $a = "d";

sub create_schema 
{ 
	my $schema = $_[0]; # get parameter
	
	my $sql_schema = "do \$\$ ".
			  "DECLARE ".
			  " ".
			  "BEGIN ".
			  " ".
			  " BEGIN".
			  "		CREATE SCHEMA SC_".$schema.";".
			  " EXCEPTION WHEN OTHERS THEN".			  				
			  " ".			  				
			  " END;".			  				
			  " ".
			  " ".		  				
			  "END \$\$;";
			  
	my $query = $dbh->prepare($sql_schema);	
	$query->execute();	
	undef($query);

};

sub create_table
{
	my ($vendor,$filenamefix,$cols,$cfg) = @_; # get parameter
	
	my $sql = "do \$\$ ".
			  "DECLARE ".
			  " ".
			  "BEGIN ".
			  " ".
			  " BEGIN".
			  "		CREATE TABLE SC_$vendor.". $filenamefix ." (" . $cols . ") WITH ( OIDS=FALSE );".
			  "		ALTER TABLE SC_$vendor.".$filenamefix ." OWNER TO ".$cfg.";".
			  " EXCEPTION WHEN OTHERS THEN".			  				
			  " ".			  				
			  " END;".				  	  				
			  " ".		  				
			  "END \$\$;";

	my $query = $dbh->prepare($sql);	
	$query->execute();	
	undef($query);	
}

sub copy_csv_to_table
{
	my ($vendor,$filenamefix,$cols_csv,$path) = @_; # get parameter
	
	my $sql_copy = "do \$\$ ".
			  "DECLARE ".
			  " ".
			  "BEGIN ".
			  " ".
			  " BEGIN".
			  "		COPY SC_$vendor.". $filenamefix ." (" . $cols_csv . ") FROM '".$path."' DELIMITER ',' CSV HEADER;".		  				
			  " EXCEPTION WHEN OTHERS THEN".			  				
			  " ".			  				
			  " END;".			  				
			  " ".		  				
			  "END \$\$;";
	my $query = $dbh->prepare($sql_copy);	
	$query->execute();	
	undef($query);		  
};

