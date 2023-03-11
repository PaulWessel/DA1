#!/bin/csh
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
gmt set PS_SCALE_X 0.7 PS_SCALE_Y 0.7
#-------------------------------------------------
gmt math -T-1.1/1.1/0.02 T 10 PI MUL MUL COS 0.05 MUL 1 T ABS SUB ADD = wiggle.d

gmt psxy -R-1.5/1.5/0/1.1 -JX3i/0.8i -P -K wiggle.d >! $FIG.ps
echo "-1.5 0 0 3i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N >> $FIG.ps
echo "0 0 90 1i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N >> $FIG.ps
gmt pstext -R -J -O -Dj0.05i/0.05i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
0.25 1 BL D(f)
0 0 TC 0
1 0 TC f@-N@-
1.5 0 TC f
EOF
#-------------------------------------------------
# Post-processing
rm -f wiggle.d

if ($#argv == 1) then
	gv $FIG.ps &
endif
