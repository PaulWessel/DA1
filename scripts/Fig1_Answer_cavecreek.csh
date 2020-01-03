#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to Cave Creek spectrum
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.5 PS_SCALE_Y 0.5
#-------------------------------------------------
# DFT is stored in cc_dft.txt until gmtfft is ready
gmt set FONT_ANNOT_PRIMARY 11p FONT_LABEL 13p MAP_LABEL_OFFSET 0.05i
gmt psxy -R0/110/0/1500 -JX6i/1.4i cc_dft.txt -W0.25p -P -K -Bxa+l"Harmonic number" -Bya+l"Variance (mm@+2@+)" -BWS --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt psxy -R -J -O -K cc_dft.txt -Sc0.1c -Gblack >> $FIG.ps
echo "b)" | gmt pstext -R -J -O -K -N -F+cTR+jTR+f18p >> $FIG.ps
# Read in data in inches and rec count and convert to mm and time since 1952.75
gmt psxy -R1952/1972/0/240 -J -O -K -W0.25p -Bxa+l"Year" -Bya+l"Runoff (mm)" -BWS ../problems/cavecreek.txt -i1s0.08333333o1952.75,0s0.254  --MAP_FRAME_TYPE=graph -Y2i >> $FIG.ps
echo "a)" | gmt pstext -R -J -O -K -N -F+cTR+jTR+f18p >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
