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
gmt set PS_SCALE_X 0.5 PS_SCALE_Y 0.5 FONT_ANNOT_PRIMARY 14p
#-------------------------------------------------
set KAPPA = 1
gmt math -T0/360/1 T 75 SUB COSD $KAPPA MUL EXP $KAPPA MUL 2 PI MUL $KAPPA I0 MUL DIV = M.txt
set L = `gmt math -Q $KAPPA EXP $KAPPA MUL 2 PI MUL $KAPPA I0 MUL DIV =`
gmt psxy -R0/360/0/0.4 -JP3iz -P -K M.txt -W3p -Glightgray > $FIG.ps
set KAPPA = 10
gmt math -T0/360/1 T -75 SUB COSD $KAPPA MUL EXP $KAPPA MUL 2 PI MUL $KAPPA I0 MUL DIV 33 DIV = M.txt
gmt psxy -R -J -OP -K M.txt -W1p -Gdarkgray >> $FIG.ps
gmt psbasemap -R -J -O -K -Bxag30 -Byag0.1 >> $FIG.ps
gmt psxy -R -J -O -W0.25p -N << EOF >> $FIG.ps
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
\rm -f M.txt
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif

