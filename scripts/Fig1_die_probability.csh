#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: die probabiliby
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8 
#-------------------------------------------------

gmt psbasemap -R0.01/6.99/0/1.2 -JX3i/0.75i -P -Bx1 -By0 -BwS -K --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt psxy -R -J -O -Glightgray -W0.5p -K << EOF >> $FIG.ps
0.5 0
0.5 1
6.5 1
6.5 0
EOF
gmt psxy -R -J -O -W2p -K << EOF >> $FIG.ps
> 1
0.5 0
0.5 1
> 2
1.5 0
1.5 1
> 3
2.5 0
2.5 1
> 4
3.5 0
3.5 1
> 5
4.5 0
4.5 1
> 6
5.5 0
5.5 1
> 6right
6.5 0
6.5 1
> grid 1 -W0.25p,-
1 0
1 1
> grid 2 -W0.25p,-
2 0
2 1
> grid 3 -W0.25p,-
3 0
3 1
> grid 4 -W0.25p,-
4 0
4 1
> grid 5 -W0.25p,-
5 0
5 1
> grid 6 -W0.25p,-
6 0
6 1
EOF
gmt psxy -R -J -O -K -Sc0.05i -Gblack << EOF >> $FIG.ps
1 1
2 1
3 1
4 1
5 1
6 1
EOF
gmt pstext -R -J -O -N -F+f+j << EOF >> $FIG.ps
6.8 -0.1 12p,Times-Italic TC x
-0.35 1.025 10p,Times-Roman BC 1
-0.35 0.95 10p,Times-Roman MC -
-0.35 0.97 10p,Times-Roman TC 6
-0.2 1.25 12p,Times-Italic BC P
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
