#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Kurtosis examples
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.7 PS_SCALE_Y 0.7
#-------------------------------------------------

gmt math -T-6/6/0.05 T ABS 4 POW 0.5 MUL NEG EXP = $$
gmt psxy -R-3/3/0/1 -JX2.25i/1i -P -K -W2p -B0 -BWS $$ -L+yb -Glightgray --MAP_FRAME_TYPE=graph >! $FIG.ps
echo '-2.8 0.3 K < 0' | gmt pstext -R -J -O -K -F+f12p,Times-Italic+jLB >> $FIG.ps
gmt math -T-20/20/0.01 T ABS 1.5 POW 0.5 MUL NEG EXP = $$
gmt psxy -R-15/15/0/1 -J -O -K -W2p -B0 -BWS $$ -L+yb -Glightgray -X2.75i --MAP_FRAME_TYPE=graph >> $FIG.ps
echo '-13 0.3 K > 0' | gmt pstext -R -J -O -F+f12p,Times-Italic+jLB >> $FIG.ps
\rm -f $$
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
