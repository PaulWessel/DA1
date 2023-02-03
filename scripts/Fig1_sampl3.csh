#!/bin/csh
#	$Id: Fig1_sampl3.csh 617 2017-12-06 19:10:05Z pwessel $
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
#-------------------------------------------------
gmt set PS_SCALE_X 0.75 PS_SCALE_Y 0.75
gmt sample1d -I1 -Fl << EOF | awk '{print $1, 0, 90, $2}' >! t.d
-1 0.5
1 0.5
EOF

gmt psxy -R-2/2/0/1 -JX3i/0.5i -P -K -Sv0.1i+e -Gblack -Wthicker,black -N t.d --PROJ_LENGTH_UNIT=inch >! $FIG.ps
echo "-2 0 0 3i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N >> $FIG.ps
gmt pstext -R -J -O -Dj0.05i/0.05i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
-1.5 1 TR @~D@~(f)
-1 0 TC -1/@~D@~t
0 0 TC 0
1 0 TC +1/@~D@~t
2 0 TC f
EOF
#-------------------------------------------------
# Post-processing

#\rm -f $FIG.ps
cat << EOF >! t.ps
%!PS-Adobe-3.0 EPSF-3.0
%%BoundingBox: 72 60 292 108
EOF
awk '{if (NR > 2) print $0}' $FIG.ps >> t.ps
mv -f t.ps $FIG.ps

if ($#argv == 1) then
	gv $FIG.ps &
endif
