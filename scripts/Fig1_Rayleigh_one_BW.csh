#!/bin/csh
#	$Id: Fig1_Rayleigh_one_BW.csh 507 2016-05-23 00:54:38Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose:Rayleigh one box-whisker bar
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8 
#-------------------------------------------------

gmt psxy -R2.295/2.315/0/1 -JX4i/0.6i -P -K -Glightgreen -Bxaf -By0 -BS << EOF >! $FIG.ps
2.29889 0.35
2.31010 0.35
2.31010 0.65
2.29889 0.65
2.29889 0.35
EOF
gmt psxy -R -J -O -K -W1p << EOF >> $FIG.ps
>
2.29889 0.35
2.31010 0.35
2.31010 0.65
2.29889 0.65
2.29889 0.35
>
2.29816 0.5
2.29889 0.5
>
2.30143 0.35
2.30143 0.65
EOF
gmt psxy -R -J -O -Sc0.075i -Gblack -N << EOF >> $FIG.ps
2.29816 0.5
2.31010 0.5
EOF

#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
