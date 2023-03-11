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
gmt math -T0/1/0.01 T 2 MUL PI MUL SIN 0.7 MUL = sin.d
gmt math -T0/1/0.01 T 4 MUL PI MUL SIN 0.7 MUL = sin2.d

gmt psxy -R0/1/-1/1 -JX3.5i/1i -P -K -W1p -Bxa0f0.5 -By0g2 -Bws sin.d >! $FIG.ps
gmt psxy -R -J -O -K -W0.5p,- sin2.d >> $FIG.ps
gmt psxy -R -J -O -K -Sv0.1i+bt+et+s -Gblack -W0.25p -N << EOF >> $FIG.ps
0 1.1 1 1.1
EOF
gmt pstext -R -J -O -N -Gwhite -F+f12p,Times-Italic+j << EOF >> $FIG.ps
0.5 1.1 CM T
0.5 -1.2 TC @~p@~
1 -1.2 TC 2@~p@~
EOF
\rm -f sin.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
