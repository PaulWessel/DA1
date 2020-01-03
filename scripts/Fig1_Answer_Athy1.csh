#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to Athy's law (log plot)
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 10p FONT_LABEL 12p MAP_LABEL_OFFSET 0.05i
cat << EOF > t.txt
650	38	5
1000	35	4
2050	24	2.5
2950	18	2.0
4075	14	1.5
5030	9.8	1.0
EOF
gmt math -N6/0 t.txt -o0,1,5  -C3 1 COL ADD 2 COL ADD -C4 1 COL ADD 2 COL SUB -C5 1 ADD -C LOG -C5 3 COL ADD 4 COL SUB 2 DIV -C = tlog.txt
gmt psxy -R0/6100/7/50 -JX5i/1.5il -P -K -Bxafg+l"Depth (m)" -Bya2f2g2+l"log(@~q@~)" -Sc0.075i -Gblack -W0.25p -Ey -BWSne --FONT_LABEL=16p t.txt >! $FIG.ps
set slope = `gmt regress tlog.txt -Wy -Fp -o5`
set icept = `gmt regress tlog.txt -Wy -Fp -o6`
#echo "$slope $icept"
gmt math -T0/6100/50 T $slope MUL EXP $icept EXP MUL = | gmt psxy -R -J -O -K -W1p >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
rm -f t.txt tlog.txt
if ($#argv == 1) then
	gv $FIG.ps &
endif
