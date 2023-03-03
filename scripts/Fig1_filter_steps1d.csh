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
gmt math -T-7/-2/0.005 0 = bw.txt
gmt math -T-1.995/1.5/0.005 1 = >> bw.txt
gmt math -T1.505/3/0.005 1.5 = >> bw.txt
gmt math -T3.005/7/0.005 0.4 = >> bw.txt
gmt math -T-7/7/0.005 0 0.15 NRAND = | gmt filter1d -Fg0.4 -E > noise.txt
gmt math bw.txt noise.txt ADD = bw2.txt
# Mean
gmt psxy -R-5/5/-0.3/1.6 -JX2i/0.5i bw2.txt -P -K -W1p -B0 -BS --MAP_FRAME_TYPE=graph -Y2i >! $ps
gmt pstext -R -J -O -K -N -F+f14p,Times-Roman+jCM << EOF >> $ps
7.1 0.6 *
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
0 0.7 mean
1.25 0.3 =
EOF
gmt filter1d bw2.txt -Fg2 | gmt psxy -R-5/5/-0.1/1.6 -JX2i/0.5i -O -K -X1.5i -W1p -Bx0 -By0 -BS --MAP_FRAME_TYPE=graph >> $ps
# Median
gmt psxy -R-5/5/-0.1/1.6 -JX2i/0.5i bw2.txt -O -K -W1p -B0 -BS --MAP_FRAME_TYPE=graph -Y-1i -X-4i >> $ps
gmt pstext -R -J -O -K -N -F+f14p,Times-Roman+jCM << EOF >> $ps
7.1 0.6 "*"
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
0 0.7 median
1.25 0.3 =
EOF
gmt filter1d bw2.txt -Fm2 | gmt psxy -R-5/5/-0.3/1.6 -JX2i/0.5i -O -K -X1.5i -W1p -Bx0 -By0 -BS --MAP_FRAME_TYPE=graph >> $ps

#-------------------------------------------------
gmt psxy -R -J -O -T >> $ps
# Post-processing
rm -f bw.txt noise.txt bw2.txt
if ($#argv == 1) then
	gv $ps &
endif
