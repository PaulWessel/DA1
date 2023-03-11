#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Show critical correlation as function of n
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8
#-------------------------------------------------

gmt set MAP_LABEL_OFFSET 4p
gmt math -T1/100/1 0.975 T TCRIT DUP 2 POW T ADD 2 SUB SQRT DIV ABS = t.txt
set y = `gmt math -Q 0.975 5 TCRIT DUP 2 POW 5 ADD 2 SUB SQRT DIV ABS =`
gmt psxy -R1/103/0/1.25 -JX4i/1i -W2p -P t.txt -Bxaf+l"Number of rolls" -Byaf+l"@%6%|r@-c@-|@%%" -BWS --MAP_FRAME_TYPE=graph -K >! $FIG.ps
echo 5 $y | gmt psxy -R -J -O -K -Sc0.15c -Gwhite -Wfaint >> $FIG.ps
gmt psxy -R -J -O -W0.25p,- << EOF >> $FIG.ps
5	0
5	$y
1	$y
EOF
#-------------------------------------------------
# Post-processing
\rm -f t.txt

if ($#argv == 1) then
	gv $FIG.ps &
endif
