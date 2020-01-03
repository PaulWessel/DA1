#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Show reading of Normal CDF table
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.75 PS_SCALE_Y 0.75
#-------------------------------------------------

gmt math -T-5/5/0.05 T ZPDF = $$
set zl = `gmt math -Q 0.1 ZCRIT 0.05 DIV RINT 0.05 MUL =`
set y = `gmt math -Q $zl ZPDF =`
gmt psxy -R-4.5/4.5/0/0.5 -JX4i/1.25i $$ -Gwhite -P -K >! $FIG.ps
echo '> left tail' >! tail.d
awk '{if ($1 <= '"$zl"') print $0}' $$ >> tail.d
echo "$zl 0" >> tail.d
gmt psxy -R -J -O -K -Ggray tail.d >> $FIG.ps
gmt psxy -R -J -O -K -W1p $$ -B5 -Bs --MAP_FRAME_TYPE=graph >> $FIG.ps
gmt psxy -R -J -O -K -W0.05p -N << EOF >>$FIG.ps
> 0
0 0
0 0.45
>
$zl 0
$zl $y
>
-1.7	0.04
-2.18	0.18
EOF
gmt pstext -R -J -O -K -N -F+f12p,Times-Italic+j << EOF >> $FIG.ps
-2.2 0.2 BR P
$zl -0.04 TC z@-P@-
4.4 -0.04 LT z
EOF
gmt psxy -R -J -O -T >> $FIG.ps

\rm -f $$ tail.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
