#!/bin/csh
#	$Id: Fig1_fossil_site.csh 503 2016-05-21 03:26:50Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Fossils in drainage basins
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------

cat << EOF >! left.d
1 3.7
1.3 3.8
1.4 4
1.2 5
1.15 5.5
1 6
0.8 6.3
0.6 6.2
0.5 6
0.75 5
0.8 4
EOF
cat << EOF >! mid.d
2.3 5.25
3 5
3.1 5.4
3 6
2.6 6.2
2.4 5.7
EOF
cat << EOF >! right.d
7 4
7.4 4.1
7.4 4.5
7.8 5.5
7.9 6
7.5 6.4
6.8 6.2
6.5 5.8
6 5.4
5.85 5
5.95 4.6
6.6 4
EOF
cat << EOF >! basin1.d
3 2.8
3.5 3
4 4
3.8 5
3.5 6
3 6.5
2 6.8
1.5 6.9
1 6.6
0.4 6.2
0.3 5.7
0.4 4
0.5 3.7
1 3.2
2 2.8
EOF
cat << EOF >! basin2.d
7 3.5
7.5 3.8
7.7 4
7.8 5
8.1 6
8 6.3
7.5 6.4
7 6.3
6.5 6
6 5.5
5.7 5
6 4
6.5 3.5
7 3.5
EOF
gmt psxy -R0/8.1/0/7 -JX4i/3i -P -K -Glightgray left.d mid.d right.d >! $FIG.ps
gmt psxy -R -J -O -K -W0.5p -L left.d mid.d right.d >> $FIG.ps
gmt psxy -R -J -O -K -W1p basin?.d -L >> $FIG.ps
gmt psxy -R -J -O -K -W2p << EOF >> $FIG.ps
>
5 0
5.2 0.4
5 1
5.05 2
4.7 2.6
3.9 2.7
3.3 3.3
2.4 4.2
2.2 4.6
1.65 5
0.6 5.1
>
2.2 4.6
2.3 5
2.15 5.4
2.4 5.8
2 6.25
>
5.05 2
5.35 2.55
6 2.85
6.25 3.4
6.8 3.7
7 4.5
EOF
echo "5.1 1" | gmt psxy -R -J -O -K -Sa0.2i -Gwhite -W0.5p >> $FIG.ps
gmt pstext -R -J -O -F+f+j << EOF >> $FIG.ps
5.35 1.05 12p,Helvetica-Bold LM Fossil site
3.5 6.3 10p,Helvetica-Bold LB B@-1@-
6.5 6.3 10p,Helvetica-Bold RB B@-2@-
EOF
\rm -f left.d mid.d right.d basin?.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
