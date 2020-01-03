#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: LS fit to 5 points
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------

gmt math -T-4/4/0.05 T DUP MUL 0.5 MUL NEG EXP 2 PI MUL SQRT DIV = $$
gmt psbasemap -R-2/4/-2/3 -Jx0.33333i -P -K -Bafg1 -BWSne >! $FIG.ps
gmt psxy -R -J -O -K -Sc0.1i -Gblack -W0.5p << EOF >> $FIG.ps
-0.82	-0.86
0.23	-0.58
1.35	0.54
2.25	1.30
3.33	2.20
EOF
gmt psxy -R -J -O -W1p << EOF >> $FIG.ps
-2	-2.0107
1	0.3125
4	2.6357
EOF
#-------------------------------------------------
# Post-processing
rm -f $$
if ($#argv == 1) then
	gv $FIG.ps &
endif
