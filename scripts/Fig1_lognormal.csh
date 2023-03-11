#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Show normal and log-normal representation
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 9p FONT_LABEL 12p MAP_LABEL_OFFSET 0.05i
gmt psbasemap -R0/799/0/50 -JX2.25i/1i -P -K -Bxaf+l"Pb (ppm)" -Byaf+u% -BWS --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt pshistogram data/cropb.txt -R0/800/0/50 -T25 -Z1 -J -Glightgreen -W0.25p -O -K >> $FIG.ps
awk '{print $1, 0}' data/cropb.txt | gmt psxy -R -J -O -K -Ss0.1c -Gred -N >> $FIG.ps
# Need increments of 0.1 so select form 0.7 to 2.9 in log space and get corresponding values
set x0 = `gmt math -Q 10 0.7 POW =`
set x1 = `gmt math -Q 10 2.9 POW =`
gmt pshistogram data/cropb.txt -R0.7/2.9/0/19 -i1 -T0.1 -J -Byaf+u% -BW -Z1 -X3i -Glightgreen -W0.25p -O -K --MAP_FRAME_TYPE=graph >> $FIG.ps
gmt psbasemap -R$x0/$x1/0/20 -JX2.25il/1i -Bxa2f3+l"Pb (ppm)" -BS -O -K --MAP_FRAME_TYPE=graph >> $FIG.ps
awk '{print $2, 0}' data/cropb.txt | gmt psxy -R0.69897/2.90308/0/19 -JX2.25i/1i -O -Ss0.1c -Gred -N >> $FIG.ps
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
