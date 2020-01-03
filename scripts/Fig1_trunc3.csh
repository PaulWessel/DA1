#!/bin/csh
#	$Id: Fig1_trunc3.csh 617 2017-12-06 19:10:05Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Draw truncation
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------
gmt math -T-1.005/1.005/0.01 T PI 8 MUL MUL DUP SIN EXCH DIV = sinc.d
gmt math sinc.d DUP MUL = sinc2.d
gmt math -T-1.005/1.005/0.01 T 0.7 DIV ABS DUP PI MUL COS 1 ADD 0.5 MUL EXCH 1 LE MUL = cos.d
gmt math cos.d sinc.d MUL = cos2.d
cat << EOF | gmt psxy -R-1/1/0/1.3 -JX2.5i/1i -P -K >! $FIG.ps
> Box -W1p
-1 0
-0.7 0
-0.7 1
0.7 1
0.7 0
1 0
> Triangle -W0.5p
-1 0
-0.7 0
0 1
0.7 0
1 0
EOF
gmt psxy -R -J -O -K -W0.5,1_1:0p cos.d >> $FIG.ps
gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N << EOF >> $FIG.ps
-1 0 0 2.5i
0 0 90 1i
EOF
gmt pstext -R -J -O -K -Dj0.05i/0.05i -N -F+f10p,Times-Italic+jTC << EOF >> $FIG.ps
1 0 t
EOF

gmt psxy -R-1/1/-0.25/1 -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N -X2.75i -Y-0.2i << EOF >> $FIG.ps
-1 0 0 2.5i
0 0 90 1i
EOF
gmt psxy -R -J -O -K -W1p sinc.d >> $FIG.ps
gmt psxy -R -J -O -K -W0.5p sinc2.d >> $FIG.ps
gmt psxy -R -J -O -K -W0.5,1_1:0p cos2.d >> $FIG.ps
gmt pstext -R -J -O -Dj0.05i/0.05i -N -F+f10p,Times-Italic+jTC << EOF >> $FIG.ps
1 0 f
EOF
\rm -f sinc.d cos.d sinc2.d cos2.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
