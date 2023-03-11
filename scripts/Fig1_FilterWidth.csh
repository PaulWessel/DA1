#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Draw a Gaussian filter showing full-width
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8
#-------------------------------------------------
gmt math -T-4/4/0.1 T 2 POW NEG 0.5 MUL EXP = | gmt psxy -R-3.8/3.8/0/1.25 -JX4i/1i -Bxa0f1 -BS -W1p -P -K --MAP_FRAME_TYPE=graph >! $FIG.ps
echo "-3 1.2 3 1.2" | gmt psxy -R -J -O -K -Sv0.15i+bt+et+s -W0.5p -Gblack >> $FIG.ps
gmt psxy -R -J -O -K -W0.25p << EOF >> $FIG.ps
0	0
0	1.1
EOF
echo "0 1.2 W = 6@~s@~" | gmt pstext -R -J -O -K -N -F+f12p,Times-Italic -Gwhite >> $FIG.ps
gmt pstext -R -J -O -Dj0/0.1i -N -F+f10p+jCT << EOF >> $FIG.ps
-3 0 -3@~s@~
0 0 0
+3 0 +3@~s@~
+3.5 0 @%6%t@%%
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
