#!/bin/csh
#	$Id: Fig1_leverage.csh 507 2016-05-23 00:54:38Z pwessel $
#
# This script will create the EPS file for a figure.
# Run script with arbitrary argument to invoke gv
#
# Purpose:
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.5 PS_SCALE_Y 0.5
#-------------------------------------------------

gmt psxy -R0/2.5/-0.2/2.5 -Jx1.25i/0.75i -P -K -B0 -Bws -N -Sc0.075i -Gblack --MAP_FRAME_TYPE=graph << EOF >! $FIG.ps
0.1 0.11
0.2 0.18
0.3 0.33
0.4 0.4
0.5 0.51
0.6 0.58
0.7 0.69
0.8 0.82
0.9 0.91
2.5 2.5
EOF
gmt psxy -R -J -O -K -W1p << EOF >> $FIG.ps
0.0 0
2.5 2.5
EOF
echo "2.5 2.5 Leverage point" | gmt pstext -R -J -O -N -Dj0.15i/0.15i -F+f14p,Times-Roman+jRM >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
