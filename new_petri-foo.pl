#!/usr/bin/env perl
use XML::Writer;
use IO qw(Handle Seekable File Pipe Socket Dir);
my $output = new IO::File(">>output.xml");
my $writer = new XML::Writer(OUTPUT => $output, DATA_MODE => 1, DATA_INDENT => 2);

$writer->xmlDecl("UTF-8");    

$writer->startTag("Petri-Foo-Dish", "save-type" => "basic"); #Petri-Foo-Dish

	$writer->emptyTag("master", "level" => "1.000000", "samplerate" => "48000");	

	$writer->startTag("Patch", "name" => "1", "channel" => "0"); #patch	

	$writer->startTag("Sample", "file" => "cl1/001.wav", "mode" => "trim", "reverse" => "false", "to_end" => "false");#sample
		$writer->emptyTag("Play", "start" => "1", "stop" => "19853", "fade_samples" => "108");
		$writer->emptyTag("Loop", "start" => "108", "stop" => "19853", "xfade_samples" => "108");
		$writer->emptyTag("Note", "root" => "1", "lower" => "0", "upper" => "0", "velocity_lower" => "0", "velocity_upper" => "127");    		
	$writer->endTag("Sample"); #sample     

	$writer->endTag("Patch"); #patch  

$writer->endTag("Petri-Foo-Dish"); #Petri-Foo-Dish

$writer->end();

$output->close();