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
gmt math -T0/30/1 100 T SUB 99 T SUB MUL 98 T SUB MUL 97 T SUB MUL 100 DIV 99 DIV 98 DIV 97 DIV = curve.txt
gmt math -T0/30/1 100 T SUB 99 T SUB MUL 98 T SUB MUL 97 T SUB MUL 100 DIV 99 DIV 98 DIV 97 DIV = tmp.txt
gmt psxy -R0/30/0/1 -JX5i/2i -P -Wfaint -Bxaf1g1+l"Number of bad tires (B)" -Bya0.25g0.5+l"P(B)" -BWS curve.txt -K >! $FIG.ps
gmt psxy -R -J -O -Sc0.1c -Gblack tmp.txt >> $FIG.ps
#-------------------------------------------------
# Post-processing
rm tmp.txt curve.txt
if ($#argv == 1) then
	gv $FIG.ps &
endif
