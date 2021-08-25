#!/usr/bin/env perl
# BSD 3-Clause License
# 
# Copyright (C) 2007, 2008, 2009, 2010 Apple Inc.  All rights reserved.
# Copyright (c) 2020, Ryan Stortz (@withzombies)
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
# 
# 3. Neither the name of the copyright holder nor the names of its
#    contributors may be used to endorse or promote products derived from
#    this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Script to sort "children" and "files" sections in Xcode project.pbxproj files

use strict;
use warnings;

use File::Basename;
use File::Spec;
use File::Temp qw(tempfile);
use Getopt::Long;

sub sortChildrenByFileName($$);
sub sortFilesByFileName($$);

my $printWarnings = 1;
my $showHelp;
my $checkOnly = 0;

my $getOptionsResult = GetOptions(
    'h|help'         => \$showHelp,
    'w|warnings!'    => \$printWarnings,
    'c|check'        => \$checkOnly,
);

if (scalar(@ARGV) == 0 && !$showHelp) {
    print STDERR "ERROR: No Xcode project files (project.pbxproj) listed on command-line.\n";
    undef $getOptionsResult;
}

if (!$getOptionsResult || $showHelp) {
    print STDERR <<__END__;
Usage: @{[ basename($0) ]} [options] path/to/project.pbxproj [path/to/project.pbxproj ...]
  -h|--help           show this help message
  -c|--check          check if projects are sorted
  -w|--[no-]warnings  show or suppress warnings (default: show warnings)
__END__
    exit 1;
}

for my $projectFile (@ARGV) {
    if (basename($projectFile) =~ /\.xcodeproj$/) {
        $projectFile = File::Spec->catfile($projectFile, "project.pbxproj");
    }

    if (basename($projectFile) ne "project.pbxproj") {
        print STDERR "WARNING: Not an Xcode project file: $projectFile\n" if $printWarnings;
        next;
    }

    # Grab the mainGroup for the project file.
    my $mainGroup = "";
    open(IN, "< $projectFile") || die "Could not open $projectFile: $!";
    while (my $line = <IN>) {
        $mainGroup = $2 if $line =~ m#^(\s*)mainGroup = ([0-9A-F]{24}( /\* .+ \*/)?);$#;
    }
    close(IN);

    my ($OUT, $tempFileName) = tempfile(
        basename($projectFile) . "-XXXXXXXX",
        DIR => dirname($projectFile),
        UNLINK => 0,
    );

    # Clean up temp file in case of die()
    $SIG{__DIE__} = sub {
        close(IN);
        close($OUT);
        unlink($tempFileName);
    };

    my @lastTwo = ();
    open(IN, "< $projectFile") || die "Could not open $projectFile: $!";
    while (my $line = <IN>) {
        if ($line =~ /^(\s*)files = \(\s*$/) {
            print $OUT $line;
            my $endMarker = $1 . ");";
            my @files;
            while (my $fileLine = <IN>) {
                if ($fileLine =~ /^\Q$endMarker\E\s*$/) {
                    $endMarker = $fileLine;
                    last;
                }
                push @files, $fileLine;
            }
            my @sortedFiles = sort sortFilesByFileName @files;
            if ("@files" ne "@sortedFiles" and $checkOnly) {
                die "Projects must be sorted in --check mode";
            }

            print $OUT @sortedFiles;
            print $OUT $endMarker;
        } elsif ($line =~ /^(\s*)children = \(\s*$/) {
            print $OUT $line;
            my $endMarker = $1 . ");";
            my @children;
            while (my $childLine = <IN>) {
                if ($childLine =~ /^\Q$endMarker\E\s*$/) {
                    $endMarker = $childLine;
                    last;
                }
                push @children, $childLine;
            }
            if ($lastTwo[0] =~ m#^\s+\Q$mainGroup\E = \{$#) {
                # Don't sort mainGroup
                print $OUT @children;
            } else {
                my @sortedChildren = sort sortChildrenByFileName @children;
                if ("@children" ne "@sortedChildren" and $checkOnly) {
                    die "Projects must be sorted in --check mode";
                }
                print $OUT @sortedChildren;
            }
            print $OUT $endMarker;
        } else {
            print $OUT $line;
        }

        push @lastTwo, $line;
        shift @lastTwo if scalar(@lastTwo) > 2;
    }
    close(IN);
    close($OUT);

    if (!$checkOnly) {
        unlink($projectFile) || die "Could not delete $projectFile: $!";
        rename($tempFileName, $projectFile) || die "Could not rename $tempFileName to $projectFile: $!";
    } else {
        unlink($tempFileName);
    }
}

exit 0;

sub sortChildrenByFileName($$)
{
    my ($a, $b) = @_;
    my $aFileName = $1 if $a =~ /^\s*[A-Z0-9]{24} \/\* (.+) \*\/,$/;
    my $bFileName = $1 if $b =~ /^\s*[A-Z0-9]{24} \/\* (.+) \*\/,$/;
    my $aSuffix = $1 if $aFileName =~ m/\.([^.]+)$/;
    my $bSuffix = $1 if $bFileName =~ m/\.([^.]+)$/;
    if ((!$aSuffix && $bSuffix) || ($aSuffix && !$bSuffix)) {
        return !$aSuffix ? -1 : 1;
    }
    if ($aFileName =~ /^UnifiedSource\d+/ && $bFileName =~ /^UnifiedSource\d+/) {
        my $aNumber = $1 if $aFileName =~ /^UnifiedSource(\d+)/;
        my $bNumber = $1 if $bFileName =~ /^UnifiedSource(\d+)/;
        return $aNumber <=> $bNumber;
    }
    return lc($aFileName) cmp lc($bFileName);
}

sub sortFilesByFileName($$)
{
    my ($a, $b) = @_;
    my $aFileName = $1 if $a =~ /^\s*[A-Z0-9]{24} \/\* (.+) in /;
    my $bFileName = $1 if $b =~ /^\s*[A-Z0-9]{24} \/\* (.+) in /;
    if ($aFileName =~ /^UnifiedSource\d+/ && $bFileName =~ /^UnifiedSource\d+/) {
        my $aNumber = $1 if $aFileName =~ /^UnifiedSource(\d+)/;
        my $bNumber = $1 if $bFileName =~ /^UnifiedSource(\d+)/;
        return $aNumber <=> $bNumber;
    }
    return lc($aFileName) cmp lc($bFileName);
}
