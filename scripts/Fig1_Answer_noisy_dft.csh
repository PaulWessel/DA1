#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to noisy spectrum
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.55 PS_SCALE_Y 0.55
#-------------------------------------------------
# DFT is stored in noisy_dft.txt until gmtfft is ready
gmt set FONT_ANNOT_PRIMARY 11p FONT_LABEL 13p MAP_LABEL_OFFSET 0.05i
gmt psxy -R0/20/0/150 -JX6i/1.4i noisy_dft.txt -Wfaint -P -K -Bxa+l"Harmonic number" -Bya+l"Variance" -BWS --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt psxy -R -J -O -K noisy_dft.txt -Sc0.1c -Gblack >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
