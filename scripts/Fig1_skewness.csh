#!/bin/csh
#	$Id: Fig1_skewness.csh 507 2016-05-23 00:54:38Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: skewness examples
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.7 PS_SCALE_Y 0.7
#-------------------------------------------------

gmt math -T0/36/0.05 T SQRT 3 SUB DUP MUL 0.5 MUL NEG EXP = $$
gmt psxy -R0/40/0/1 -JX2.25i/1i -P -K -W2p -L+yb -Glightgray -B0 -BWS $$ --MAP_FRAME_TYPE=graph >! $FIG.ps
echo '10 0.3 SK > 0' | gmt pstext -R -J -O -K -F+f12p,Times-Italic+jCB >> $FIG.ps
awk '{print 36-$1,$2}' $$ | gmt psxy -R -J -O -K -W2p -L+yb -Glightgray -B0 -BWS -X2.75i --MAP_FRAME_TYPE=graph  >> $FIG.ps
echo '26 0.3 SK < 0' | gmt pstext -R -J -O -F+f12p,Times-Italic+jCB >> $FIG.ps
\rm -f $$
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
