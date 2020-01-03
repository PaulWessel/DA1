#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to sun spot spectrum
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------
# DFT is stored in sspots_dft.txt until gmtfft is ready
gmt set FONT_ANNOT_PRIMARY 10p FONT_LABEL 12p MAP_LABEL_OFFSET 0.05i
gmt psxy -R0/60/0/800 -JX6i/1.2i sspots_dft.txt -Wfaint -P -K -Bxa+l"Harmonic number" -Bya+l"Variance" -BWS --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt psxy -R -J -O -K sspots_dft.txt -Sc0.1c -Gblack >> $FIG.ps
echo "b)" | gmt pstext -R -J -O -K -N -F+cTR+jTR+f18p >> $FIG.ps
# Read in data in temperature (F) and day number since Jan 1, 1995 and convert to time and C
gmt psxy -R1749/2015/0/260 -J -O -K -W0.25p -Bxa+l"Year" -Bya+l"Sun spots" -BWS ../problems/sspots.txt  --MAP_FRAME_TYPE=graph -Y1.8i >> $FIG.ps
echo "a)" | gmt pstext -R -J -O -K -N -F+cTR+jTR+f18p >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
