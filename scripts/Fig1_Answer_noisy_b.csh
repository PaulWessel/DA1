#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to noisy.txt frequency: misfit scanning
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 9p FONT_LABEL 12p
gmt psxy -R900/1200/0/20000 -JX6i/1.25i -P -K -Bxa+l"Trial period" -Byaf+l"Misfit" -BWS -W0.5 E_noisy.txt --MAP_FRAME_TYPE=graph >! $FIG.ps
echo 1082 0 1082 7000 | gmt psxy -R -J -O -K -Sv0.1i+s -W0.5p >> $FIG.ps
echo "1082 8000 T = 1082" | gmt pstext -R -J -O -K -F+f12p,+jCM -Gwhite >> $FIG.ps
echo "1000 6911" | gmt psxy -R -J -O -K -Sc0.1i -Gwhite -W0.25p >> $FIG.ps
echo "1082 3524.2099" | gmt psxy -R -J -O -K -Sc0.1i -Gblack >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
