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
gmt math -T-1.1/1.1/0.02 T 10 PI MUL MUL COS 0.05 MUL 1 T 1.1 MUL ABS SUB ADD = wiggle.d
cp -f wiggle.d t.d
awk '{print $1+2.2, $2}' wiggle.d >> t.d
awk '{print $1+4.4, $2}' wiggle.d >> t.d
awk '{print $1+6.6, $2}' wiggle.d >> t.d
awk '{print $1+8.8, $2}' wiggle.d >> t.d
gmt psxy -R0/7.8/0/1.1 -JX4i/0.8i -P -K t.d >! $FIG.ps
echo "0 0 0 4.2i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N >> $FIG.ps
echo "2.2 0 90 1i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N >> $FIG.ps
gmt pstext -R -J -O -Dj0.05i/0.05i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
2.45 1 BL D(f)
2.2 0 TC 0
3.3 0 TC f@-N@-
4.4 0 TC 1/@~D@~t
6.6 0 TC 2/@~D@~t
8.5 0 TC f
EOF
#-------------------------------------------------
# Post-processing
rm -f wiggle.d t.d

if ($#argv == 1) then
	gv $FIG.ps &
endif
