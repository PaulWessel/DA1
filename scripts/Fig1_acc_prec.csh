#!/bin/csh
#	$Id: Fig1_acc_prec.csh 507 2016-05-23 00:54:38Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Plot accuracy versus precision
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.9 PS_SCALE_Y 0.9 
gmt psxy -R0/4/-0.1/1.5 -JX4i/1.5i -P -K -S -W0.5p << EOF >! $FIG.ps
> -Glightblue
1 0.75 0.75i c
3 0.75 0.75i c
> -Glightgreen
1 0.75 0.5i c
3 0.75 0.5i c
> -Glightred
1 0.75 0.25i c
3 0.75 0.25i c
> -Gblack
1 0.75 1i x
3 0.75 1i x
EOF
gmt psxy -R -J -O -K -Sc0.04i -Gblack << EOF >> $FIG.ps
1.25 1.05
1.21 1.01
1.31 0.97
1.27 1.01
1.2 1.1
1.28 0.96
1.19 1.1
1.22 0.99
1.24 1.05
1.27 1.1
1.29 1.11
1.30 0.95
1.31 1.04
#
3.25 1.25
3.1 1.17
2.75 0.5
2.9 0.9
3.1 0.9
2.9 0.7
2.75 1.18
3.2 0.86
3.25 0.45
3.1 0.65
2.8 0.35
3.1 0.4
2.6 0.72
2.65 1
3.2 0.31
EOF
gmt pstext -R -J -O -F+f9p,Helvetica-Bold+jMC << EOF >> $FIG.ps
1 0.2 PRECISION
3 0.2 ACCURACY
EOF

# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
