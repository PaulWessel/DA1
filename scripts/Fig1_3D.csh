#!/bin/csh
#	$Id: Fig1_3D.csh 501 2016-05-19 03:46:17Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Draw Venn diagram
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
#-------------------------------------------------
gmt psxy -R-2/2/-2/2 -JX2.5i -P -K -Sv0.1i+e -N -Gblack -Wthicker,black << EOF >! $FIG.ps
0 0 0 1.25i
0 0 90 1i
0 0 225 1i
EOF
gmt psxy -R -JX -O -K -Glightgreen@25 << EOF >> $FIG.ps
0 0
-0.5 -0.5
1 -0.5
1.5 0
EOF
gmt psxy -R -JX -O -K -Glightred@50 << EOF >> $FIG.ps
0 0
1 -0.5
1 0.75
EOF
gmt psxy -R -J -O -K -Sv0.1i+e -N -Gblack -Wthicker,black << EOF >> $FIG.ps
0 0 37 0.8i
EOF
gmt psxy -R -JX -O -K -W0.25p,- << EOF >> $FIG.ps
> dxdy
-0.5 -0.5
1 -0.5
1.5 0
> dxdr
1 -0.5
1 0.75
0 0.75
> dr on xy
0 0
1 -0.5
EOF
gmt pstext -R -JX -O -F+f+j << EOF >> $FIG.ps
-0.8 -1 10p,Times-Italic LB x
1.7 -0.1 10p,Times-Italic TC y
0.15 1.45 10p,Times-Italic LM z
1.1 0.65 10p,Times-Bold LM v
0 -0.15 10p,Symbol TC f
0.15 0.25 10p,Symbol BC q
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
