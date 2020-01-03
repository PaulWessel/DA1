#!/bin/csh
#	$Id$
#
# This script will create the EPS file for a figure.
# Run script with arbitrary argument to invoke gv
#
# Purpose:
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8
#-------------------------------------------------

awk '{print $2}' ../problems/GK2007.txt | gmt math STDIN SUM = times.txt
awk '{printf "%s 0 %s 1\n", $1, $1}' times.txt | gmt psxy -R40/80/0/1 -JX6i/0.35i -P -K -Baf -BS -W0.25p -Sv0.1i+s --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt pstext -R -J -O -N -Dj0.1i/0.05i -F+f11p,Times-Roman+jTL << EOF >> $FIG.ps
80 -0.1 Ma
EOF
#-------------------------------------------------
# Post-processing
rm -f times.txt
if ($#argv == 1) then
	gv $FIG.ps &
endif
