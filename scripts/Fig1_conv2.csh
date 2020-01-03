#!/bin/csh
#	$Id: Fig1_conv2.csh 665 2018-12-06 16:40:23Z pwessel $
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
gmt psxy -R -Jx -O -K -W2p << EOF >> $FIG.ps
> 
0.5 0
0.5 0.6
>
0.75 0
0.75 0.4
>
1 0
1 0.2
>
1.25 0
1.25 0.4
>
4.25 0
4.25 1
>
4.5 0
4.5 -0.2
>
4.75 0
4.75 0.2
>
5 0
5 0.7
>
5.25 0
5.25 -0.4
>
5.5 0
5.5 0.3
EOF
gmt pstext -R -J -O -K -M -Glightgray -W1p -F+f+a+j -C0.1i << EOF >> $FIG.ps
> 3 0.5 14p,Times-Bold 0 CM 14p 0.9i c
FILTER

@%6%p(t)@%%
EOF
gmt pstext -R -J -O -Dj0.05i/0 -N -F+f+j << EOF >> $FIG.ps
1 1 14p,Times-Roman BC input @%6%d(t)@%%
5 1 14p,Times-Roman BC output @%6%h(t)@%%
2 -0.05 14p,Times-Italic TC t
6 -0.05 14p,Times-Italic TC t
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
