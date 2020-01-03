#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Heatflow modeling
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 9p FONT_LABEL 12p MAP_LABEL_OFFSET 0.05i
gmt psbasemap -R0/250/30/120 -JX4i/2i -P -K -Bxa50f25+l"Distance from ridge (km)" -Bya50f25+l"Heat flow (mW/m@+2@+)" -BWSne >! $FIG.ps
gmt math -T25/250/1 T -0.0404 MUL 44.1237 ADD 1686.8 T DIV ADD = | gmt psxy -R -J -O -K -W0.25p >> $FIG.ps
gmt psxy -R -J -O -Sc0.035i -G0 ../problems/heatflow.txt >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
