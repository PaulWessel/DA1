#!/bin/csh
#	$Id: Fig1_normal_tails.csh 201 2015-05-22 13:32:49Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Compare normal and student-t distros
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8
#-------------------------------------------------

gmt math -T-5/5/0.05 T ZPDF = $$
gmt psxy -R-3.99/3.99/0/0.5 -JX3.5i/1.25i $$ -Glightgreen -P -K >! $FIG.ps
echo '> left tail' >! tail.d
awk '{if ($1 <= -2) print $0}' $$ >> tail.d
echo "-2 0" >> tail.d
echo '> right tail' >> tail.d
echo "2 0" >> tail.d
awk '{if ($1 >= 2) print $0}' $$ >> tail.d
gmt psxy -R -J -O -K -Glightred tail.d >> $FIG.ps
gmt psxy -R -J -O -K -W1p $$ -B2 -Bs --MAP_FRAME_TYPE=graph >> $FIG.ps
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
gmt pstext -R -J -O -K -N -F+f12p,Times-Italic+j << EOF >> $FIG.ps
-2 -0.04 TC -z@-@~a@~/2@-
2 -0.04 TC +z@-@~a@~/2@-
0 0.2 CM P = 1 - @~a@~
3.5 -0.04 LT z
EOF
gmt math -T-4/4/0.05 T 3 TPDF = $$
gmt psxy -R -J -O -K -W1p,red $$ >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps

\rm -f $$ tail.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
