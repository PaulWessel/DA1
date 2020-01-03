#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Draw simple general LS example
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------

cat << EOF >! t.txt
2	1
4	4
6	3
8	4
EOF
cat << EOF >! solution.txt
-1.5000
1.6500
-0.1250
EOF
set s = `cat solution.txt`
gmt math -T1/9/0.1 $s[1] $s[2] T MUL ADD $s[3] T 2 POW MUL ADD = line.txt
# Add in solution when gmtmath is fixed for LSQFIT
#gmt math -At.txt -N4/1 -C0 1 ADD -C2 T 2 POW -Ca LSQFIT = solution.txt
gmt psxy -R0/10/0/5 -JX4i/1.25i -P -K -Sc0.1i -Baf -BWS -Gblack t.txt --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt psxy -R -J -O -K -W1p line.txt >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
\rm -f t.txt solution.txt line.txt
#-------------------------------------------------
# Post-processing


if ($#argv == 1) then
	gv $FIG.ps &
endif
