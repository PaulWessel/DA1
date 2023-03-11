#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Kelvin's temperature profile
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.7 PS_SCALE_Y 0.7
#-------------------------------------------------

gmt math -T0/2/0.01 T 0.8 MUL ERF = | awk '{print $2, $1}' >! $$
gmt psbasemap -R0/2050/0/950 -JX4i/-2i -Bxa500+u"\232" -By200+l" km" -BWN -P -K --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt psxy -R -J -O -K << EOF >> $FIG.ps
> gradient -W0.25p
0 0
1000 375
> Deep temp -W0.25p,-
2000 0
2000 1000
EOF
gmt pstext -R -J -O -K -Dj0.05i/0 -F+f10p,Times-Italic+j << EOF >> $FIG.ps
1000 375 LM G(t@-0@-)
2000 500 RM T@-0@-
1350 800 LM T(z,t@-0@-)
EOF
gmt psxy -R0/1.5/0/2 -J $$ -W1p -O >> $FIG.ps

\rm -f $$
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
