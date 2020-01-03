#!/bin/csh
#	$Id: Fig1_func_uncertainty.csh 507 2016-05-23 00:54:38Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Uncertainty in a function
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.7 PS_SCALE_Y 0.7
#-------------------------------------------------

gmt math -T0.5/6/0.1 T SQRT = | gmt psxy -R0.7/5.5/0.8/2.3 -JX4i/2i -W1.5p -K -B0 -BWS -P --MAP_FRAME_TYPE=graph >! $FIG.ps
# Slope of sqrt(x) at x = 3 is 0.2887
gmt psxy -R -J -O -K << EOF >> $FIG.ps
> tangent at x = 7.5 -W0.25p
1	1.1547
5	2.3094
> steps -W0.25p,-
3 1.73205
3	2
4	2
> Lines to x0, y0 -W0.25p,.
0.7	1.73205
3	1.73205
3	0	
EOF
echo "3 1.73205" | gmt psxy -R -J -O -K -Sc0.05i -Gblack >> $FIG.ps
gmt pstext -R -J -O -Dj0.05i/0.05i -F+f12p,Times-Italic+j -N << EOF >> $FIG.ps
5.4 0.75 LT x
0.6 2.15 RB y
1.5 1.15 LM y = f(x)
3 1.866 RM @~d@~y
3 0.75 TC x@-0@-
0.6 1.73205 RM y@-0@-
3.5 2 CB @~d@~x
EOF

#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
