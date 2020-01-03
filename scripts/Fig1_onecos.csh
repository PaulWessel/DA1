#!/bin/csh
#	$Id: Fig1_onecos.csh 665 2018-12-06 16:40:23Z pwessel $
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
gmt math -T0/3.2/0.01 T 2 MUL PI MUL 2 SUB COS 0.7 MUL = cos.d

gmt psxy -R0/3.2/-1/1 -JX3.5i/1i -P -K -W1p -Bx -By0g2 -BWS cos.d --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt pstext -R -J -O -N -F+f12p,Times-Italic+j << EOF >> $FIG.ps
3.5 -1.06 LT t
-0.05 1 RT d
EOF

#-------------------------------------------------
# Post-processing
rm -f cos.d
if ($#argv == 1) then
	gv $FIG.ps &
endif
