#!/bin/csh
#	$Id: Fig1_boxwhisker.csh 507 2016-05-23 00:54:38Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Demonstrate a Box-and-Whisker symbol
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
#-------------------------------------------------

gmt set PS_SCALE_X 0.9 PS_SCALE_Y 0.9 
gmt psxy -R0/4/0/1 -JX4i/0.6i -P -K -Glightgreen << EOF >! $FIG.ps
0.6 0.35
2.5 0.35
2.5 0.65
0.6 0.65
0.6 0.35
EOF
gmt psxy -R -J -O -K -W1p << EOF >> $FIG.ps
>
0.6 0.35
2.5 0.35
2.5 0.65
0.6 0.65
0.6 0.35
>
0 0.5
0.6 0.5
>
2.5 0.5
4 0.5
>
1.3 0.35
1.3 0.65
EOF
gmt psxy -R -J -O -K -Sc0.075i -Gblack -N << EOF >> $FIG.ps
0 0.5
4 0.5
EOF
gmt pstext -R -J -O -N -Dj0i/0.05i -F+f8p,Times-Roman+jCT << EOF >> $FIG.ps
0 0.45  Min value
4 0.45  Max value
0.6 0.2 25% quartile
2.5 0.2 75% quartile
1.3 0.2 Median
EOF

#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
