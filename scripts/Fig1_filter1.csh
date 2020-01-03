cp -f gmt.conf.DA1 gmt.conf
#!/bin/csh
#	$Id: Fig1_filter1.csh 665 2018-12-06 16:40:23Z pwessel $
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
gmt math -T0/1/0.002 0 1 NRAND = | gmt filter1d -Fg0.075 >! whitenoise.d
gmt filter1d -Fg0.2 whitenoise.d >! smooth.d
gmt psxy -R0/1/-1/1 -JX2i/1i -P -K -W0.5p whitenoise.d >! $FIG.ps
gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N << EOF >> $FIG.ps
0 0 0 2i
0 0 90 0.5i
EOF
gmt pstext -R -J -O -K -Dj0.05i/0.05i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
0 0.9 TL d(t)
1 0 TC t
1.05 0.3 CM *
EOF

gmt psxy -R -JX1.5i/1i -O -K -W0.5p -X2.25i << EOF >> $FIG.ps
0 0
0.3 0
0.3 0.5
0.7 0.5
0.7 0
1 0
EOF
gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N << EOF >> $FIG.ps
0 0 0 1.5i
0 0 90 0.5i
EOF
gmt pstext -R -J -O -K -Dj0.05i/0.05i -N -F+f+j << EOF >> $FIG.ps
0 0.9 10p,Times-Italic TL p(t)
0.3 0 8p,Times-Italic  TC -W/2
0.7 0 8p,Times-Italic  TC W/2
1   0 10p,Times-Italic TC t
1.075 0.4 10p,Times-Italic CM =
EOF

gmt psxy -R -JX2i/1i -O -K -W0.25p smooth.d -X1.75i >> $FIG.ps
gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N << EOF >> $FIG.ps
0 0 0 2i
0 0 90 0.5i
EOF
gmt pstext -R -J -O -Dj0.05i/0.05i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
0 0.9 TL h(t)
1 0   TC t
EOF
\rm -f whitenoise.d smooth.d
#-------------------------------------------------
# Post-processing.

if ($#argv == 1) then
	gv $FIG.ps &
endif
