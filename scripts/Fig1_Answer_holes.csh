#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to Tuco's tire inspection
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 9p FONT_LABEL 12p MAP_LABEL_OFFSET 0.05i
gmt math -T1/30/1 0.9 T 1 SUB POW 0.1 MUL = P.d
gmt math P.d SUM = Pc.d
gmt psxy -JX5i/1.75i -R1/30/0/1 Pc.d -Sc0.05i -N -G0 -Bxaf+l"Number of holes (n)" -Byaf+l"P(n) and P@-c@-(n)" -BWSne -P -K >! $FIG.ps
gmt psxy -R -JX -O -K -Sc0.05i -Gwhite -W0.25p P.d -N >> $FIG.ps
gmt psxy -R -JX -O -W0.25p,- << EOF >> $FIG.ps
> horizontal
0 0.9
30 0.9
> vertical
22 0
22 1
EOF
#-------------------------------------------------
# Post-processing
rm -f P.d Pc.d
if ($#argv == 1) then
	gv $FIG.ps &
endif
