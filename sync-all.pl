#!/usr/bin/perl

use strict;
use Cwd;
use File::Path

$| = 1; 

my @repo;
my $ro=0;

@repo = ([
	'git@github.com:0pq76r/cubebox-client.git',
	'git@github.com:0pq76r/cubebox-shared.git',
	'git@github.com:0pq76r/cubebox-server.git'
	],			
	[
	'git://github.com/0pq76r/cubebox-client.git',
	'git://github.com/0pq76r/cubebox-shared.git',
	'git://github.com/0pq76r/cubebox-server.git'
	]);


sub help {
	print <<EOF;
===============================================================

Usage:
	./sync-all [-r] [-a]
		[-c Client(Name|Tag|Version|Checksum)]
		[-l Shared(Name|Tag|Version|Checksum)]
		[-s Server(Name|Tag|Version|Checksum)]
		
	-r		Read only
	-a		Sync Client, Server and Shared		
	-c		Sync Client
	-l		Sync Shared
	-s		Sync Server

---------------------------------------------------------------

Example:
	./sync-all -r -l latest -c Enola

===============================================================
EOF
	
}

sub main {

	my $pwd = getcwd();

    if ($#_ eq -1) {
        help(1);
    }
    
    my @args=@_;
	
	push @args, " ";
	
    while ($#args ne -1) {
        my $arg = shift @args;
        
        if ($arg eq "--help") {
            help(0);
        }
        elsif ($arg eq "-r"){ $ro=1; }
        elsif ($arg eq "-c"){
			if (-d "client/.git") {
				chdir("client");
				system "git pull $repo[$ro][0]";
			}
			else {
				system "mkdir -p client";
				chdir ("client");
				system "git init";
				system "git remote add origin $repo[$ro][0]";
				system "git pull $repo[$ro][0]"
			}
				
			my $arg = shift @args;
			system "git checkout -f $arg";
			chdir $pwd;
		}
        elsif ($arg eq "-l"){
			if (-d "shared/.git") {
				chdir("shared");
				system "git pull $repo[$ro][1]";
			}
			else {
				system "mkdir -p shared";
				chdir ("shared");
				system "git init";
				system "git remote add origin $repo[$ro][1]";
				system "git pull $repo[$ro][1]"
			}
				
			my $arg = shift @args;
			system "git checkout -f $arg";
			chdir $pwd;
		}
        elsif ($arg eq "-s"){
			if (-d "server/.git") {
				chdir("server");
				system "git pull $repo[$ro][2]";
			}
			else {
				system "mkdir -p server";
				chdir ("server");
				system "git init";
				system "git remote add origin $repo[$ro][2]";
				system "git pull $repo[$ro][2]"
			}
				
			my $arg = shift @args;
			system "git checkout -f $arg";
			chdir $pwd;
		}
        elsif ($arg eq "-a"){
			$arg = shift @args;
			if ($arg =~ /^\s/ ) { $arg = "HEAD";}
			push @args, " ";
			unshift @args, "$arg";
			unshift @args, "-s";
			unshift @args, "$arg";
			unshift @args, "-l";
			unshift @args, "$arg";
			unshift @args, "-c";
		}
		elsif ($arg eq "--clean"){
			rmtree "client",0,0;
			rmtree "server",0,0;
			rmtree "shared",0,0;
		}

    }
}

main(@ARGV);

 
