#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Draw Run example
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.7 PS_SCALE_Y 0.7
#-------------------------------------------------
cat << EOF > run.txt
0.2 0.2	LT A
0.6 0.4	LT B
1.1 1.4	RB C
1.3 1.1	LB D
1.65 1.1 LB E
1.9 0.6	LT F
2.5 1.6	LB G
2.8 1.15 LB H
3 0.5	RT I
3.3 0.5	LT J
3.8 1.1	LT K
EOF
gmt psxy -R0/4/-0.15/2 -JX4i/1.25i -P -K -W0.5p,- -B0 -BWS --MAP_FRAME_TYPE=graph run.txt >! $FIG.ps
gmt psxy -R -J -O -Sc0.075i -Gwhite -W0.25p -K -N run.txt >> $FIG.ps
gmt pstext -R -J -O -N -Dj0.05i -F+f10p,Helvetica-Bold+j run.txt >> $FIG.ps
rm -f run.txt
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
