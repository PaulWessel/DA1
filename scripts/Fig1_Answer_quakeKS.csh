#!/bin/csh
#
# 
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.5 PS_SCALE_Y 0.5
#-------------------------------------------------
# Note: Added duplicate max value per data set for psxy -Ay to end at 1 
gmt set FONT_ANNOT_PRIMARY 16p FONT_LABEL 20p MAP_LABEL_OFFSET 0.05i

gmt psbasemap -R0/365/0/1 -JX5i/2.25i -P -Baf -Bx+l"Julian day" -By+l"cdf" -BWSne -K -X1.5i >! $FIG.ps
awk '{print $1, (NR-1)/401}' ../problems/quakedays.txt | gmt psxy -R -J -O -K -Ay -W1p >> $FIG.ps
gmt psxy -R -J -O -K -W0.25p << EOF >> $FIG.ps
0	0
365	1
EOF
echo 135 0.375 135 0.42 | gmt psxy -R -J -O -K -Sv0.1i+s -Gblack -W0.5p >> $FIG.ps
gmt pstext -R -J -O -K -F+f13p+j -Dj0.05i/0.05i << EOF >> $FIG.ps
170 0.5 RB Observed earthquakes
170 0.36 LB Steady-state expectation
350 0.1 RB D = 0.065
EOF
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
