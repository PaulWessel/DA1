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
gmt set PS_SCALE_X 0.65 PS_SCALE_Y 0.65
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 11p FONT_LABEL 13p MAP_LABEL_OFFSET 0.05i
gmt psxy ../problems/g_basin_fit.txt -R3/6/100/500 -JX6i/1.5i -P -K -W0.25p -Bxa+l"Basin depth (km)" -Bya+l"Misfit" -BWS -i1,2 --MAP_FRAME_TYPE=graph >! $FIG.ps
echo 4 188.2897 | gmt psxy -R -J -O -K -Sx0.1i -W1p >> $FIG.ps
echo 4.9 126.0288 | gmt psxy -R -J -O -Sc0.1i -W0.25p >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
