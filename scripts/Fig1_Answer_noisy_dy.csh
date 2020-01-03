#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to noisy.txt frequency
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.55 PS_SCALE_Y 0.55
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 11p FONT_LABEL 13p
gmt trend1d ../problems/noisy.txt -Np1 -Fxr > tmp.txt
gmt psxy -R3300/5500/-25/25 -JX6i/1.25i -P -K -Bxa -Byafg1000 -BWS -Wfaint tmp.txt --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
rm -f tmp.txt
if ($#argv == 1) then
	gv $FIG.ps &
endif
