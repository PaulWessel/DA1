#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to CO2 spectrum: a) just the data
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.55 PS_SCALE_Y 0.5
#-------------------------------------------------
gmt set FONT_ANNOT_PRIMARY 11p FONT_LABEL 13p MAP_LABEL_OFFSET 0.05i
gmt psxy -R1958/2016/310/405 -JX6i/1.5i -P -K -Sc1p -Gblack -Bxa -Bya+l"CO@-2@- (ppm)" -BWS ../problems/CO2.txt --MAP_FRAME_TYPE=graph > $FIG.ps
gmt trend1d ../problems/CO2.txt -i0,2 -Fxm -Np2 | gmt psxy -R -J -O -K -W1p >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
