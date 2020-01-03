#!/bin/csh
#	$Id: Fig1_grav_model.csh 507 2016-05-23 00:54:38Z pwessel $
#
# This script will create the EPS file for a figure.
# Run script with arbitrary argument to invoke gv
#
# Purpose: Plot fake gravity model and data
# Needs: data/gobs.txt data/gmod.txt
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.75 PS_SCALE_Y 0.75
#-------------------------------------------------
gmt psxy -R-75/75/-14/2 -JX4.5i/2i -P -Baf -Bx+l"Distance (km)" -By+l"mGal" -BWNse data/gobs.txt -Sc0.035i -Gblack -Y3i -K > $FIG.ps
gmt math -T-75/75/1 T T MUL 7.75e-4 MUL T 2.2 40 DIV MUL ADD 11.3 SUB = | gmt psxy -R -J -O -K -W0.5p,- >> $FIG.ps
gmt psxy -R -J -O -K -W0.25p data/gmod.txt >> $FIG.ps
gmt psxy -R-75/75/0/10 -JX4.5i/-0.3i -O -K -Y-0.3i -Bx0 -By5+l"z" -BwE -Glightgray -W0.25p << EOF >> $FIG.ps
15 2.5
17.5 3.5
16.75	6.2
15 8
13	6.5
12 3.7
EOF
awk 'BEGIN {for (i = 0; i < 360; i++) print 15+2.5*cos(0.01745329*i), 5+2.5*sin(0.01745329*i)}' /dev/null | gmt psxy -R -J -O -W0.5p >> $FIG.ps

#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
