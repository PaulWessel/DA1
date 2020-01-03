#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to Columbia spectrum
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------
# DFT is stored in columbia_dft.txt until gmtfft is ready
gmt set FONT_ANNOT_PRIMARY 10p FONT_LABEL 13p MAP_LABEL_OFFSET 0.05i
gmt psxy -R0/50/1000/4e7 -JX6i/1.2il columbia_dft.txt -Wfaint -P -K -Bxa+l"Harmonic number" -Bya1p+l"Variance (\m@+6@+)" -BWS --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt psxy -R -J -O -K columbia_dft.txt -Sc0.1c -Gblack >> $FIG.ps
echo "b)" | gmt pstext -R -J -O -K -N -F+cTR+jTR+f18p >> $FIG.ps
gmt psxy -R2001T/2009T/0/15000 -JX6iT/1.2i -O -K -W0.25p -Bxa1Y -Bya+l"Discharge (m@+3@+)" -BWS ../problems/columbia.txt --MAP_FRAME_TYPE=graph -Y1.8i >> $FIG.ps
echo "a)" | gmt pstext -R -J -O -K -N -F+cTR+jTR+f18p >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
