#!/usr/bin/perl -s

my $una= `uname` ;
my $arch3= lc substr( $una, 0, 3 ) ;

my %setups= ( lin => '-geom 92x16+0+2279 -fg white',
		sun => '-geom 92x16+0+1148 -fg white -bg #083000',
		aix => '-geom 92x16+0+896 -fg white -bg #280400',
		) ;

print "arch3: $arch3\n" if $a ;
print "$setups{$arch3}" ;

print "\n\n" if -t ;

