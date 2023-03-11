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
#-------------------------------------------------
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8
cat << EOF | gmt sample1d -I0.1 -Fl >! gt.d
0 0
1 0.2
2 0.3
4 0.2
5 0.1
6 0.25
7 0.2
8 0.07
9 0.2
10 0.22
11 0.4
12 0.35
13 0.2
14 0
EOF

gmt filter1d -Fg5 -E gt.d >! ft.d
gmt psxy -R0/16/0/1 -JX3.5i/1i -P -K -W1p ft.d >! $FIG.ps
gmt psxy -R -J -O -K -W0.25p,- gt.d >> $FIG.ps
echo "0 0 0 3.5i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N >> $FIG.ps
gmt pstext -R -J -O -Dj0.05i/0.05i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
0.5 0.4 LM h(t)
16 0 TC t
EOF
\rm -f gt.d ft.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
