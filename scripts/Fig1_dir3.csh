#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Draw autocorrelating
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------
cat << EOF >! t.d
0 0
1.2 1.4
2.1 2.3
2.6 2.7
3 2.85
3.9 2.9
5.4 2.92
5.9 2.97
6,3 3.02
7 3.06
7.7 3.85
8.25 4.2
8.8 4.8
9.6 6.1
EOF
awk '{print NR, $1}' t.d | gmt sample1d -I0.1 >! x
awk '{print NR, $2}' t.d | gmt sample1d -I0.1 >! y
paste x y | awk '{print $2, $4}' | gmt psxy -R-0.3/10/-0.3/7.4 -JX4.5i/2.5i -P -K -W20p,lightgray >! $FIG.ps
paste x y | awk '{print $2, $4}' | gmt psxy -R -J -O -K -W1p >> $FIG.ps
gmt psxy -R -J -O -K -W0.25p,- -L << EOF >> $FIG.ps
1	1.1
2.35	1.1
2.35	2.75
1	2.75
EOF
gmt psxy -R -J -O -K -Sc0.08i -Gwhite -W0.5p t.d >> $FIG.ps
gmt pstext -R -J -O << EOF -F+f12p,Symbol+jBC >> $FIG.ps
0.8 2.1 a@-1@-
4.7 3.6 a@-2@-
8 5.4 a@-3@-
EOF
\rm -f t.d x y
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
