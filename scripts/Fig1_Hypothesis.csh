#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke ghostview
#
# Purpose: Chapter 2 headline fig
# Needs: data/Hypothesis.jpg
set name = $0
set FIG = $name:r
#------------------------------------------------- 
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.65 PS_SCALE_Y 0.65

gmt psimage data/Hypothesis.jpg -W3i -P -F+p0.25p >! $FIG.ps

#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
# Clean up
