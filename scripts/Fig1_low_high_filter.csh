#!/bin/csh
#
# This script will create the EPS file for a figure.
# Run script with arbitrary argument to invoke gv
#
# Purpose:
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.65 PS_SCALE_Y 0.65
#-------------------------------------------------
gmt math -T-1/1/0.01 T 100 MUL ATAN PI DIV 0.5 ADD = H.d
gmt math 1 H.d SUB = L.d
gmt psxy -R-1/1/0/1.3 -JX2.5i/1i -P -K -W2p L.d -Bx0+l"Lowpass" -By1 -BWS --MAP_FRAME_TYPE=graph --MAP_LABEL_OFFSET=0.1c >! $FIG.ps
echo "-0.8 0.8 L(f)" | gmt pstext -R -J -O -K -F+f12p,Times-Italic+jLT >> $FIG.ps
gmt psxy -R -J -O -K -W2p H.d -Bx0+l"Highpass" -By1 -BWS --MAP_FRAME_TYPE=graph --MAP_LABEL_OFFSET=0.1c -X3.25i >> $FIG.ps
echo "0.2 0.8 H(f)" | gmt pstext -R -J -O -K -F+f12p,Times-Italic+jLT >> $FIG.ps

#-------------------------------------------------
gmt psxy -R -J -O -T >> $FIG.ps
# Post-processing
rm -f L.d H.d

if ($#argv == 1) then
	gv $FIG.ps &
endif
