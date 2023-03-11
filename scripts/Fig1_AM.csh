#!/bin/csh
#	$Id: Fig1_AM.csh 507 2016-05-23 00:54:38Z pwessel $
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
gmt set PS_SCALE_X 0.75 PS_SCALE_Y 0.75 PS_COMMENTS true
#-------------------------------------------------
gmt math -T0/4/0.01 T PI MUL SIN 0.9 MUL = env1.d
gmt math -T0/4/0.01 T PI MUL SIN NEG 0.9 MUL = env2.d
gmt math -T0/4/0.01 T 6 MUL PI MUL SIN T PI MUL SIN MUL 0.9 MUL = am.d
cp env1.d env.d
gmt convert -I env2.d >> env.d
gmt psxy -R-0.05/4/-1/1.5 -JX4.05i/1i -P -K env.d -Glightgray >! $FIG.ps
gmt psxy -R -J -O -K -W1p -Bx0 -By0g2 -BWS am.d --MAP_FRAME_TYPE=graph >> $FIG.ps
gmt psxy -R -J -O -K -W0.25p,- env[12].d >> $FIG.ps
gmt psxy -R -J -O -K -Sv0.1i+bt+et+s -Gblack -Wthin -N << EOF >> $FIG.ps
0 1 2 1
2.33333 1 2.66667 1
EOF
gmt pstext -R -J -O -N -F+f10p,Times-Italic+jCM << EOF >> $FIG.ps
1 1.25 2@~p/dw@~
2.5 1.25 2@~p/w@~
EOF
\rm -f am.d env1.d env2.d env.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
