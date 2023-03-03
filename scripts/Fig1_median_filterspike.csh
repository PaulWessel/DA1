#!/bin/csh
#
# This script will create the EPS file for a figure.
# Run script with arbitrary argument to invoke gv
#
# Purpose:
#
set name = $0
set FIG = $name:r
set ps = $FIG.ps
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.65 PS_SCALE_Y 0.65
#-------------------------------------------------
gmt math -T-5/5/0.005 0 0.02 NRAND = | awk '{if ($1 == 0.45) {print $1,1} else {print $0}}' > noise_and_spike.txt
gmt psxy -R0/1/-0.2/1.2 -JX2i/1.25i noise_and_spike.txt -P -K -W0.5p -B0 -BS --MAP_FRAME_TYPE=graph >! $ps
gmt pstext -R -J -O -K -N -F+f14p,Times-Roman+jCM << EOF >> $ps
1.1 0.2 "*"
1.58 0.5 median
EOF
gmt psxy -R-1.2/1.2/0/1.5 -JX1.25i/1.25i -O -K -X2.5i -W2p -Bx0 -By0g2 -BS --MAP_FRAME_TYPE=graph << EOF >> $ps
-1	0
-0.75	0
-0.75	0.5
0.75	0.5
0.75	0
1	0
EOF
gmt pstext -R -J -O -K -N -F+f14p,Times-Roman+jCM << EOF >> $ps
1.25 0.4 =
EOF
gmt filter1d noise_and_spike.txt -Fm0.5 | gmt psxy -R0/1/-0.01/0.06 -JX2i/1.25i -O -K -X1.5i -W2p -Bx0 -By0g2 -BS --MAP_FRAME_TYPE=graph >> $ps
#-------------------------------------------------
gmt psxy -R -J -O -T >> $ps
# Post-processing

if ($#argv == 1) then
	gv $ps &
endif
rm -f noise_and_spike.txt
