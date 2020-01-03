#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to c2407.txt analysis
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 9p FONT_LABEL 12p MAP_LABEL_OFFSET 0.05i
gmt math ../problems/c2407.txt -C2 SQRT = > t.txt
gmt regress t.txt -i2,1 -Fxm > fit.txt
gmt psbasemap -R0/1100/-6000/0 -JX5i/2i -P -K -Bxafg+u" km" -Byafg+u" m" -BWSne --FONT_LABEL=16p >! $FIG.ps
gmt psxy -R -J -O -K ../problems/c2407.txt -W0.25p >> $FIG.ps
gmt convert t.txt fit.txt -A | gmt psxy -R -J -O -W2p -i0,4 >> $FIG.ps
#-------------------------------------------------
# Post-processing
rm -f t.txt it.txt
if ($#argv == 1) then
	gv $FIG.ps &
endif
