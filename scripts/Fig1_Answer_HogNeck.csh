#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to HogNeck data
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.5 PS_SCALE_Y 0.5
#-------------------------------------------------
gmt set FONT_ANNOT_PRIMARY 11p FONT_LABEL 13p MAP_LABEL_OFFSET 0.05i
gmt psxy -R2009-06-13T00:00:00/2009-06-15T/0/360 ../problems/HogNeck.txt -W1p -Bpxa6hf6h -Bsx1D -Bpyaf+u\\232 -BWSn -JX6iT/2.5i -i0,2 -K -P > $FIG.ps
gmt psxy -R2009-06-13T00:00:00/2009-06-15T/0/3.5 -J -O -K ../problems/HogNeck.txt -i0,1 -W0.5p,- -Byaf+lm/s -BE >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
