#!/bin/csh
#	$Id: Fig1_sincos.csh 617 2017-12-06 19:10:05Z pwessel $
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
if ($#argv == 2) then # Special vertical plot for cover
	set start = "-O -K"
	set stop = "-O -K"
	set FIG = ${FIG}_cover
else	# Regular figure
	set start = "-K"
	set stop = "-O"
endif
gmt math -T0/1/0.01 T 2 MUL PI MUL SIN = sin.d
gmt math -T0/1/0.01 T 2 MUL PI MUL COS = cos.d
set angle = 65
gmt psxy -R-1/1/-1/1 -JX2i -P $start -Sc1.7i -Glightgreen -W1p << EOF >! $FIG.ps
0 0
EOF
gmt psxy -R -J -O -K -Sw1.7i -Glightred  << EOF >> $FIG.ps
0 0 0 $angle
EOF
gmt psxy -R -J -O -K -Sv0.15i+e -Gblack -Wthicker -N << EOF >> $FIG.ps
-1 0 0 2.2i
0 -1 90 2.2i
EOF
gmt psxy -R -J -O -K -Sv0.1i+e -Gblack << EOF >> $FIG.ps
0 0 $angle 0.85i
EOF
echo 0 0 0.35i 0 $angle | gmt psxy -R -J -O -K -Sm0.08i+e -Gblack >> $FIG.ps
set x = `gmt math -Q $angle COSD 1.7 2 DIV MUL =`
set y = `gmt math -Q $angle SIND 1.7 2 DIV MUL =`
gmt psxy -R -J -O -K -W0.25p,- << EOF >> $FIG.ps
> 
$x 0
$x $y
>
0 $y
$x $y
EOF
set x0 = `gmt math -Q $angle 2 DIV COSD 0.25 MUL =`
set y0 = `gmt math -Q $angle 2 DIV SIND 0.25 MUL =`
gmt pstext -R -J -O -K -F+f+j << EOF >> $FIG.ps
0.3 1 12p,Times-Italic LT @~f = f@~(t)
$x -0.05 12p,Times-Italic TC x
-0.05 $y 12p,Times-Italic RM y
0.08 0.425 12p,Times-Italic LB r
$x0 $y0 12p,Symbol CM f@-0@-
EOF
echo "a)" | gmt pstext -R -J -O -K -F+cTL+f16p -D-0.1i/0 -N >> $FIG.ps
set x = `gmt math -Q $angle 360 DIV =`
gmt psxy -R0/1/-1.1/1.5 -JX2i/1.2i -O -K -W1.5p -X2.5i -Y0.4i -Bx0 -By0g2 -BWS sin.d cos.d --MAP_FRAME_TYPE=graph >> $FIG.ps
gmt psxy -R -J -O -K -W0.5p,- << EOF >> $FIG.ps
$x -1.1
$x 1.1
EOF
gmt pstext -R -J -O -K -N -F+f+j << EOF >> $FIG.ps
1.05 1 12p,Times-Roman LM @%6%x =@%% cos @~f@~
1.05 0 12p,Times-Roman LM @%6%y =@%% sin @~f@~
0.95 -1.15 12p,Times-Italic RT @~f@~(t)
$x -1.15 12p,Times-Italic CT @~f@-0@-@~
EOF
echo "b)" | gmt pstext -R -J $stop -F+cTL+f16p -D-0.2i/0.4i -N >> $FIG.ps
\rm -f t.d sin.d cos.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
