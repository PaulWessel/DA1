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
gmt set PS_SCALE_X 0.75 PS_SCALE_Y 0.75
#-------------------------------------------------
cat << EOF > t.d
0	5
1	19
2	23
3	21
4	14
5	12
6	3
7	2
8	1
9	0
EOF
gmt math t.d DUP SUM UPPER DIV = fv.d
gmt math -T0/10/1 3 T POW 3 NEG EXP MUL T FACT DIV = p.d
gmt psxy -R-0.6/10.6/0/0.3 -JX4i/1.25i -P -K -Glightgray fv.d -Sb0.8u -W0.5p -BWS -Bxa1 -Byaf --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt sample1d p.d -Fc -I0.1 | gmt psxy -R -J -O -K -W1p >> $FIG.ps
gmt psxy -R -J -O -K p.d -Sc0.2c -Gblack -N >> $FIG.ps
gmt pstext -R -J -O -N -F+f+j -Dj0/0.1i << EOF >> $FIG.ps
10.5 0 12p,Times-Italic TC x
EOF
\rm -f t.d p.d fv.d

#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
