#!/bin/csh
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

gmt math -T-1.11/1.11/0.02 T 10 PI MUL MUL COS 0.05 MUL 1 T ABS SUB ADD = wiggle.d
gmt psxy -R-1.3/1.3/0/1.1 -JX2i/0.9i -P -K wiggle.d >! $FIG.ps
gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N << EOF >> $FIG.ps
-1.3 0 0 2i
0 0 90 1.0i
EOF
gmt pstext -R -J -O -K -Dj0.05i/0.05i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
-1.2 0.8 1BL D(f)
1.3 0 TC f
1.4 0.5 CM \031
EOF

gmt math -T-1.11/1.11/0.02 T 2.5 PI MUL MUL DUP SIN EXCH DIV = sinc.d
gmt psxy -R-1.3/1.3/-0.25/1.1 -JX1.5i/0.9i -O -K sinc.d -X2.25i -Y-0.18i >> $FIG.ps
gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N << EOF >> $FIG.ps
-1.3 0 0 1.5i
0 0 90 1.0i
EOF
gmt pstext -R -J -O -K -Dj0.05i/0.05i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
-1.2 1 BL P(f)
1.3 0 TC f
1.4 0.6 CM =
EOF

gmt math wiggle.d sinc.d MUL = h.d
gmt psxy -R -JX2i/0.9i -O -K h.d -X1.75i >> $FIG.ps
gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N << EOF >> $FIG.ps
-1.3 0 0 2i
0 0 90 1.0i
EOF
gmt pstext -R -J -O -Dj0.05i/0.05i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
-1.2 1 BL H(f)
1.3 0 TC f
EOF
\rm -f wiggle.d h.d sinc.d 
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
