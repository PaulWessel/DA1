#!/bin/csh
#	$Id: Fig1_sampl1.csh 617 2017-12-06 19:10:05Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Draw autocorrelating
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.7 PS_SCALE_Y 0.7
#-------------------------------------------------
gmt sample1d -I1 -Fl << EOF | awk '{print $1, 0, 90, $2}' >! t.d
-4 0.5
4 0.5
EOF

gmt psxy -R-7/7/0/1 -JX4i/0.5i -P -K -Sv0.1i+e -Gblack -Wthicker,black -N t.d --PROJ_LENGTH_UNIT=inch >! $FIG.ps
gmt psxy -R -J -O -K -Sc0.03i -Gblack -N << EOF >> $FIG.ps
-7 0.5
-6 0.5
-5 0.5
7 0.5
6 0.5
5 0.5
EOF
echo "-7 0 0 4i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N >> $FIG.ps
gmt pstext -R -J -O -Dj0.05i/0.05i -N -F+f10p,Times-Italic+jTC << EOF >> $FIG.ps
-1 0  @~-D@~t
0 0 0
1 0 @~D@~t
2 0 @~2D@~t
7 0 t
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
