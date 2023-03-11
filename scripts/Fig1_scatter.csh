#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Show a scatter plot of data
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8 
#-------------------------------------------------

gmt psxy -R0/1/0/1 -JX2.5i/1i -P -Sc0.05i -Gblack -B0 -BWS --MAP_FRAME_TYPE=graph << EOF >! $FIG.ps
0.2 0.2
0.1 0.2
0.19 0.1
0.23 0.27
0.13 0.19
0.22 0.28
0.25 0.19
0.33 0.37
0.54 0.45
0.43 0.49
0.52 0.52
0.54 0.59
0.5 0.4
0.51 0.63
0.8 0.81
0.77 0.78
0.44 0.55
0.66 0.62
0.71 0.69
0.88 0.79
0.91 0.9
# Add in some outliers:
0.15 0.89
0.4 0.1
0.85 0.2
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
