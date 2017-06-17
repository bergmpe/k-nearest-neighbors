#created by Carlos Williamberg 06/06/2017
use strict;
use warnings;
use constant K => 3;

my $data_set = 'iris.data';
my $test_set = 'iris.test';
my %classes;
my %test_classes;

open my $info, $data_set or die  "Could not open the file $data_set";
open my $test, $test_set or die  "Could not open the file $test_set";

#read data set.
while (<$info>) {
	my ($attributes, $class_name) = split(/,I/);
	$classes {$attributes} = "I".$class_name;
}
close $info;

#read test set.
while (<$test>) {
	my ($attributes, $class_name) = split(/,I/);
	$test_classes {$attributes} = "I".$class_name;
}
close $test;

#subimit the test set to classifier.
for(keys %test_classes){
	print "test class: $test_classes{$_}, classify: ", classify_knn($_), "\n";
}
 
sub classify_knn{
	my @neighbors;
	my ($min_distance, $min_distance_key) = 100, 0;
	for my $key (keys %classes){
		my $current_distance = distance($key, $_[0]);
		if ($current_distance <= $min_distance){
			shift @neighbors if @neighbors == K;
			push @neighbors, $classes{$key};
			$min_distance = $current_distance;
		}
	}
	return mode(@neighbors);
}

sub distance{
	my $result = 0;
	my @attributes0 = split(/,/, shift);
	my @attributes1 = split(/,/, shift);
	for my $i (0..$#attributes0){
		$result += abs $attributes0[$i] - $attributes1[$i];
	}
	return $result;
}

sub mode{
	my %classes_count;
	my ($max, $max_key) = (0, "none");
	foreach(@_){ $classes_count{$_} = $classes_count{$_} ? $classes_count{$_} + 1: 1;}
	while ( my($key, $value) = each %classes_count ){
		 $max_key = $key, $max = $value if $value > $max;
	}
	return $max_key;
}
