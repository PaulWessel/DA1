#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Draw white, red, and blue spectra
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8

#-------------------------------------------------
# White spectrum sketch
gmt math -T0/1.75/0.01 0.5 0.1 NRAND = t.tmp
gmt psxy -R0/1.75/0/1 -Jx1i -P -K t.tmp -W0.5p t.tmp -B0WS --MAP_FRAME_TYPE=graph >! $FIG.ps
echo "0.875 0 log (f)" | gmt pstext -R -J -O -K -N -D0/-0.1i -F+f10p,Helvetica+jCT >> $FIG.ps
echo "0 0.5 log (P)" | gmt pstext -R -J -O -K -N -D-0.1i/0 -F+f10p,Helvetica+jCB+a90 >> $FIG.ps
echo "0 1 white" | gmt pstext -R -J -O -K -N -D0.1i -F+f10p,Helvetica+jTL >> $FIG.ps
# Red spectrum sketch
gmt math -T0/1.75/0.01 0 0.1 NRAND 1.75 T SUB 1.75 DIV 0.8 MUL ADD = t.tmp
gmt psxy -R0/1.75/0/1 -Jx1i -O -K t.tmp -W0.5p t.tmp -B0WS -X2i --MAP_FRAME_TYPE=graph >> $FIG.ps
echo "0.875 0 log (f) "| gmt pstext -R -J -O -K -N -D0/-0.1i -F+f10p,Helvetica+jCT >> $FIG.ps
echo "0 1 red" | gmt pstext -R -J -O -K -N -D0.1i -F+f10p,Helvetica+jTL >> $FIG.ps
# Blue spectrum sketch
gmt math -T0/1.75/0.01 0 0.1 NRAND T 1.75 DIV 0.8 MUL ADD = t.tmp
gmt psxy -R0/1.75/0/1 -Jx1i -O -K t.tmp -W0.5p t.tmp -B0WS -X2i --MAP_FRAME_TYPE=graph >> $FIG.ps
echo "0.875 0 log (f)" | gmt pstext -R -J -O -K -N -D0/-0.1i -F+f10p,Helvetica+jCT >> $FIG.ps
echo "0 1 blue" | gmt pstext -R -J -O -K -N -D0.1i -F+f10p,Helvetica+jTL >> $FIG.ps
gmt psxy -R -J -O -T  >> $FIG.ps
#-------------------------------------------------
# Post-processing

rm -f t.tmp
if ($#argv == 1) then
	gv $FIG.ps &
endif
