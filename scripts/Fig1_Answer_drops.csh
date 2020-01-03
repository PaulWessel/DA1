#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to drops on alien planet
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.75 PS_SCALE_Y 0.75
#-------------------------------------------------
set h0 = 6.2501
set gp = 16.0048
gmt set FONT_ANNOT_PRIMARY 9p FONT_LABEL 12p MAP_LABEL_OFFSET 0.05i
gmt math -T0/6/0.01 T 2 POW 2 DIV $gp MUL $h0 ADD = predict.txt
gmt psxy -R0/6/0/250 -JX5i/2i -P -Wfaint -Bxaf+l"Drop time (s)" -Byaf+l"height (m)" -BWS ../problems/drops.txt -Sc0.15c -Gblack -K >! $FIG.ps
gmt psxy -R -J -O -W0.5p,- predict.txt >> $FIG.ps
#-------------------------------------------------
# Post-processing
rm predict.txt
if ($#argv == 1) then
	gv $FIG.ps &
endif
