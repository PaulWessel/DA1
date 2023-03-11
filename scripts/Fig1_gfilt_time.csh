#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Illustrate Gaussian filter in time-domain
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.7 PS_SCALE_Y 0.7
#-------------------------------------------------
# 
gmt psxy -R-50/1100/-900/900 -JX2.5i/1i -P -K -W0.25p data/noisy_data.txt -Bxaf+u" km" -Byaf+u" m" -BWS >! $FIG.ps
gmt pstext -R -J -O -K -N -F+f10p+jRB << EOF >> $FIG.ps
1080 -800 Original
EOF
echo "a)" | gmt pstext -R -J -O -K -F+cTL+f12p+jRB -DJ0.15i -N >> $FIG.ps
gmt filter1d data/noisy_data.txt -Fg80 | gmt psxy -R -J  -O -K -W0.5p,  -Bxaf+u" km" -Byaf+u" m" -BS -X2.75i >> $FIG.ps
gmt pstext -R -J -O -K -N -F+f10p+jRB << EOF >> $FIG.ps
1080 -800 Filtered
EOF
echo "b)" | gmt pstext -R -J -O -K -F+cTL+f12p+jRB -DJ0.15i -N >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
