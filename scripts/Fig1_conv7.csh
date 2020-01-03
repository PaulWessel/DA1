#!/bin/csh
#	$Id: Fig1_conv7.csh 665 2018-12-06 16:40:23Z pwessel $
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
cat << EOF >! gt.d
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
gmt psxy -R0/16/0/1 -JX-3.5i/1i -P -K -W0.5p gt.d >! $FIG.ps
gmt psxy -R -J -O -K -Sc0.05i -Gblack gt.d -N >> $FIG.ps
echo "0 0 0 3.5i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N >> $FIG.ps
gmt pstext -R -J -O -K -Dj0.05i/0.05i -N -F+f12p,Times-Italic+j << EOF >> $FIG.ps
1 0.4 LM d(t) @%4%reversed@%%
16 0 TC t
EOF
cat << EOF >! ft.d
1 0
1 0.2
2 0.2
3 0.2
4 0.2
5 0.2
5 0
EOF
gmt psxy -R0/6/0/1 -JX1.4i/1i -O -K -W0.5p ft.d -X3.0i -Y-0.6i >> $FIG.ps
echo "0 0 0 1.4i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N >> $FIG.ps
echo "-2 0.1 180 1i" | gmt psxy -R -J -O -K -Sv0.3i+e -W4p -Gblack -N >> $FIG.ps
cat << EOF >! ft.d
1 0.2
2 0.2
3 0.2
4 0.2
5 0.2
EOF
gmt psxy -R -J -O -K -Sc0.05i ft.d -Gblack -N >> $FIG.ps
gmt pstext -R -J -O -Dj0.05i/0.05i -N -F+f12p,Times-Italic+j << EOF >> $FIG.ps
1 0.4 RM p(t)
5 0.2 LM 1/5
6 0 TC t
EOF
\rm -f gt.d ft.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
