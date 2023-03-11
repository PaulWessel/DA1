#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: continuous pdf
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8
#-------------------------------------------------

gmt math -T0/10/0.05 T 3 SUB DUP MUL 0.5 MUL NEG EXP T 5.5 SUB DUP MUL 0.5 MUL NEG EXP 0.7 MUL ADD 1.5 MUL = $$
gmt math -T3.5/5/0.05 T 3 SUB DUP MUL 0.5 MUL NEG EXP T 5.5 SUB DUP MUL 0.5 MUL NEG EXP 0.7 MUL ADD 1.5 MUL = $$.sub
echo 5 0 >> $$.sub
echo 3.5 0 >> $$.sub
gmt psxy -R0/10/0/2 -JX2.5i/1i -P -K -Glightgray  $$ >! $FIG.ps
gmt psxy -R -J -O -K -G50 $$.sub -W0.25p -B0 -BWS --MAP_FRAME_TYPE=graph >> $FIG.ps
gmt psxy -R -J -O -K -W2p $$ >> $FIG.ps
gmt pstext -R -J -O -N -F+f12p,Times-Italic+j << EOF >> $FIG.ps
-0.2 2 RB p
10 -0.125 LT x
3.5 -0.125 CT a-@~D@~
5 -0.125 CT a+@~D@~
EOF
\rm -f $$ $$.*
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
