#!/usr/local/bin/perl
use 5.10.1;
use warnings;

# CONFIG VARIABLES
$platform = "Pg";
$database = "mydb";
$host = "localhost";
$port = "5432";
$user = "postgres";
$password = 'postgres';
$dbh	= "dbi:$platform:dbname=$database host=$host port=$port";


sub dbi_connect { 
	return DBI->connect($dbh,$user,$password,{AutoCommit=>1,RaiseError=>1,PrintError=>0});
};

