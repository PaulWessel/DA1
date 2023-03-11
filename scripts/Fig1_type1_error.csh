#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Setup leading to possible Type I error in test
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.75 PS_SCALE_Y 0.75
#-------------------------------------------------
if ($#argv == 2) then # Special vertical plot for cover
	set start = "-O -K"
	set stop = "-O -K"
	set FIG = ${FIG}_cover
else	# Regular figure
	set start = "-K"
	set stop = "-O"
endif

gmt math -T2.1/2.6/0.01 T 2.35 SUB 0.06 DIV DUP MUL 0.5 MUL NEG EXP 2 PI MUL SQRT DIV = $$
gmt psxy -R2.1/2.6/0/0.45 -JX4i/1.25i -P $start $$ -Glightgreen >! $FIG.ps
echo '> left tail' >! tail.d
awk '{if ($1 <= 2.25) print $0}' $$ >> tail.d
echo "2.25 0" >> tail.d
echo '> right tail' >> tail.d
echo "2.45 0" >> tail.d
awk '{if ($1 >= 2.45) print $0}' $$ >> tail.d
gmt psxy -R -J -O -K -Glightred tail.d >> $FIG.ps
gmt psxy -R -J -O -K -W2p $$ -Baf -BS --MAP_FRAME_TYPE=graph >> $FIG.ps
gmt psxy -R -J -O -K -W0.25p,- << EOF >>$FIG.ps
>
2.25 0
2.25 0.45
>
2.45 0
2.45 0.45
EOF
gmt pstext -R -J $stop -N -F+f12p,Times-Roman+j << EOF >> $FIG.ps
2.35 0.2 CM accept claim
2.24 0.2 RM reject claim
2.46 0.2 LM reject claim
2.62 -0.05 LT @~r@~
EOF
\rm -f $$ tail.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
