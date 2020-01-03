#!/bin/csh
#	$Id: Fig1_dataclasses.csh 682 2019-01-12 07:15:25Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Plot data classification scheme
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.7 PS_SCALE_Y 0.7 
gmt psxy -R0/6/0/2 -JX5.5i/1.3i -P -K -W1p << EOF > $FIG.ps
> TOP -W2p
1.5 1.1
3 1.75
4.5 1.1
> LEFT
0.75 0.175
1.5 0.9
2.25 0.175
> LEFT MIDDLE
1.5 0.17
1.5 0.9
> RIGHT LEFT
3.375 0.17
4.5 0.9
4.875 0.17
> RIGHT RIGHT
4.125 0.17
4.5 0.9
5.625 0.17
EOF
gmt pstext -R -J -O -K -F+f+j -Gwhite -N -C25%+tO -W0.25p << EOF >> $FIG.ps
3 2 11p,Helvetica-Bold TC DATA
EOF
gmt pstext -R -J -O -K -F+f+j -Gwhite -N -C25%+tO -W0.25p << EOF >> $FIG.ps
1.5 1 9p,Helvetica-Bold CM DISCRETE
4.5 1 9p,Helvetica-Bold CM CONTINUOUS
EOF
gmt pstext -R -J -O -F+f+j -Gwhite -N -C25%+tO -W0.25p << EOF >> $FIG.ps
0.75  0 8p,Helvetica-Bold CB COUNTS
1.5   0 8p,Helvetica-Bold CB ORDINAL
2.25  0 8p,Helvetica-Bold CB NOMINAL
3.375 0 8p,Helvetica-Bold CB RATIO
4.125 0 8p,Helvetica-Bold CB INTERVAL
4.875 0 8p,Helvetica-Bold CB CLOSED
5.625 0 8p,Helvetica-Bold CB DIRECTIONAL
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
