#!/bin/csh
#	$Id$
#
# This script will create the EPS file for a figure.
# Run script with arbitrary argument to invoke gv
#
# Purpose: Show F distribution
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.65 PS_SCALE_Y 0.65
#-------------------------------------------------
gmt math -T0/8/0.01 T 20 12 FPDF = fdist.txt
set cr = `gmt math -Q 0.9 20 12 0.05 DIV RINT 0.05 MUL FCRIT =`
set yr = `gmt math -Q $cr 20 12 FPDF =`
echo '> right tail' >! tail.d
echo "$cr 0" >> tail.d
awk '{if ($1 >= '"$cr"') print $0}' fdist.txt >> tail.d
gmt psxy -R0/4/0/0.99 -JX4i/1i -P -K -Gwhite fdist.txt >! $FIG.ps
gmt psxy -R -J -O -K -Ggray tail.d >> $FIG.ps
gmt psxy -R -J -O -K -W2p fdist.txt -Ba10 -By0 -Bws --MAP_FRAME_TYPE=graph >> $FIG.ps
gmt psxy -R -J -O -K -W0.05p << EOF >> $FIG.ps
$cr 0
$cr $yr
EOF
gmt pstext -R -J -O -N -F+f+j << EOF >> $FIG.ps
0 -0.1 12p,Times-Italic TC 0
1.8 -0.1 12p,Times-Italic TC F
1.85 -0.18 9p,Times-Italic TL @~a@~/2,@~n@~@-1@-,@~n@~@-2@-
1.0 0.25 12p,Times-Italic CM P = 1 - @~a@~
4.05 -0.1 12p,Times-Italic LT F
EOF
\rm -f tail.d fdist.txt

#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
