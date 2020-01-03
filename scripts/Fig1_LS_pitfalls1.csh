#!/bin/csh
#	$Id: Fig1_LS_pitfalls1.csh 507 2016-05-23 00:54:38Z pwessel $
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
gmt set PS_SCALE_X 0.5 PS_SCALE_Y 0.5
#-------------------------------------------------

gmt psxy -R0/2.5/0.2/2.4 -Jx1i -P -K -B0 -Bws -Sc0.075i -Gblack --MAP_FRAME_TYPE=graph << EOF >! $FIG.ps
0.25 1.78
0.75 1.42
1.25 1.13
1.75 0.87
2.25 0.52
EOF
gmt psxy -R -J -O -K -W1p << EOF >> $FIG.ps
0.1 1.84
2.4 0.46
EOF
gmt pstext -R -J -O -K -Dj0.1i/0.1i -F+f12p,Times-Roman+j << EOF >> $FIG.ps
0.25 1.78 TC 1
0.75 1.42 TC 2
1.25 1.13 TC 3
1.75 0.87 TC 4
2.25 0.52 TC 5
2.25 0.65 CB LS
EOF

gmt psxy -R -J -O -K -B0 -Bws -Sc0.075i -Gblack -X2.75i --MAP_FRAME_TYPE=graph << EOF >> $FIG.ps
0.25 1.78
0.75 1.42
1.25 1.13
1.75 2.3
2.25 0.52
EOF
echo "1.75 0.87" | gmt psxy -R -J -O -K -Sc0.075i -Gwhite -W0.25p >> $FIG.ps
gmt psxy -R -J -O -K -W1p << EOF >> $FIG.ps
> LS
0.1 1.8
2.4 1.8
> -W0.5p,-
1.75 0.9
1.75 2.25
EOF
gmt pstext -R -J -O -Dj0.1i/0.1i -F+f12p,Times-Roman+j << EOF >> $FIG.ps
0.25 1.78 TC 1
0.75 1.42 TC 2
1.25 1.13 TC 3
1.75 0.87 TC 4
2.25 0.52 TC 5
2.25 1.8  CB LS
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
