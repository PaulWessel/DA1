#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Draw truncation
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------
# uses trunc1.d from last script
gmt math -T0.15/0.85/0.01 T PI MUL 3.7 MUL SIN 0 0.2 NRAND ADD 0.9 MUL = | gmt filter1d -Fg0.1 -E >! trunc1.d

awk '{print $1-0.71,$2}' trunc1.d >! t.d
cat trunc1.d >> t.d
awk '{print $1+0.71,$2}' trunc1.d >> t.d

gmt psxy -R-0.6/1.6/-1.1/1.1 -JX5i/1i -P -K -Se -Glightgray -N << EOF >! $FIG.ps
0.15 0.25 90 1i 0.25i
0.85 0.25 90 1i 0.25i
EOF
gmt psxy -R -J -O -K -W1p t.d >> $FIG.ps
gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N << EOF >> $FIG.ps
-0.6 0 0 5i
0.5 0 90 0.5i
EOF
gmt pstext -R -J -O -Dj0.05i/0.05i -N -F+f10p,Times-Italic+jTC << EOF >> $FIG.ps
-0.55 -1 -3T/2
0.15 -1 -T/2
0.5 -1  0
0.85 -1 T/2
1.55 -1 3T/2
1.6 0 t
EOF
\rm -f t.d trunc1.d
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
