#!/usr/local/bin/perl
use 5.10.1;
use warnings;

# CONFIG VARIABLES
$platform = "Pg";
$database = "db_smartelco";
$host = "localhost";
$port = "3306";
$tablename = "inventory";
$user = "postgres";
$password = 'admin01';
$dbh	= "dbi:$platform:dbname=$database host=$host port=$port";


sub dbi_connect { 
	return DBI->connect($dbh,$user,$password,{AutoCommit=>1,RaiseError=>1,PrintError=>0});
};

