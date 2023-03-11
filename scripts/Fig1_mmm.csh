#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: mean, median, mode relationship
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.7 PS_SCALE_Y 0.7
#-------------------------------------------------

gmt math -T0/36/0.05 T SQRT 3 SUB DUP MUL 0.5 MUL NEG EXP = | gmt psxy -R0/36/0/1 -JX3i/1i -P -K -W2p -L+yb -Glightgray -B0 -BWS --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt psxy -R -J -O -K -W1p << EOF >> $FIG.ps
> mode
9 0
9 1
> median
11 0
11 0.95
> mean
14 0
14 0.75
EOF
gmt pstext -R -J -O -N -D0/-0.08i -F+f12p,Times-Italic+jTC << EOF >> $FIG.ps
9  0 @!\223x
11 0 @!\224x
14 0 @!\225x
EOF

#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
