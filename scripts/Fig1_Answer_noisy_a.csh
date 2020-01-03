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
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 9p FONT_LABEL 12p
gmt psxy -R3300/5500/-5/65 -JX6i/1.25i -P -K -Bxa -Byaf -BWS -W0.25p ../problems/noisy.txt --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt trend1d ../problems/noisy.txt -Np1,F1+l1050 -Fxm | gmt psxy -R -J -O -K -W1p >> $FIG.ps
echo 4250 5 5250 5 | gmt psxy -R -J -O -K -Sv0.1i+s+et+bt -W0.5p >> $FIG.ps
echo "4750 5 ~1000" | gmt pstext -R -J -O -K -F+f12p,+jCM -Gwhite >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
