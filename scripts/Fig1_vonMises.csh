#!/bin/csh
#	$Id
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Show a von Mises distribution on a circle
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.9 PS_SCALE_Y 0.9 FONT_ANNOT_PRIMARY 10p
#-------------------------------------------------
set KAPPA = 1
gmt math -T0/360/1 T 75 SUB COSD $KAPPA MUL EXP $KAPPA MUL 2 PI MUL $KAPPA I0 MUL DIV = mises_dist.txt
set L = `gmt math -Q $KAPPA EXP $KAPPA MUL 2 PI MUL $KAPPA I0 MUL DIV =`
# Was gmt psxy -R0/360/0/0.4 -JP3iz -P -K mises_dist.txt -W2p -Glightgray > $FIG.ps
gmt psxy -R0/360/0/0.4 -JP3i+z -P -K mises_dist.txt -W2p -Glightgray > $FIG.ps
set KAPPA = 10
gmt math -T0/360/1 T -75 SUB COSD $KAPPA MUL EXP $KAPPA MUL 2 PI MUL $KAPPA I0 MUL DIV 33 DIV = mises_dist.txt
gmt psxy -R -J -OP -K mises_dist.txt -W1p -Gdarkgray >> $FIG.ps
gmt psbasemap -R -J -O -K -Bxag30 -Byag0.1 >> $FIG.ps
gmt psxy -R -J -O -W0.25p << EOF >> $FIG.ps
>
0	0.4
180	0.4
>
90	0.4
-90	0.4
> -W0.5p,6_3:0
0	0
75	$L
EOF
\rm -f mises_dist.txt
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif

