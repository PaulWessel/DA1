#!/bin/csh
#	$Id: Fig1_phase.csh 665 2018-12-06 16:40:23Z pwessel $
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
gmt set PS_SCALE_X 0.9 PS_SCALE_Y 0.9
gmt math -T0/1/0.01 T 2 MUL PI MUL SIN = sin1.d
gmt math -T0/1/0.01 T 2 MUL PI MUL 0.7 SUB SIN = sin2.d

gmt psxy -R0/1/-1/1 -JX2i/0.8i -P -K -W1p -Bx0 -By0g2 -BWS sin1.d --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt psxy -R -J -O -K -W1p,0.5_2:0p sin2.d --PS_LINE_CAP=round >> $FIG.ps
gmt pstext -R -J -O -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
1.05 -0.55 LM d = A @%4%sin@%% (@~w@~t-@~f@~)
1.05 0 LM d = A @%4%sin@%% (@~w@~t)
0.92 -1.06 LT t
-0.03 1 RT d
EOF
\rm -f sin[12].d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
