#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Gaussian Normal pdf
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.75 PS_SCALE_Y 0.75
#-------------------------------------------------

gmt math -T-4/4/0.05 T DUP MUL 0.5 MUL NEG EXP 2 PI MUL SQRT DIV = $$
gmt psxy -R-3.5/3.5/0/0.5 -JX3i/1.25i -P -K -Glightgray -B1 -BS $$ --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt psxy -R -J -O -K -W2p $$ >> $FIG.ps
gmt psxy -R -J -O -K -W0.05p << EOF >>$FIG.ps
> -2
-2	0
-2	0.05
> -1
-1	0
-1	0.23
> 0
0 0
0 0.45
> +
1	0
1	0.23
> 2
2	0
2	0.05
EOF
gmt pstext -R -J -O -N -F+f+j << EOF >> $FIG.ps
-0.45 0.4 10p,Helvetica RM 0.3989
3.5 -0.05 12p,Times-Italic LT z
3 0.3 12p,Times-Roman LB 1 @~s@~ = 68.27%
3 0.2 12p,Times-Roman LB 2 @~s@~ = 95.45%
3 0.1 12p,Times-Roman LB 3 @~s@~ = 99.73%
EOF
\rm -f $$
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
