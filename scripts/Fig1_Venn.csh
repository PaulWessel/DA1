#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Draw Venn diagram
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
#-------------------------------------------------
gmt set PS_SCALE_X 0.9 PS_SCALE_Y 0.9 
gmt psxy -R0/3/-0.02/1.02 -Jx1i -P -Sc1i -Gred -K << EOF >! $FIG.ps
> -Gred@75
1 0.5
> -Gblue@75
1.7 0.5
EOF
gmt psxy -R -J -O -Sc1i -W1p -K << EOF >> $FIG.ps
1 0.5
1.7 0.5
EOF
gmt pstext -R -J -O -F+f+j << EOF >> $FIG.ps
0.4 0.7 12p,Helvetica-Bold RB Oil
2.3 0.7 12p,Helvetica-Bold LB Gas
1 0.5 8p,Helvetica-Bold RM 0.18
1.7 0.5 8p,Helvetica-Bold LM 0.24
1.35 0.5 8p,Helvetica-Bold CM 0.12
EOF

#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
