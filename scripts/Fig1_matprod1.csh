#!/bin/csh
#	$Id: Fig1_matprod1.csh 507 2016-05-23 00:54:38Z pwessel $
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
gmt psxy -R0/4/0/3 -Jx1i -P -K -W0.25 -G230 << EOF >! $FIG.ps
> A
0 0
1.5 0
1.5 0.75
0	0.75
> B
2.0 1.25
3 1.25
3 2.75
2.0 2.75
> C
2.0 0
3.0 0
3.0 0.75
2.0 0.75	
EOF
gmt psxy -R -J -O -K -W0.25p << EOF >> $FIG.ps
> -Glightgreen
0 0.6
1.5 0.6
1.5 0.75
0 0.75
> -Glightblue
0 0.15
1.5 0.15
1.5 0.30
0 0.3
> -Glightgreen
2 1.25
2.15 1.25
2.15 2.75
2 2.75
> -Glightblue
2.6 1.25
2.75 1.25
2.75 2.75
2.6 2.75
> -Glightgreen
2.0 0.75
2.15 0.75
2.15 0.6
2.0 0.6
> -Glightblue
2.6 0.15
2.75 0.15
2.75 0.30
2.60 0.30
EOF
gmt pstext -R -J -O -N -Dj0.075i/0.075i -F+f+j << EOF >> $FIG.ps
0 0.375 12p,Times-Italic RM n
0.75 0 12p,Times-Italic TC p
0.75 0.4 12p,Times-Bold CM A
2 2 12p,Times-Italic RM p
2.5 1.25 12p,Times-Italic TC k
2.5 2 12p,Times-Bold CM B
2 0.375 12p,Times-Italic RM n
2.5 0 12p,Times-Italic TC k
2.5 0.375 12p,Times-Bold CM C
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
