#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to Vostok core autocorrelation vs lag (z)
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.5 PS_SCALE_Y 0.5
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 11p FONT_LABEL 13p MAP_LABEL_OFFSET 0.05i
gmt psxy ../problems/vostok_lag_z.txt -R0/3310/-0.5/1.2 -JX6i/1.75i -P -K -W1p -Bxa+l"Lag (m)" -Byag10+l"r@-@~t@~@-" -BWS --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt regress ../problems/vostok.txt -Fxr -i0,2 | gmt psxy -R0/3310/-5/9 -J -O -K -W0.25p -Bxa+l"Depth (m)" -Byag10+l"@~D@~T (\232C)" -BWS --MAP_FRAME_TYPE=graph -Y2.25i >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
