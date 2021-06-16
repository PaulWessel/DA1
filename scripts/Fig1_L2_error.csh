#!/bin/csh
#	$Id: Fig1_L2_error.csh 507 2016-05-23 00:54:38Z pwessel $
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
gmt psxy -R0/4/-0.25/2.5 -Jx1i/0.6i -P -B0 -BWS -W0.5p -K --MAP_FRAME_TYPE=graph << EOF >! $FIG.ps
> line y = 0.6 x  -W2p
0 0
4 2.4
> -W0.5p
0.25 0.15
0.25	0.8
>
0.9	0.54
0.9	0
>
1.4	0.84
1.4	0.9
>
2.0	1.2
2.0	1
>
2.6	1.56
2.6 2.4
>
2.9	1.74
2.9	1.3
>
3.6	2.16
3.6 2.4
EOF
gmt psxy -R -J -O -K -Sc0.075i -Gblack << EOF >> $FIG.ps
0.25	0.8
0.9	0
1.4	0.9
2.0	1
2.6 2.4
2.9	1.3
3.6 2.4
EOF
gmt pstext -R -J -O -N -Dj0.05i/0.05i -F+f13p,Times-Italic+j << EOF >> $FIG.ps
3.8 -0.35 LT x
0  2.5 RB d
2.6 1.98 RM e@-i@-
EOF
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
