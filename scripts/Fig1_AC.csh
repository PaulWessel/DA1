#!/bin/csh
#	$Id: Fig1_AC.csh 522 2016-07-19 22:00:35Z pwessel $
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
gmt set PS_SCALE_X 0.7 PS_SCALE_Y 0.7
#-------------------------------------------------
gmt math -T0.1/10/0.1 T PI MUL 0.5 MUL DUP SIN EXCH DIV 0 0.05 NRAND ADD DUP UPPER DIV = $$.d
awk '{if (NR == 1) {print $1, $2+0.15} else {print $0}}' $$.d > t.d2
gmt math t.d2 DUP UPPER DIV = $$.d3
grep -v NaN $$.d3 >! t.d
set y = `head -1 t.d | cut -f2`
gmt psxy -R0.1/10/-0.5/1.2 -JX4i/1.5i -P -K t.d -W1p  >! $FIG.ps
echo "2.5 $y 180 0.6i" | gmt psxy -R -JX -O -K -Sv0.1i+e -Gblack -Wthicker -N >> $FIG.ps
echo 0.1 $y | gmt psxy -R -JX -O -K -Sc0.08i -Gblack -W0.25p -N >> $FIG.ps
gmt pstext -R -J -O -K -N -F+f+j << EOF >> $FIG.ps
2.75 $y 15p,Times-Roman LM variance @%6%s@+2@+@-y@-@%%
10 -0.6 13p,Times-Italic LT @~t@~
EOF
gmt psbasemap -R0/9.9/-0.5/1.2 -J -O -Bx100 -By2g2 -BWS --MAP_FRAME_TYPE=graph --FONT_ANNOT_PRIMARY=13p >> $FIG.ps
\rm -f $$.* t.d t.d2
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
