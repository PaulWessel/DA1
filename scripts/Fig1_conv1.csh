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
gmt set PS_SCALE_X 0.55 PS_SCALE_Y 0.55
#-------------------------------------------------
gmt psxy -R0/6/-1/1 -Jx1i/0.75i -P -K -Sv0.1i+e -Gblack -N -Wthicker,black << EOF >! $FIG.ps
0 0 0 2i
4 0 0 2i
EOF
gmt psxy -R -J -O -K -W2p << EOF >> $FIG.ps
> 
1 0
1 0.2
>
4.5 0
4.5 1
>
4.75 0
4.75 -0.8
>
5 0
5 0.4
EOF
gmt pstext -R -J -O -K -M -Glightgray -W1p -F+f+a+j -C0.1i << EOF >> $FIG.ps
> 3 0.5 14p,Times-Bold 0 CM 14p 0.9i c
FILTER

@%6%p(t)@%%
EOF
gmt pstext -R -J -O -Dj0.05i/0 -N -F+f+j << EOF >> $FIG.ps
1 1 14p,Times-Roman BC impulse @%6%d(t)@%%
5 1 14p,Times-Roman BC output @%6%h(t)@%%
2 -0.05 14p,Times-Italic TC t
6 -0.05 14p,Times-Italic TC t
0.5 -1 14p,Times-Roman TC 0
0.75 -1 14p,Times-Roman TC 0
1 -1 14p,Times-Roman TC 1
1.25 -1 14p,Times-Roman TC 0
1.5 -1 14p,Times-Roman TC 0
#
4 -1 14p,Times-Roman TC 0
4.25 -1 14p,Times-Roman TC 0
4.5 -1 14p,Times-Roman TC 5
4.75 -1 14p,Times-Roman TC -4
5 -1 14p,Times-Roman TC 2
5.25 -1 14p,Times-Roman TC 0
5.5 -1 14p,Times-Roman TC 0
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
