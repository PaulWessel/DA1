#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to Honolulu and Hilo subsience
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.5 PS_SCALE_Y 0.5
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 11p FONT_LABEL 13p MAP_LABEL_OFFSET 0.05i
gmt psxy -R1900/1990/6750/7250 -JX6i/2i -P -K -W0.25p,gray -Bxa+l"Year" -Bya+l"Tide gauge (mm)" -BWS ../problems/Honolulu.txt  --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt psxy -R -J -O -K -W0.25p ../problems/Hilo.txt >> $FIG.ps
gmt regress ../problems/Honolulu.txt -Fxm -T2 | gmt psxy -R -J -O -K -W2p,gray >> $FIG.ps
gmt regress ../problems/Hilo.txt -Fxm -T2 | gmt psxy -R -J -O -K -W2p >> $FIG.ps
set HNL_s = `gmt regress ../problems/Honolulu.txt -Fp -o5 --FORMAT_FLOAT_OUT=%4.2f`
set HIL_s = `gmt regress ../problems/Hilo.txt -Fp -o5 --FORMAT_FLOAT_OUT=%4.2f`
echo "1930 7200 $HNL_s mm/yr" | gmt pstext -R -J -O -K -F+f12p+jCT >> $FIG.ps
echo "1970 6800 $HIL_s mm/yr" | gmt pstext -R -J -O -K -F+f12p+jCB >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
