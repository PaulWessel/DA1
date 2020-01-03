#!/bin/csh
#	$Id: Fig1_Rayleigh_bars.csh 507 2016-05-23 00:54:38Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Show Rayleigh 2 bar graphs
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8 
#-------------------------------------------------

gmt psxy -R0/3/0/1.75 -JX4i/0.8i -K -Bxaf -By0 -BWS -P -W0.25p --MAP_FRAME_TYPE=graph << EOF >! $FIG.ps
> -Glightblue from air
0	0.2
2.310137	0.2
2.310137	0.6
0	0.6
0	0.2
> -Glightred from compounds
0	0.8
2.299498	0.8
2.299498	1.2
0	1.2
0	1
EOF
gmt pstext -R -J -O -N -F+f10p,Helvetica+jLM << EOF >> $FIG.ps
2.4 0.4  from air
2.4 1 from other sources
EOF

#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
