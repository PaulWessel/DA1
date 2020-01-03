#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to NSF funding bias
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 10p FONT_LABEL 13p MAP_LABEL_OFFSET 0.05i
gmt psbasemap -R1229/1962/0/1 -JX4i/1.5i -P -Bxaf+l"Year" -Byaf+l"c.d.f." -BWSne -K >! $FIG.ps
gmt psxy -R -J -O -K -W0.25p,- << EOF >> $FIG.ps
>
1229	0
1962	1
> -W1p
1801	0
1801	1
EOF
awk '{print $1, NR}' ../problems/aso.txt | gmt psxy -R1229/1962/1/95 -J -O -W1p -Ay >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
