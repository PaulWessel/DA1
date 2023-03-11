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
gmt set PS_SCALE_X 0.7 PS_SCALE_Y 0.7
#-------------------------------------------------
gmt math -T0/8/1 0.25 8 T BPDF = t.d
gmt psxy -R-0.6/8.6/0/0.38 -JX4i/1.25i -P -K -Glightgray t.d -Sb0.8u -W0.5p -BWS -Bxa1 -Byaf --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt pstext -R -J -O -N -F+f+j -Dj0.15/0.1i << EOF >> $FIG.ps
-1 39 12p,Times-Italic TC P
8.5 0 12p,Times-Italic TC x
EOF
\rm -f t.d

#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
