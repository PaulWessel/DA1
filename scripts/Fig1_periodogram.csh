#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Draw a periodogram
# Use data as y = 0.5 *cos (w_1*t) + 0.75 * cos (w_2 * t) + 0.5 * sin (w_3 * t) + 0.25 * cos (w_3 * t)
#   + (1/3) * cos (w_4 * t) + 0.2 * sin (w_4 * t) + (1/3) * sin (w_6 * t) - 0.6
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------
gmt psbasemap -R0/6.5/0/1.99 -JX4i/1i -Bxa1f -Bya0.5 -BWS -P -K --FONT_ANNOT_PRIMARY=10p --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt psxy -R -J -O -K -W1p << EOF >> $FIG.ps
>
1	0
1	0.25
>
2	0
2	0.5625
>
3	0
3	0.3125
>
4	0
4	0.151111
# Nothing at 5
>
6	0
6	0.09
EOF
gmt psxy -R -J -O -K -Sc0.2c -Wthin -Gblack -N << EOF >> $FIG.ps
0	1.44
1	0.25
2	0.5625
3	0.3125
4	0.151111
5	0
6	0.111111
EOF
gmt pstext -R -J -O -N -F+f+j << EOF >> $FIG.ps
6.4 -0.1 12p,Times-Italic TL j
-0.25 1.85 12p,Times-Italic BR A@-j@-@+2@+
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
