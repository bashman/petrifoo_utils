#!/usr/bin/perl

use strict;
use warnings;

use XML::Writer;
use IO qw(Handle Seekable File Pipe Socket Dir);

my @files;
my $file;
my $i;

my $pathName;

my $wavsDir = $ARGV[0];
my $oFile = $ARGV[1];

my $oFIlename = $oFile . ".petri-foo";

if (($#ARGV == -1) or (($ARGV[0] eq "-h") or ($ARGV[0] eq "--help")))
	{
   		&little_help;
	}
else
   {
   	&play;
   }

sub little_help
	{
		print "\n";
		print "A little help\n";
		print "\n";
		exit();
	}

sub play
	{
		$i = 0;
		# open an read the directory and put in the array
	   	opendir(DIR, $wavsDir);
		my @files = grep(/\.wav$/,readdir(DIR));
		closedir(DIR);


		@files = sort (@files);


		my $output = new IO::File(">$oFIlename");
		my $writer = new XML::Writer(OUTPUT => $output, DATA_MODE => 1, DATA_INDENT => 2);
		$writer->xmlDecl("UTF-8");  
		$writer->startTag("Petri-Foo-Dish", "save-type" => "basic"); #Petri-Foo-Dish
		$writer->emptyTag("master", "level" => "1.000000", "samplerate" => "48000");	
		


		# print all the filenames.s
		foreach $file (@files) 
		{

  			$pathName = $wavsDir ."/". $file; 
  			$writer->startTag("Patch", "name" => "$file", "channel" => "0"); #patch	
				$writer->startTag("Sample", "file" => "$pathName", "mode" => "trim", "reverse" => "false", "to_end" => "false");#sample
					$writer->emptyTag("Play", "start" => "1", "stop" => "40000", "fade_samples" => "108");
					$writer->emptyTag("Loop", "start" => "108", "stop" => "19853", "xfade_samples" => "108");
					$writer->emptyTag("Note", "root" => "$i", "lower" => "$i", "upper" => "$i", "velocity_lower" => "0", "velocity_upper" => "127");    		
				$writer->endTag("Sample"); #sample    
			$writer->endTag("Patch"); #patch  
		   #print "$file\n";
		   $i++;
		}
			 	
			$writer->endTag("Petri-Foo-Dish"); #Petri-Foo-Dish
			$writer->end();
			$output->close();				
}