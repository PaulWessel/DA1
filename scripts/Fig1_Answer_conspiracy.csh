#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to conspiracy correlation
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 9p FONT_LABEL 12p MAP_LABEL_OFFSET 0.05i
gmt psxy -R1999/2010/10/139 -JX4i/1.5i -P -W2p -Bxaf1+l"Year" -Byaf+l"10@+6@+ barrels" -BWS -K ../problems/conspiracy.txt -i0,1 >! $FIG.ps
gmt psxy -R1999/2010/45/90 -J -O -W2p,4_2:0 -Byaf+l"Fatalities" -BE ../problems/conspiracy.txt -i0,2 >>$FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
