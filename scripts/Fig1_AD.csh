#!/bin/csh
#	$Id: Fig1_AD.csh 630 2018-07-28 20:59:29Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Strike/Dip plot
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
#-------------------------------------------------
gmt psxy -R-2/3/-2.25/2 -Jx0.5i -P -K -Sv0.1i+e -N -Gblack -Wthicker,black << EOF >! $FIG.ps
0 0 -90 1.2i
EOF
gmt psxy -R -J -O -K -Glightgreen@25 << EOF >> $FIG.ps
> plane
0.4 -2.25
2.6 -0.65
1.4 1
-0.85 -0.65
0.4 -2.25
EOF
gmt psxy -R -J -O -K -Glightred@50 << EOF >> $FIG.ps
0 0
1.25 -0.5
1.25 -1.5
EOF
gmt psxy -R -J -O -K -Sv0.1i+e -N -Gblack -Wthicker,black << EOF >> $FIG.ps
0 0 0 1.25i
0 0 -50 0.98i
0 0 135 1i
EOF
gmt psxy -R -J -O -K << EOF >> $FIG.ps
> ONP -W0.25p,-
0 0
1.25 -0.5
1.25 -1.5
> plane
0.4 -2.25
2.6 -0.65
1.4 1
-0.85 -0.65
0.4 -2.25
EOF
awk 'BEGIN {for (a = 34; a <= 135; a++) print 0.5 * cos (0.01745329 * a), 0.5 * sin (0.01745329 * a)}' /dev/null | gmt psxy -R -J -O -K -W0.25p >> $FIG.ps
awk 'BEGIN {for (a = -48; a <= -21; a++) print 0.75 * cos (0.01745329 * a), 0.75 * sin (0.01745329 * a)}' /dev/null | gmt psxy -R -J -O -K -W0.25p >> $FIG.ps
gmt pstext -R -J -O -F+f+j<< EOF >> $FIG.ps
-1.1 1.25  10p,Times-Roman LB @%6%x@%% (north)
2.05 0.25  10p,Times-Roman LM @%6%y@%% (east)
-0.15 -2.1  10p,Times-Roman RM @%6%z@%% (down)
1.35 -1.5  10p,Times-Bold LM P
1.35 -0.5  10p,Times-Bold LM N
-0.15 0    10p,Times-Bold RM O
0.45 -0.31 10p,Times-Bold CM D
0.05 0.35  10p,Times-Bold CM A
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
