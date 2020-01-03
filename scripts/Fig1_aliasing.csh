#!/bin/csh
#	$Id: Fig1_aliasing.csh 617 2017-12-06 19:10:05Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Draw autocorrelating
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------
gmt math -T0/1/0.002 T PI MUL 15 MUL SIN 0.9 MUL = short.d
gmt math -T0/1/0.002 T PI MUL 3 MUL SIN 0.9 MUL = long.d
gmt sample1d short.d -I0.1666666 > picks.d
gmt psxy -R0/1/-1.05/1.2 -JX4i/1i -P -K -W1p,2_2:0p -Bx0 -By0g2 -BWS long.d --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt psxy -R -J -O -K -W0.25p short.d >> $FIG.ps
gmt psxy -R -J -O -K -Sc0.1i -Glightgray picks.d -W0.25p -N >> $FIG.ps
gmt psxy -R -J -O -Sc0.05i -Gblack picks.d -N >> $FIG.ps
\rm -f short.d long.d picks.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
