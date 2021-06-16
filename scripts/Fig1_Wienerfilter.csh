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
cp -f gmt.conf.DA2 gmt.conf
gmt set PS_SCALE_X 0.65 PS_SCALE_Y 0.65
#-------------------------------------------------
gmt math -T0/6/0.01 T 2 MUL DUP MUL -0.5 MUL EXP 0.5 ADD T 0.1 MUL SUB = C.d
gmt psxy -R0/3/0/1.6 -JX5i/2i -P -K -W4p,0_8:0p C.d --PS_LINE_CAP=round >! $FIG.ps
gmt math -T0/6/0.01 0.5 T 0.1 MUL SUB = N.d
gmt psxy -R -J -O -K -W0.5p,- N.d >> $FIG.ps
gmt math C.d T 0.75 SUB DUP 0 GT MUL 2 POW 2 MUL SUB = S.d
gmt psxy -R -J -O -K -W1p S.d >> $FIG.ps
gmt pstext -R -J -O -K -F+f12p,Helvetica+a+jLM << EOF >> $FIG.ps
1.0 0.65 0 C@+2@+
0.05 0.6 -5 N@+2@+ (estimated)
1.2 0.15 0 S@+2@+ (derived)
EOF
gmt psbasemap -R0/1000/1e-5/10 -JX5i/2il -O -K -Bxa500f100+l"Frequency, @%6%f@%%" -By0 -BS --MAP_FRAME_TYPE=graph --MAP_LABEL_OFFSET=0 >> $FIG.ps
gmt psbasemap -R -J -O -K -Bx0 -By1p+l"log |C|@+2@+" -BW --MAP_FRAME_TYPE=graph >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps

#-------------------------------------------------
# Post-processing
rm -f C.d S.d N.d

if ($#argv == 1) then
	gv $FIG.ps &
endif
