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
gmt math -T-3/3/0.01 T 1 ADD 20 MUL ATAN PI DIV 0.5 ADD = high.txt
gmt math -T-3/3/0.01 T 1 SUB 20 MUL ATAN PI DIV 0.5 ADD NEG 1 ADD = low.txt
gmt math high.txt L.D ADD 1 SUB 1.025 MUL = base.txt
gmt psxy -R-3/3/0/1.3 -JX5i/1i -P -K -W2p base.txt -Bx0 -By1g1 -BWS --MAP_FRAME_TYPE=graph --MAP_LABEL_OFFSET=0 >! $FIG.ps
gmt pstext -R -J -O -K -F+f12p,Times-Italic+jLT -N << EOF >> $FIG.ps
-2.8 0.8 B(f)
2.8 -0.1 f
EOF

#-------------------------------------------------
gmt psxy -R -J -O -T >> $FIG.ps
# Post-processing
rm -f low.txt high.txt base.txt

if ($#argv == 1) then
	gv $FIG.ps &
endif
