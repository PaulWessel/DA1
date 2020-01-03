#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to Sulfur histogram
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.5 PS_SCALE_Y 0.5
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 11p FONT_LABEL 12p MAP_LABEL_OFFSET 0.05i
cat << EOF > tmp.txt
5	6	10
12.5	15	5
17.5	24	5
22.5	24	5
30	11	10
EOF
awk '{printf "%s %s %gi\n", $1, $2, $3*4/35}' tmp.txt | gmt psxy -R0/35.02/0/30 -JX4i/1.5i -P -W2p -Ggray -Sb -Bxa5+l"SO" -Byaf+l"Count" -BWS -K >! $FIG.ps
awk '{print $1, $2, $2}' tmp.txt | gmt pstext -R -J -O -F+f16p+jCB -Dj0/0.1i >> $FIG.ps
#-------------------------------------------------
# Post-processing
rm tmp.txt
if ($#argv == 1) then
	gv $FIG.ps &
endif
