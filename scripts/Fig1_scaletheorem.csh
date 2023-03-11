#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Illustrate Fourier scale theorem
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------
# 
gmt math -T-2/2/0.01 T 2 POW 4.5 MUL NEG EXP 3 DIV = | gmt psxy -R-1.5/1.5/0/1.4 -JX2.5i/1i -P -K -W2p --MAP_FRAME_TYPE=graph -Bxa5 -Bya2 -BSw >! $FIG.ps
gmt math -T-2/2/0.01 T 3 MUL 2 POW 4.5 MUL NEG EXP = | gmt psxy -R -J -O -K -W0.5p,- >> $FIG.ps
gmt pstext -R -J -O -K -N -Dj0.1i -F+f14p,Times-Italic+j << EOF >> $FIG.ps
1.2 0 LT t
-1.5 1.25 RT g(t)
EOF
echo "a)" | gmt pstext -R -J -O -K -F+cTL+f16p+jRB -DJ0.15i -N >> $FIG.ps
gmt math -T-2/2/0.01 T 2 POW 4.5 MUL NEG EXP 3 DIV = | gmt psxy -R -J -P -O -K -W0.5p,- --MAP_FRAME_TYPE=graph -Bxa5 -Bya2 -BSw -X3i >> $FIG.ps
gmt math -T-2/2/0.01 T 3 MUL 2 POW 4.5 MUL NEG EXP = | gmt psxy -R -J -O -K -W2p  >> $FIG.ps
gmt pstext -R -J -O -K -N -Dj0.1i -F+f14p,Times-Italic+j << EOF >> $FIG.ps
1.2 0 LT f
-1.5 1.25 RT |G(f)|
EOF
echo "b)" | gmt pstext -R -J -O -K -F+cTL+f16p+jRB -DJ0.15i -N >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
