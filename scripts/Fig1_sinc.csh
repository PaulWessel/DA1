#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: rectangle vs sinc functions
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.7 PS_SCALE_Y 0.7
#-------------------------------------------------

gmt psxy -R-6/6/0/1 -JX2.5i/1i -P -K -W1p << EOF >! $FIG.ps
-6 0
-5 0
-5 0.5
5 0.5
5 0
6 0
EOF
gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -N -Wthick,black << EOF >> $FIG.ps
-6 0 0 2.5i
0 0 90 1i
EOF
gmt pstext -R -J -O -K -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
1 0.9 TC g(t)
6 -0.05 TC t
-5 -0.1 TC T/2
5 -0.1 TC T/2
EOF

gmt math -T-5.2/5.2/0.02 T PI MUL DUP SIN EXCH DIV = ft.d

gmt psxy -R-0.01/0.01/0/1 -Jx1i -O -K -X2.625i -W5p,lightgray,4_4:0p << EOF >> $FIG.ps
0	0
0	1
EOF

gmt psxy -R-6/6/-0.5/1 -JX2.5i/1i -O -K -W1p ft.d -X0.125i -Y-0.32i  >> $FIG.ps
gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -N -Wthick,black << EOF >> $FIG.ps
-6 0 0 2.5i
0 0 90 1i
#2.5 0.4 220 0.3i
EOF
gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -N -Wthin,black << EOF >> $FIG.ps
2.5 0.4 220 0.3i
EOF
echo "1 0" | gmt psxy -R -J -O -K -Sc0.1i -W0.25p >> $FIG.ps
gmt pstext -R -J -O -Dj0.05/0.05 -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
0.5 1.1 LB G(f)
0 -0.05 TC 0
6 -0.05 TC f
2.55 0.425 LB f = 1/T
EOF
rm -f ft.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
