#!/bin/csh
#	$$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: smoothing using Gaussian and Median
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8 
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 9p FONT_LABEL 12p MAP_LABEL_OFFSET 0.05i
gmt math -T-2/12/0.1 2 1 NRAND T 0.2 MUL ADD = >! $$
gmt psxy -R0/10/-3/5.5 -JX2.0i/0.7i -W0.25p $$ -P -K -Bxaf+ltime -Byaf+l"@~D@~ppm" -BWS >! $FIG.ps
gmt filter1d $$ -E -Fg4 | gmt psxy -R -J -O -K -W1p,red >> $FIG.ps
awk '{if ($1 > 5 && $1 < 6) {print $1, -2.75} else {print $0}}' $$ > t.txt
gmt psxy -R -J -W0.25p t.txt -O -K -Bxaf+ltime -Byaf -BWS -X2.5i >> $FIG.ps
gmt filter1d t.txt -E -Fg4 | gmt psxy -R -J -O -K -W0.5p,red >> $FIG.ps
gmt filter1d t.txt -E -Fm4 | gmt psxy -R -J -O -K -W1p,blue >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
\rm -f $$ $$.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
