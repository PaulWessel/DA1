#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: timeseries turned into histogram
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.75 PS_SCALE_Y 0.75 
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 9p FONT_LABEL 12p MAP_LABEL_OFFSET 0.05i
gmt math -T0/10/0.5 T 1.9 MUL SIN T 0.1 MUL ADD T 0.1 MUL 1 ADD DUP MUL MUL = >! $$
gmt sample1d $$ -I0.1 > $$.d
gmt psxy -R0/10/-2/5.5 -JX2.0i/0.7i -W0.25p $$.d -P -K -Bxaf+ldistance -Bya2g2+lrange -BWS >! $FIG.ps
gmt psxy -R -J -Sc0.05i -Gblack $$ -N -O -K >> $FIG.ps
gmt pshistogram $$.d -i1 -J -Bxa2+lrange -Byaf+lfrequency -BWS -Z1 -W1 -X2.75i -Glightgray -L0.25p -O >> $FIG.ps
\rm -f $$ $$.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
