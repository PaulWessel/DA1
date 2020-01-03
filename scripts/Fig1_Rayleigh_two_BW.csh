#!/bin/csh
#	$Id: Fig1_Rayleigh_two_BW.csh 507 2016-05-23 00:54:38Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose:Rayleigh two box-whisker bar
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8 
#-------------------------------------------------

gmt psxy -R2.295/2.315/0/1.75 -JX4i/0.75i -P -K -Bxaf -B0 -BS --MAP_FRAME_TYPE=graph << EOF >! $FIG.ps
> -Glightred
2.29869 0.35
2.300415 0.35
2.300415 0.65
2.29869 0.65
2.29869 0.25
> -Glightblue
2.30986 0.8
2.31024 0.8
2.31024 1.1
2.30986 1.1
2.30986 0.8
EOF
gmt psxy -R -J -O -K -W1p << EOF >> $FIG.ps
>
2.29869 0.35
2.300415 0.35
2.300415 0.65
2.29869 0.65
2.29869 0.35
>
2.29816 0.5
2.29869 0.5
>
2.300415 0.5
2.30182 0.5
>
2.298895 0.35
2.298895 0.65
>
2.30986 0.8
2.31024 0.8
2.31024 1.1
2.30986 1.1
2.30986 0.8
>
2.31024 0.95
2.31030 0.95
>
2.31010 0.8
2.31010 1.1
EOF
gmt psxy -R -J -O -K -Sc0.05i -Gblack -N << EOF >> $FIG.ps
2.29816 0.5
2.30182 0.5
2.30986 0.95
2.31030 0.95
EOF
gmt pstext -R -J -O -N -F+f10p,Helvetica+j<< EOF >> $FIG.ps
2.309 0.95 RM from air
2.303 0.5  LM from other sources
EOF

#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
