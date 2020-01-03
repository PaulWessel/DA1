#!/bin/csh
#	$Id: Fig1_type2_error.csh 507 2016-05-23 00:54:38Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Setup leading to possible Type II error in test
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.75 PS_SCALE_Y 0.75
#-------------------------------------------------

gmt math -T2.24/2.75/0.01 T 2.53 SUB 0.06 DIV DUP MUL 0.5 MUL NEG EXP 2 PI MUL SQRT DIV = $$
gmt psxy -R2.24/2.75/0/0.45 -JX4i/1.25i $$ -Glightgreen -P -K >! $FIG.ps
echo '> left tail' >! tail.d
awk '{if ($1 <= 2.45) print $0}' $$ >> tail.d
echo "2.45 0" >> tail.d
gmt psxy -R -J -O -K -Glightred tail.d >> $FIG.ps
gmt psxy -R -J -O -K -W2p $$ -Baf -BS --MAP_FRAME_TYPE=graph >> $FIG.ps
gmt psxy -R -J -O -K -W0.25p,- -N << EOF >>$FIG.ps
>
2.25 0
2.25 0.45
>
2.45 0
2.45 0.45
EOF
gmt pstext -R -J -O -N -F+f+j << EOF >> $FIG.ps
#-3 -0.04 12p,Times-Roman TC 2.25
#-2 -0.04 12p,Times-Roman TC 2.45
#0 -0.04 12p,Times-Roman TC 2.53
2.53 0.2 12p,Times-Roman CM reject claim
2.35 0.2 12p,Times-Roman CM accept claim
2.77 -0.05 12p,Times-Italic LT @~r@~
EOF
\rm -f $$ tail.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
