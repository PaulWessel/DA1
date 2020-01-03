#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to Tuco's tire inspection
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 9p FONT_LABEL 12p MAP_LABEL_OFFSET 0.05i
gmt math -T-4/4/0.05 T DUP MUL 0.5 MUL NEG EXP 2 PI MUL SQRT DIV = $$
awk '{if ($1 <= -1.2) print $0}' $$ >! tail.d
echo "-1.2 0" >> tail.d
gmt psxy -R-3.5/3.5/0/0.5 -JX2.55i/1.25i -P -K -G200 tail.d >! $FIG.ps
gmt psbasemap -R -J -O -K -Bx1 -Bs >> $FIG.ps
gmt psxy -R -J -O -K -W2p $$ >> $FIG.ps
gmt psxy -R -J -O -K -W0.05p -N << EOF >>$FIG.ps
> 0
0 0
0 0.45
>
-1.2 0
-1.2 0.19
EOF
gmt pstext -R -J -O -K -N -F+f+j << EOF >> $FIG.ps
-1.2 -0.04 12p,Times-Italic TC -1.2
-1.2 -0.1 9p,Times-Italic TC [4 ppm]
3.5 -0.01 12p,Times-Italic LT z
-3 0.45 14p,Helvetica LT a)
EOF

gmt math -T-4/4/0.05 T DUP MUL 0.5 MUL NEG EXP 2 PI MUL SQRT DIV = $$
awk '{if ($1 >= -0.4 && $1 <= 1.2) print $0}' $$ >! tail.d
echo "1.2 0" >> tail.d
echo "-0.4 0" >> tail.d
gmt psxy -R -J -O -K -G200 tail.d -X3i >> $FIG.ps
gmt psbasemap -R -J -O -K -Bx1 -Bs >> $FIG.ps
gmt psxy -R -J -O -K -W2p $$ >> $FIG.ps
gmt psxy -R -J -O -K -W0.05p -N << EOF >>$FIG.ps
> 0
0 0
0 0.45
>
-0.4 0
-0.4 0.36
>
1.2 0
1.2 0.19
EOF
gmt pstext -R -J -O -N -F+f+j << EOF >> $FIG.ps
-0.4 -0.04 12p,Times-Italic TC -0.4
-0.4 -0.1 9p,Times-Italic TC [8 ppm]
1.2 -0.04 12p,Times-Italic TC 1.2
1.2 -0.1 9p,Times-Italic TC [16 ppm]
3.5 -0.01 12p,Times-Italic LT z
-3 0.45 14p,Helvetica LT b)
EOF
#-------------------------------------------------
# Post-processing
rm -f $$ tail.d
if ($#argv == 1) then
	gv $FIG.ps &
endif
