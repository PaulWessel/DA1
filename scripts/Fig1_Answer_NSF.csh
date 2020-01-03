#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to NSF funding bias
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 9p FONT_LABEL 12p MAP_LABEL_OFFSET 0.05i
gmt psxy -R15/80/530/670 -JX1.5i -P -Sc0.2c -Gblack -Byaf+l"PhD's awarded" -Bxaf+l"Fatalities"  -BWS -K ../problems/PhD_deaths.txt -i2,1 >! $FIG.ps
gmt psxy -R1999/2010/530/670 -JX4i/1.5i -O -W2p -Bxaf1+l"Year" -Byaf -BwS -K ../problems/PhD_deaths.txt -i0,1 -X1.75i >> $FIG.ps
gmt psxy -R1999/2010/15/80 -J -O -W2p,4_2:0 -Byaf+l"Fatalities" -BE ../problems/PhD_deaths.txt -i0,2 >>$FIG.ps
#-------------------------------------------------
# Post-processing
#rm tmp.txt
if ($#argv == 1) then
	gv $FIG.ps &
endif
