#!/bin/csh
#	$Id: Fig1_aliasing2.csh 670 2018-12-20 20:37:20Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Draw autocorrelating
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA2 gmt.conf
gmt set PS_SCALE_X 0.75 PS_SCALE_Y 0.75
#-------------------------------------------------
gmt math -T0/1/0.002 T PI MUL 15 MUL SIN 0.9 MUL = short.d
gmt math -T0/1/0.002 T PI MUL 3 MUL SIN 0.9 MUL = long.d
gmt sample1d short.d -I0.1666666 > picks.d
gmt math -T1/5.8/1.6 0.9  = | awk '{print $1/6, $2}' > picks2.d
gmt psxy -R0/1/-1.05/1.2 -JX4i/1i -P -K -W1p,2_2:0p -Bx0 -By0g2 -BWS long.d --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt psxy -R -J -O -K -W0.25p short.d >> $FIG.ps
gmt psxy -R -J -O -K -W0.25p,- << EOF >> $FIG.ps
0.01	0.9
0.99	0.9
EOF
gmt psxy -R -J -O -K -Sc0.1i -Glightgray picks.d -W0.25p -N >> $FIG.ps
gmt psxy -R -J -O -K -Sc0.05i -Gblack picks.d -N >> $FIG.ps
gmt psxy -R -J -O -K -Sc0.05i -Gblack picks2.d -N >> $FIG.ps
gmt psxy -R -J -O -K -Ss0.15i -W0.75p picks2.d -N >> $FIG.ps
echo 0.1666666 1.1 0.3 1.1 | gmt psxy -R -J -O -K -N -Sv0.075i+s+bt+et -Gblack -W0.5p >> $FIG.ps
echo 0.2333333 1.1 P | gmt pstext -R -J -O -K -N -F+f10p,Times-Italic,black+jCM -Gwhite >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
\rm -f short.d long.d picks.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
