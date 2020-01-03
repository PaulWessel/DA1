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
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 9p FONT_LABEL 12p MAP_LABEL_OFFSET 0.05i
gmt psbasemap -R30/50/1.7/2.4 -JX4i/1.25i -P -K -Bxafg+l"Sample size (n)" -Byafg+l"t and t@-0.025,n-2@-" -BWSne --FONT_LABEL=16p >! $FIG.ps
gmt math -T30/50/1 T 2 SUB SQRT 0.32 MUL 1 0.32 2 POW SUB SQRT DIV = | gmt psxy -R -J -O -K -W1p >> $FIG.ps
gmt math -T30/50/1 T 2 SUB SQRT 0.32 MUL 1 0.32 2 POW SUB SQRT DIV = | gmt psxy -R -J -O -K -Sc0.075i -Gblack >> $FIG.ps
gmt math -T30/50/1 0.975 T TCRIT = | gmt psxy -R -J -O -W1p >> $FIG.ps
#-------------------------------------------------
# Post-processing
rm -f $$ tail.d
if ($#argv == 1) then
	gv $FIG.ps &
endif
