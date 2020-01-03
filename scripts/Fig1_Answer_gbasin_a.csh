#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to gravity over sedimentary basin
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.5 PS_SCALE_Y 0.5
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 11p FONT_LABEL 13p MAP_LABEL_OFFSET 0.05i
gmt psxy ../problems/basingrav.txt -R-60/60/-100/10 -JX6i/1.5i -P -K -Sc0.1c -Gblack -Bxa+l"Distance (km)" -Bya+l"FAA (mGal)" -BWS --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt psxy ../problems/g_basin_model.txt -R -J -O -W0.25p >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
