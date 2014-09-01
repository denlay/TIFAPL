#!/usr/local/bin/perl
use 5.10.1;
use warnings;

# CONFIG VARIABLES
$platform = "Pg";
$database = "db_smartelco";
$host = "localhost";
$port = "5432";
$user = "postgres";
$password = 'postgres';
$dbh	= "dbi:$platform:dbname=$database host=$host port=$port";
$path_tablespace = '/media/postgres_disk/9.1';


# return objek which connect to database
sub dbi_connect { 
	return DBI->connect($dbh,$user,$password,{AutoCommit=>1,RaiseError=>1,PrintError=>0});
};

# return list value from config database
sub dbi_cfg {
	return (platform=>$platform, database=>$database, host=>$host, port=>$port, user=>$user,path_tablespace=>$path_tablespace);
}
