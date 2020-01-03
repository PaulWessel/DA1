#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to Vostok core autocorrelation vs lag(years)
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.5 PS_SCALE_Y 0.5
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 11p FONT_LABEL 13p MAP_LABEL_OFFSET 0.05i
gmt psxy ../problems/vostok_lag_t.txt -R0/425000/-0.5/1.2 -JX6i/1.75i -P -K -W1p -Bxag100000+l"Lag (year)" -Byag10+l"r@-@~t@~@-" -BWS --MAP_FRAME_TYPE=graph --FORMAT_FLOAT_MAP="%'g" >! $FIG.ps
gmt sample1d ../problems/vostok.txt -i1,2 -I25 -Fc | gmt regress -Fxr | gmt psxy -R0/425000/-5/9 -J -O -K -W0.25p -Bxa+l"Time (year)" -Byag10+l"@~D@~T (\232C)" -BWS --FORMAT_FLOAT_MAP="%'g" --MAP_FRAME_TYPE=graph -Y2.25i >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
