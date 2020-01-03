#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to Billings spectrum
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.5 PS_SCALE_Y 0.5
#-------------------------------------------------
# DFT is stored in Billings_dft.txt until gmtfft is ready
gmt set FONT_ANNOT_PRIMARY 11p FONT_LABEL 13p MAP_LABEL_OFFSET 0.05i
gmt psxy -R0/100/0/600 -JX6i/1.4i Billings_dft.txt -Wfaint -P -K -Bxa+l"Harmonic number" -Bya+l"Variance (\232C@+2@+)" -BWS --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt psxy -R -J -O -K Billings_dft.txt -Sc0.1c -Gblack >> $FIG.ps
echo "b)" | gmt pstext -R -J -O -K -N -F+cTR+jTR+f18p >> $FIG.ps
# Read in data in temperature (F) and day number since Jan 1, 1995 and convert to time and C
gmt psxy -R1995/2011/-35/35 -J -O -K -W0.25p -Bxa+l"Year" -Bya+l"Temperature (\232C)" -BWS ../problems/Billings.txt -i0s0.00273785079o1994.99726215,1s0.55555555o-17.7777777  --MAP_FRAME_TYPE=graph -Y2i >> $FIG.ps
echo "a)" | gmt pstext -R -J -O -K -N -F+cTR+jTR+f18p >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
