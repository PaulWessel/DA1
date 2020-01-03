#!/bin/csh
#	$Id: Fig1_whitenoise.csh 591 2017-11-08 00:36:52Z pwessel $
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
gmt set PS_SCALE_X 0.75 PS_SCALE_Y 0.75
#-------------------------------------------------
gmt math -T0/10/0.1 0 1 NRAND = noise.d
echo "0 1" >! ac.d
gmt math -T0.1/10/0.1 0 0.07 NRAND = >> ac.d

gmt psxy -R-0.2/10.2/-3/3 -JX2i/1.25i -P -K -W0.25p noise.d -Ba5f20 -BWS --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt pstext -R -J -O -K -N -F+f+j << EOF >> $FIG.ps
-0.7 3 12p,Helvetica RT a)
9 -3.3 10p,Times-Italic LT @~t@~
EOF
set r = `gmt math -Q 101 SQRT INV 1.96 MUL =`
gmt psxy -R-0.2/10.2/-1/1.3 -JX2i/1.25i -O -K -Glightgray -Bx0f20 -By1 -BWS -X2.6i --MAP_FRAME_TYPE=graph << EOF >> $FIG.ps
-0.2 -${r}
10.2 -${r}
10.2 ${r}
-0.2 ${r}
EOF
gmt psxy -R -J -O -K -W0.5p ac.d >> $FIG.ps
gmt psxy -R -J -O -K -W0.25p,- << EOF >> $FIG.ps
> 
0 -0.2
10 -0.2
>
0 0.2
10 0.2
EOF
gmt pstext -R -J -O -N -F+f+j << EOF >> $FIG.ps
-1.7 1.3 12p,Helvetica RT b)
9 -1.1 10p,Times-Italic LT @~t@~
EOF
\rm -f ac.d noise.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
