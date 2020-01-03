#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to Tuco's tire inspection
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.5 PS_SCALE_Y 0.5
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 9p FONT_LABEL 12p MAP_LABEL_OFFSET 0.05i
gmt math -T0/10/0.01 T 5.14 SUB 1.45 DIV 2 POW 2 DIV NEG EXP 1.45 DIV 2 PI MUL SQRT DIV = curve.txt
gmt math -T5.5/6.0/0.01 T 5.14 SUB 1.45 DIV 2 POW 2 DIV NEG EXP 1.45 DIV 2 PI MUL SQRT DIV = part.txt
gmt psxy -R0/10/0/0.35 -JX5i/2i -P -Wfaint -Bxaf+l"Seismic velocity (v)" -Byaf+l"pdf(v)" -BWS part.txt -Ggray -L+yb -K >! $FIG.ps
gmt psxy -R -J -O -W1p curve.txt >> $FIG.ps
#-------------------------------------------------
# Post-processing
rm curve.txt part.txt
if ($#argv == 1) then
	gv $FIG.ps &
endif
