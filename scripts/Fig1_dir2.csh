#!/bin/csh
#	$Id: Fig1_dir2.csh 507 2016-05-23 00:54:38Z pwessel $
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
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------
cat << EOF >! dir.d
25 1
40 1
50 1
65 1
88 1
230 1
EOF
awk '{printf ">\n0 0\n%s %s\n", $1, $2}' dir.d | gmt psxy -R0/360/0/1 -JPa1.5i -P -W1p -B0 -K >! $FIG.ps
echo "0 0 35 0.5i" | gmt psxy -R -JP -O -K -Sv0.2i+e -W2p,black -Gblack >> $FIG.ps
cat << EOF >! dir.d
60 1
80 1
100 1
120 1
180 1
EOF
awk '{printf ">\n0 0\n%s %s\n", $1, $2}' dir.d | gmt psxy -R -JP -O -W1p -B0 -K -X2.25i >> $FIG.ps
echo "0 0 -5 0.5i" | gmt psxy -R -JP -O -K -Sv0.2i+e -W2p,black -Gblack >> $FIG.ps
gmt pstext -R -JP -O -N -Dj0.05i/0.05i -F+f11p,Times-Roman+a+j << EOF >> $FIG.ps
60 1 30 LM 60\232
80 1 10 LM 80\232
100 1 -10 LM 100\232
120 1 -30 LM 120\232
180 1 0 TC 180\232
EOF
\rm -f dir.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
