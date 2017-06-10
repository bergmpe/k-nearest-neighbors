#created by Carlos Williamberg 06/06/2017
use strict;
use warnings;
use constant K => 3;

my $file = 'iris.data';
my %classes;

open my $info, $file or die  "Could not open the file $file";

while (<$info>) {
	my ($attributes, $class_name) = split(/,I/);
	$classes {$attributes} = "I".$class_name;
}
close $info;

while(1){
	print "Enter the attributes separated by , : ";
	chomp (my $attributes = <STDIN>);
	print classify_knn($attributes);
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