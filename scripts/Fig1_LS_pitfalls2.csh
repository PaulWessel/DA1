#!/bin/csh
#	$Id: Fig1_LS_pitfalls2.csh 507 2016-05-23 00:54:38Z pwessel $
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

gmt psxy -R0/2.5/0.0/2.0 -Jx1i -P -K -B0 -Bws -Sc0.075i -Gblack --MAP_FRAME_TYPE=graph << EOF >! $FIG.ps
0.25 0.23
0.35 0.68
0.45 1.00
0.55 1.47
0.65 1.89
EOF
gmt psxy -R -J -O -K -W1p << EOF >> $FIG.ps
0.1 -0.35
0.6875 2
EOF
gmt pstext -R -J -O -K -Dj0.1i/0.1i -F+f12p,Times-Roman+j << EOF >> $FIG.ps
0.25 0.23 LM 1
0.35 0.68 LM 2
0.45 1.00 LM 3
0.55 1.47 LM 4
0.65 1.89 LM 5
0.6  1.9  RM LS
EOF

gmt psxy -R -J -O -K -B0 -Bws -Sc0.075i -Gblack --MAP_FRAME_TYPE=graph -X2.75i << EOF >> $FIG.ps
2.4 0.23
0.35 0.68
0.45 1.00
0.55 1.47
0.65 1.89
EOF
echo "0.25 0.23" | gmt psxy -R -J -O -K -Sc0.075i -Gwhite -W0.25p >> $FIG.ps
gmt psxy -R -J -O -K -W1p << EOF >> $FIG.ps
> LS
0.1 1.5
2.4 0.3
> -W0.5p,-
0.30 0.23
2.35 0.23
EOF
gmt pstext -R -J -O -Dj0.1i/0.1i -N -F+f12p,Times-Roman+j << EOF >> $FIG.ps
2.4 0.23  LM 1
0.35 0.68 LM 2
0.45 1.00 LM 3
0.55 1.47 LM 4
0.65 1.89 LM 5
2.0 0.6   CB LS
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
