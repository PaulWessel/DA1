#!/bin/csh
#
# This script will create the EPS file for a figure.
# Run script with arbitrary argument to invoke gv
#
# Purpose:
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
#-------------------------------------------------
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8

gmt math -T-3/3/0.01 T DUP MUL -0.5 MUL EXP = $$
awk '{if ($1 <= -0.84) print $0}' $$ > $$.1
echo "-0.84 0" >> $$.1
echo "-8 0" >> $$.1
awk '{if ($1 >= -0.84 && $1 <= -0.26) print $0}' $$ > $$.2
echo "-0.26 0" >> $$.2
echo "-0.84 0" >> $$.2
awk '{if ($1 >= -0.26 && $1 <= 0.26) print $0}' $$ > $$.3
echo "0.26 0" >> $$.3
echo "-0.26 0" >> $$.3
awk '{if ($1 >= 0.26 && $1 <= 0.84) print $0}' $$ > $$.4
echo "0.84 0" >> $$.4
echo "0.26 0" >> $$.4
awk '{if ($1 >= 0.84) print $0}' $$ > $$.5
echo "8 0" >> $$.5
echo "0.84 0" >> $$.5
gmt psxy -R-3/3/0/1 -JX3.5i/0.75i -P -K -Glightgreen $$.1 $$.5 -B0 -Bs --MAP_FRAME_TYPE=graph --MAP_VECTOR_SHAPE=0.5>! $FIG.ps
gmt psxy -R -J -O -K -Glightorange $$.2 >> $FIG.ps
gmt psxy -R -J -O -K -Glightorange $$.4 >> $FIG.ps
gmt psxy -R -J -O -K -Glightred $$.3 >> $FIG.ps
gmt psxy -R -J -O -K -W0.25p $$.? >> $FIG.ps
gmt psxy -R -J -O -K -W1p $$ -Ba5f5 -Bs >> $FIG.ps
gmt pstext -R -J -O -K -N -Dj0.075i/0.125i -F+f+j << EOF >> $FIG.ps
-0.84 0 9p,Times-Roman TC -0.84
-0.26 0 9p,Times-Roman TC -0.26
0.26 0 9p,Times-Roman TC 0.26
0.84 0 9p,Times-Roman TC 0.84
1.2 0.75 9p,Times-Roman LM @%6%p@-j@-@%% = 0.2
EOF

gmt psxy -R0.25/6.5/0/13 -JX1.5i/0.75i -X4i -O -K -Sb1u -Glightgreen -W0.5p -B0 -Bs --MAP_FRAME_TYPE=graph << EOF >> $FIG.ps
1 10
2 11
3 10
4 5
5 12
EOF
gmt psxy -R -J -O -K -W1p  << EOF >> $FIG.ps
0.25 9.6
5.75 9.6
EOF
gmt pstext -R -J -O -N -Dj0.075i/0.075i -F+f+j << EOF >> $FIG.ps
1 0 9p,Helvetica-Bold CB 10
2 0 9p,Helvetica-Bold CB 11
3 0 9p,Helvetica-Bold CB 10
4 0 9p,Helvetica-Bold CB 5
5 0 9p,Helvetica-Bold CB 12
3 12 10p,Times-Italic CB O@-j@-
5.75 9.6 10p,Times-Italic LM E@-j@- @%4%= 9.6@%%
-0.25 5 14p,Symbol CM \336
EOF
\rm -f $$.? $$
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
