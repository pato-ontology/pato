#!/usr/bin/perl
use strict;

my ($n, $issue, $def) = @ARGV;

my $max = 15000;
my $ceil = 20000;
open(F,"pato-edit.obo");
my $idn;
my $genus;
while(<F>) {
    chomp;
    if (m@^id: PATO:(\d+)@) {
        $idn = $1;
        if ($idn >= $ceil) {
            next;
        }
        if ($idn > $max) {
            $max = $idn;
        }
    }
    if (m@^name: (.*)$@) {
        if ($1 eq $n) {
            $genus = "PATO:$idn";
        }
    }
}
close(F);

if (!$genus) {
    $def = "$def." unless $def =~ m@\.$@;
    
    $max ++;
    $genus = sprintf("PATO:%07d", $max);
    

    print "[Term]\n";
    print "id: $genus\n";
    print "name: $n\n";
    print "def: \"$def\" [https://github.com/pato-ontology/pato/issues/$issue]\n";
    print "subset: attribute_slim\n";
    print "is_a:\n";
    print "\n";
}

$max ++;

my $id = sprintf "PATO:%07d", $max;
my $nI = "increased $n";

print "[Term]\n";
printf "id: $id\n";
print "name: $nI\n";
print "def: \"An increase in $n.\" [https://github.com/pato-ontology/pato/issues/$issue]\n";
print "subset: value_slim\n";
print "intersection_of: $genus ! $n\n";
print "intersection_of: increased_in_magnitude_relative_to PATO:0000461 ! normal\n";
print "\n";


$max ++;
    
print "[Term]\n";
printf "id: PATO:%07d\n", $max;
print "name: decreased $n\n";
print "def: \"A decrease in $n.\" [https://github.com/pato-ontology/pato/issues/$issue]\n";
print "subset: value_slim\n";
print "intersection_of: $genus ! $n\n";
print "intersection_of: decreased_in_magnitude_relative_to PATO:0000461 ! normal\n";
print "relationship: is_opposite_of $id ! $nI\n";
print "\n";
    
print STDERR "NOW:\ngit commit -m 'added triad for $genus $n, fixes \#".$issue."' pato-edit.obo\n";
