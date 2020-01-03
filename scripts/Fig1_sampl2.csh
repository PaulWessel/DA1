#!/bin/csh
#	$Id: Fig1_sampl2.csh 665 2018-12-06 16:40:23Z pwessel $
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
gmt set PS_SCALE_X 0.7 PS_SCALE_Y 0.7
gmt math -T-5.01/5.01/0.02 T 0.72 ADD PI MUL DUP SIN EXCH DIV 0.85 MUL T 0.72 SUB PI MUL DUP SIN EXCH DIV ADD 0.1 SUB = ft.d
gmt sample1d -I1 -Fl ft.d | awk '{if ($2 > 0) {print $1, 0, 90, $2} else {print $1, 0, -90, -$2}}' >! f.d

gmt psxy -R-6/6/-0.4/1 -JX1.5i/1i -P -K ft.d -W0.5p >! $FIG.ps
gmt pstext -R -J -O -K -Dj0.05i/0.05i -N -F+f10p,Times-Italic+jTC << EOF >> $FIG.ps
6 -0.2 t
-5 0.4 d(t)
8 0.4 \031
EOF
gmt psxy -R -J -O -K -W0.25p << EOF >> $FIG.ps
-6 0
6 0
EOF
gmt sample1d -I1 -Fl << EOF | awk '{print $1, 0, 90, $2}' >! c.d
0 0.5
4 0.5
EOF
gmt psxy -R-1/5/-0.5/1 -JX1.5i/0.5i -O -K -Sv0.1i+e -Gblack -Wthicker,black -N c.d -X2i --PROJ_LENGTH_UNIT=inch >> $FIG.ps
gmt psxy -R -J -O -K -W0.25p << EOF >> $FIG.ps
-1 0
5 0
EOF
gmt pstext -R -J -O -K -Dj0.05i/0.05i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
0 0.8 RM @~D@~(t)
6 0.8 TC =
EOF
gmt pstext -R -J -O -K -Dj0.05i/0.05i -N -F+f10p,Times-Italic+jTC << EOF >> $FIG.ps
0 0 0
1 0 @~D@~t
2 0 @~2D@~t
5 0 t
EOF

gmt psxy -R-6/6/-0.5/1 -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N f.d -X2i --PROJ_LENGTH_UNIT=inch >> $FIG.ps
gmt psxy -R -J -O -K -W0.25p << EOF >> $FIG.ps
-6 0
6 0
EOF
gmt pstext -R -J -O -Dj0.05i/0.05i -N -F+f10p,Times-Italic+jTC << EOF >> $FIG.ps
5 1 d@-t@-
6 0 t
EOF
\rm -f ft.d f.d c.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
