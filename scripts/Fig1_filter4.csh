#!/bin/csh
#	$Id: Fig1_filter4.csh 617 2017-12-06 19:10:05Z pwessel $
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
gmt math -T0/1/0.002 0 1 NRAND = | gmt filter1d -Fg0.075 | gmt filter1d -Fg0.2 >! smooth.d
gmt math smooth.d T 300 MUL SIN 0.015 MUL ADD = jittery.d
set range = `gmt info -i1 -C jittery.d -I0.05`
set ymax = `gmt math -Q $range[2] 0.2 ADD =`
gmt psxy -R0.15/0.85/$range[1]/$ymax -JX4i/1i -P -K -W0.5p jittery.d >! $FIG.ps
gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N << EOF >> $FIG.ps
0.15 0 0 4.25i
0.15 $range[1] 90 1i
EOF
gmt pstext -R -J -O -Dj0.05i/0.05i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
0.16 $ymax TL h(t)
0.9 0 TC t
EOF
\rm -f jittery.d smooth.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
