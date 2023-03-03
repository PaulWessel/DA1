#!/bin/csh
#	$Id: Fig1_normal_tails.csh 498 2016-05-19 01:53:24Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Tails of a Normal pdf
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8
#-------------------------------------------------

gmt math -T-4/4/0.05 T DUP MUL 0.5 MUL NEG EXP 2 PI MUL SQRT DIV = $$
gmt psxy -R-3.5/3.5/0/0.5 -JX3i/1.25i $$ -Glightgreen -P -K >! $FIG.ps
echo '> left tail' >! tail.d
awk '{if ($1 <= -2) print $0}' $$ >> tail.d
echo "-2 0" >> tail.d
echo '> right tail' >> tail.d
echo "2 0" >> tail.d
awk '{if ($1 >= 2) print $0}' $$ >> tail.d
gmt psxy -R -J -O -K -Glightred tail.d >> $FIG.ps
gmt psxy -R -J -O -K -W2p $$ -B2 -Bs --MAP_FRAME_TYPE=graph >> $FIG.ps
gmt psxy -R -J -O -K -W0.05p << EOF >>$FIG.ps
> 0
0 0
0 0.15
>
0 0.24
0 0.45
>
-2 0
-2 0.05
>
2 0
2 0.05
EOF
gmt pstext -R -J -O -N -F+f12p,Times-Italic+j << EOF >> $FIG.ps
-2 -0.04 TC -z@-@~a@~/2@-
2 -0.04 TC +z@-@~a@~/2@-
0 0.2 CM P = 1 - @~a@~
3.5 -0.04 LT z
EOF
\rm -f $$ tail.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
