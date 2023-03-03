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
gmt math -T0/1/0.01 T 0.5 DIV 2 POW 1 ADD INV = function.txt
gmt psxy -R0/1/0/1.2 -JX2.5i/1.25i function.txt -P -K -W0.5p -B0/g1-0.5WS --MAP_FRAME_TYPE=graph >! $ps
gmt math -T0/1/0.01 T 0.5 DIV 10 POW 1 ADD INV = | gmt psxy -R -J -O -K -W1p >> $ps
gmt math -T0/1/0.01 T 0.5 DIV 100 POW 1 ADD INV = | gmt psxy -R -J -O -K -W2p >> $ps
gmt pstext -R -J -O -K -N -F+f+j << EOF >> $ps
0.5 -0.2 12p,Times-Italic LM f@-0@-
0.95 -0.2 12p,Times-Italic LM f
1 0.30 12p,Times-Italic RB n = 1
0.85 0.075 12p,Times-Italic RB n = 5
0.525 1 12p,Times-Italic LT n = @~\\245@~
EOF
gmt math -T-1/1/0.01 T PI MUL SINC = function.txt
gmt math -T-1/1/0.01 T 2.5 MUL 2 POW 0.5 MUL NEG EXP = gaussian.txt
echo "a)" | gmt pstext -R -J -O -K -F+cTL+f16p+jRB -DJ0.15i -N >> $FIG.ps
gmt psxy -R-1/1/-0.4/1.2 -JX2.5i/1.25i function.txt -O -K -X3.0i -W2p -B0/0g2S --MAP_FRAME_TYPE=graph >> $ps
gmt math function.txt 0.5 MUL gaussian.txt 0.5 MUL ADD 0.2 SUB = | gmt psxy -R -J -O -K -W1p >> $ps
gmt math function.txt 0.1 MUL gaussian.txt 0.9 MUL ADD 0.2 SUB = | gmt psxy -R -J -O -K -W0.5p >> $ps
gmt pstext -R -J -O -K -N -F+f+j << EOF >> $ps
0.95 -0.6 12p,Times-Italic LM t
0.35 0.5 12p,Times-Italic LB n = 1
0.65 0.1 12p,Times-Italic RB n = 5
0.50 1 12p,Times-Italic RB n = @~\\245@~
EOF
gmt psbasemap -R -J -O -K -X1.25i -B0/0W --MAP_FRAME_TYPE=graph >> $ps
echo "b)" | gmt pstext -R -J -O -K -F+cTL+f16p+jRB -DJ0.15i -N >> $FIG.ps
#-------------------------------------------------
gmt psxy -R -J -O -T >> $ps
# Post-processing
rm -f function.txt gaussian.txt


if ($#argv == 1) then
	gv $ps &
endif
