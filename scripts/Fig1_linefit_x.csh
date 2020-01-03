#!/bin/csh
#	$Id: Fig1_linefit_x.csh 507 2016-05-23 00:54:38Z pwessel $
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
gmt psxy -R0/2.5/0/2 -Jx1i -P -K -B0 -Bws -Sc0.1i -Gwhite -Wfaint -Ey/1p --MAP_FRAME_TYPE=graph << EOF >! $FIG.ps
0.4 0.8 0.2
1.3 1.2 0.25
2.35 1.75 0.2
EOF
gmt psxy -R -J -O -K -W2p << EOF >> $FIG.ps
>
0 0.35
2.5 2.05
>
0 0.85
2.5 1.6
EOF
gmt psxy -R -J -O -K -B0 -Bws -Sc0.1i -Gwhite -Wfaint -Ey/1p -X3i --MAP_FRAME_TYPE=graph << EOF >> $FIG.ps
1.2 0.8 0.2
1.5 1.1 0.25
1.8 1.25 0.2
EOF
gmt psxy -R -J -O -W2p << EOF >> $FIG.ps
>
0.7 0.0
2.3 2.1
>
0 0.8
2.5 1.18
EOF

#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
