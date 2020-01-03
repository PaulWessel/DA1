#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to Honolulu and Hilo subsidence via difference
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.5 PS_SCALE_Y 0.5
#-------------------------------------------------

awk '{if ($1 >= 1947.125 && $1 <= 1988.875) print $0}' ../problems/Honolulu.txt > tmp.txt
gmt math ../problems/Hilo.txt tmp.txt SUB = relative.txt
gmt set FONT_ANNOT_PRIMARY 11p FONT_LABEL 13p MAP_LABEL_OFFSET 0.05i
gmt psxy -R1945/1990/-180/160 -JX6i/1.6i -P -K -W0.25p -Bxa+l"Year" -Bya+l"Subsidence (mm)" -BWS relative.txt  --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt regress relative.txt -Fxm -T2 | gmt psxy -R -J -O -K -W2p >> $FIG.ps
set s = `gmt regress relative.txt -Fp -o5 --FORMAT_FLOAT_OUT=%4.2f`
echo "1985 -150 $s mm/yr" | gmt pstext -R -J -O -K -F+f12p+jCB >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
rm -f tmp.txt relative.txt
if ($#argv == 1) then
	gv $FIG.ps &
endif
