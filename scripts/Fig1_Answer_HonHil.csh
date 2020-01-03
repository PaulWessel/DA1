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
gmt set PS_SCALE_X 0.5 PS_SCALE_Y 0.5
#-------------------------------------------------
# DFT is stored in honolulu_dft.txt and hilo_dft.txt until gmtfft is ready
gmt set FONT_ANNOT_PRIMARY 11p FONT_LABEL 13p MAP_LABEL_OFFSET 0.05i
# Convert harmonic number to period via Pj = T/j, excluding j = 0, with T = 41.8333 for Hilo
awk '{if ($1 > 0) print 41.8333/$1, $2}' hilo_dft.txt > hilo_p.txt
# Convert harmonic number to period via Pj = T/j, excluding j = 0, with T = 84 years for Honolulu
awk '{if ($1 > 0) print 84/$1, $2}' honolulu_dft.txt > hono_p.txt
gmt psxy -R0/10/10/2200 -JX6i/1.4il hono_p.txt -W0.25p -P -K -Bxa+l"Period (yrs)" -Bya1p+l"Variance (mm@+2@+)" -BWS --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt psxy -R -J -O -K hono_p.txt -Sc0.15c -Gblack >> $FIG.ps
echo "HONOLULU" | gmt pstext -R -J -O -K -N -F+cTR+jTR+f16p >> $FIG.ps
gmt psxy -R0/10/10/2200 -JX6i/1.4il hilo_p.txt -O -K -W0.25p -Bxa+l"Period (yrs)" -Bya1p+l"Variance (mm@+2@+)" -BWS --MAP_FRAME_TYPE=graph -Y2i >> $FIG.ps
gmt psxy -R -J -O -K hilo_p.txt -Sc0.15c -Gblack >> $FIG.ps
echo "HILO" | gmt pstext -R -J -O -K -N -F+cTR+jTR+f16p >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
rm -f hilo_p.txt hono_p.txt
if ($#argv == 1) then
	gv $FIG.ps &
endif
