#!/bin/csh
#	$Id: Fig1_sampl7.csh 665 2018-12-06 16:40:23Z pwessel $
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
cp -f wiggle.d t.d
awk '{print $1+2.2, $2}' wiggle.d >> t.d
awk '{print $1+4.4, $2}' wiggle.d >> t.d
awk '{print $1+6.6, $2}' wiggle.d >> t.d
awk '{print $1+8.8, $2}' wiggle.d >> t.d
gmt psxy -R1.1/8/0/1.1 -JX4i/0.8i -P -K -W0.5p,- t.d >! $FIG.ps
cat << EOF >! step.d
0 0
3.3 0
3.3 1
5.5 1
5.5 0
8 0
EOF
gmt psxy -R -J -O -K step.d -W1p >> $FIG.ps
awk '{if ($1 >= 3.3 && $1 <= 5.5) print $0}' t.d | gmt psxy -R -J -O -K -W0.5p >> $FIG.ps
echo "1 0 0 4.2i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N >> $FIG.ps
echo "4.4 0 90 1i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N >> $FIG.ps
gmt pstext -R -J -O -Dj0.05i/0.05i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
4.7 0.75 BL D(f)
3.3 1 BC H(f)
8.4 0 TC f
EOF
\rm -f step.d t.d wiggle.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
