use 5.006001;
use strict;
use warnings;
use ExtUtils::MakeMaker;
use Config qw(%Config);
use IPC::Open3;

# Allows to suppress all program installation with -n (library only)
use Getopt::Std;
our $opt_n;
getopts("n") || die "Usage: $0 [-n]\n";

my @programs_to_install;

unless ($opt_n) {
    print <<EOT

This package comes with a sample programs that I can try
to install in $Config{installscript}.

   Note that you can avoid this question by passing
   the '-n' option to 'Makefile.PL'.

EOT
;
    push @programs_to_install, "bin/gloss.pl" if 
        prompt("Install gloss.pl, a commandline graph layouter ?", "y") =~ /^y/i;
}

for (qw(Graph::Directed Graph::Undirected)) {
    next if eval "require $_";
    print "You don't seem to have the optional '$_' package. Not fatal.\n";
}

my $MIN_VERSION = 3.7;
{
    my $program = "gnuplot";
    my ($rd, $wr);
    local *ERR;
    if (defined(my $pid = eval { open3($wr , $rd, \*ERR, $program) })) {
        print $wr "show version\n";
        close($wr);
        my $out = do { local $/; my $out = <ERR>; close ERR; $out || "" };
        if ($out =~ /Version\s+(\d+\.\d+)\s+/) {
            my $version = $1;
            if ($version < $MIN_VERSION) {
                print("You have $program version $version, but I wanted at least $MIN_VERSION. Not fatal\n");
            }
            next;
        }
    }
    print "You don't seem to have the optional '$program' program. Not fatal.\n";
}

WriteMakefile
    (NAME		=> 'Graph::Layout::Aesthetic',
     VERSION		=> '0.02',
     PERL_MALLOC_OK	=> 1,
     PREREQ_PM		=> {
         "Test::More"		=> 0.11,	# For the tests only
     },
     ($] >= 5.005 ?
      (AUTHOR		=> 'Ton Hospel <Graph::Layout::Aesthetic@ton.iguana.be>') : ()),
     depend => {
         # Evil hack, probably unportable
         'lib/Graph/Layout/Aesthetic/Include.pm' => '$(H_FILES) typemap gen_include
	$(FULLPERL) gen_include $@ $^'
     },
     # OPTIMIZE		=> "-g",
     LIBS		=> [''], # e.g., '-lm'
     DEFINE		=> '',   # e.g., '-DHAVE_SOMETHING'
     INC		=> '-I include',
     H			=> [qw(include/aesth.h include/aglo.h 
                               include/at_centroid.h include/at_node_level.h 
                               include/at_sample.h include/defines.h 
                               include/point.h)],
     OBJECT		=> q/$(O_FILES)/,
     EXE_FILES		=> \@programs_to_install,
     );
