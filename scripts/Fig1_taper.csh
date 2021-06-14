#!/bin/csh
#	$Id: Fig1_trunc2.csh 202 2015-05-23 01:07:58Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Demonstrate Tukey windowing
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.45 PS_SCALE_Y 0.45
#-------------------------------------------------
gmt convert data/c2407.txt -o0,1 > tmp.txt
gmt math tmp.txt data/c2407_trend.txt SUB = | awk '{if ($1 > 25) print $1-25, $2}' > res.txt
gmt math res.txt 0 MUL 164 TAPER ADD = taper.txt
gmt math res.txt taper.txt MUL = tapered.txt
gmt psxy -R0/1067/-1000/1000 -JX8i/1.5i -P -Bxaf+u" km" -Byafg10000+l"Topography (m)" -BWS tapered.txt -K -W0.5p > $FIG.ps
gmt psxy -R0/1067/0/1.05 -JX8i/0.5i -O -K -Bya0.5f+l"Weights" -BWs -W3p taper.txt -Y1.75i >> $FIG.ps
gmt psxy -R -J -O -K -W0.5p,- << EOF >> $FIG.ps
>
164 0
164 1
>
903 0
903 1
>
0	1
1067	1
EOF
gmt psxy -R0/1067/-1000/1000 -JX8i/1.5i -O -K -Bxaf -Byafg10000+l"Topography (m)" -BW res.txt -Y0.75i -W0.5p >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
rm -f tmp.txt res.txt taper.txt tapered.txt
if ($#argv == 1) then
	gv $FIG.ps &
endif
