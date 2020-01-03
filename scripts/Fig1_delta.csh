#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Draw delta function transform pair
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------
# Draw spike
gmt psxy -R-1/1/0/1.25 -JX2.5i/1i -P -K -Sv0.15i+e -W2p -Gblack --MAP_FRAME_TYPE=graph -Bxa5 -Bya1 -BSW << EOF >! $FIG.ps
0	0	90	1i
EOF
echo 1 0 t | gmt pstext -R -J -O -K -F+f16p,Times-Italic+jRT -DJ0.1i -N>> $FIG.ps
echo "a)" | gmt pstext -R -J -O -K -F+cTL+f16p+jRB -DJ0.15i -N >> $FIG.ps
# Draw constant
gmt psxy -R -J -O -K -W2p -X3.25i --MAP_FRAME_TYPE=graph -Bxa5 -Bya1 -BSW << EOF >> $FIG.ps
>
-0.8	1
0.8	1
> -W2p,2_2:0p
-1	1
1	1
EOF
echo 1 0 f | gmt pstext -R -J -O -K -F+f16p,Times-Italic+jRT -DJ0.1i -N >> $FIG.ps
echo "b)" | gmt pstext -R -J -O -K -F+cTL+f16p+jRB -DJ0.15i -N >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
