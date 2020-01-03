#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solve problem 6.1
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8
#-------------------------------------------------
gmt psxy -R0/3500/-5/45 -JX4i/1.75i -P -Bxaf+u" km" -Byag100+u" Myr" -BWSne -Sc0.1c -Gblack -Ey -K ../problems/hawaii.txt > $FIG.ps
gmt regress ../problems/hawaii.txt -Fxm -T2 | gmt psxy -R -J -O -K -W0.5p,- >> $FIG.ps
gmt regress ../problems/hawaii.txt -Fxm -T2 -Wy | gmt psxy -R -J -O -K -W0.5p >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
rm -f $$
if ($#argv == 1) then
	gv $FIG.ps &
endif
