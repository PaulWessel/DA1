#!/bin/csh
#	$Id: Fig1_KS.csh 636 2018-07-30 01:41:50Z pwessel $
#
# This script will create the EPS file for a figure.
# Run script with arbitrary argument to invoke gv
#
# Purpose: KS statistics
# Needs: data/salinities.txt
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.7 PS_SCALE_Y 0.7
#-------------------------------------------------
if ($#argv == 2) then # Special vertical plot for cover
	set start = "-O -K"
	set stop = "-O -K"
	set W=4
	set fill = lightred
	set FIG = ${FIG}_cover
else	# Regular figure
	set W=6
	set start = "-K"
	set stop = "-O"
	set fill = lightgray
endif
set n = `cat data/salinities.txt | wc -l`
cat << EOF >! $$.awk
BEGIN { sum = 0.0}
{
	print \$1, sum/$n
	sum += 1.0
	print \$1, sum/$n
}
EOF
awk '{printf "%d\n", int($1)}' data/salinities.txt | sort -n | awk -f $$.awk >! $$.stairs
gmt math -T20/80/1 T 49.59 SUB 9.27 DIV 2 SQRT DIV ERF 1 ADD 0.5 MUL = $$.cum
gmt psbasemap -R20/80/0/1 -JX${W}i/1.75i -P $start -Bx10f5+l"salinity (ppm)" -By0.2 -BWSne >! $FIG.ps
if ($#argv == 2) then
	cat $$.cum >! $$.green
	echo 80 0 >> $$.green
	gmt psxy -R -J -O $$.green -Glightgreen -K >> $FIG.ps
endif
cat $$.stairs >! $$.band
gmt convert -I $$.cum >> $$.band
gmt psxy -R -J -O -K -G$fill $$.band >> $FIG.ps
gmt psxy -R -J -O -K -W0.5p $$.stairs >> $FIG.ps
gmt psxy -R -J -O -K -W2p $$.cum >> $FIG.ps
gmt psxy -R -J -O -K -W0.25p << EOF>> $FIG.ps
53 0
53 1
EOF
gmt pstext -R -J $stop -Dj0.075i/0.075i -F+f+j << EOF>> $FIG.ps
53 0.72 12p,Times-Italic RM D @%4%= 0.06@%%
53 0 12p,Times-Roman LB 53 ppm
EOF
\rm -f $$.*
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
