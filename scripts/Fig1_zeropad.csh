#!/bin/csh
#	$Id: Fig1_trunc2.csh 202 2015-05-23 01:07:58Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Demonstrate Tukey windowing
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.5 PS_SCALE_Y 0.5
#-------------------------------------------------
gmt convert data/c2407.txt -o0,1 > tmp.txt
gmt math tmp.txt data/c2407_trend.txt SUB = | awk '{if ($1 > 25) print $1-25, $2}' > res.txt
gmt math res.txt 164 TAPER MUL = tapered.txt
echo -491 0 > zero.txt
cat tapered.txt >> zero.txt
echo 1557 0 >> zero.txt
gmt psxy -R-491/1557/-1000/1000 -JX8i/1.5i -P -Bxaf+u" km" -Byaf+l"Topography (m)" -BWS zero.txt -K -W0.5p > $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
rm -f tmp.txt res.txt tapered.txt zero.txt
if ($#argv == 1) then
	gv $FIG.ps &
endif
