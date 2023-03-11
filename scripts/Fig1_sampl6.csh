#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Draw autocorrelating
# Needs: data/Fig_sample6.txt
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.7 PS_SCALE_Y 0.7
#-------------------------------------------------
gmt math -T-1.1/1.1/0.02 T 10 PI MUL MUL COS 0.05 MUL 1 T ABS SUB ADD = wiggle.d

awk '{print $1+1.6, $2}' wiggle.d >! t1.d
awk '{print $1+3.2, $2}' wiggle.d >! t2.d
awk '{print $1+4.8, $2}' wiggle.d >! t3.d
awk '{print $1+6.4, $2}' wiggle.d >! t4.d
# I used awk and matlab to add these together to file
# Fig_sample6.txt
gmt psxy -R0/8/0/1.1 -JX4i/0.8i -P -K wiggle.d t?.d -W0.25p,- >! $FIG.ps
gmt psxy -R -J -O -K -W1p data/Fig_sample6.txt >> $FIG.ps
echo "0 0 0 4.2i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N >> $FIG.ps
echo "1.6 0 90 1i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N >> $FIG.ps
gmt pstext -R -J -O -K -Dj0.05i/0.10i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
1.8 1 BL D(f)
1.6 0 TC 0
2.62 0 TC f@-N@-
3.212 0 TC 1/@~D@~t
8.5 0 TC f
EOF
gmt psxy -R -J -O -W0.5p -Y-0.05i << EOF >> $FIG.ps
>
1.6 0
1.6 0.06
>
2.62 0
2.62 0.06
>
3.21 0
3.21 0.06
EOF
#-------------------------------------------------
# Post-processing
\rm -f t?.d wiggle.d

if ($#argv == 1) then
	gv $FIG.ps &
endif
