#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Show two Fourier components to data
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6 FONT_ANNOT_PRIMARY 12p
#-------------------------------------------------
gmt math -T-0.02/1.02/0.008 0 1 NRAND = | gmt filter1d -Fg0.04 >! noise.txt
gmt math T 6 180 MUL MUL 150 SUB COSD T 18 180 MUL MUL 60 SUB COSD 0.5 MUL ADD noise.txt ADD = fake.txt
# Plot fake data
gmt psxy -R0/1.015/-2.5/2.75 -JX6i/2i -P -K -W0.25p,- fake.txt -Bafg10 -BWS --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt psxy -R -J -O -K fake.txt -Gblack -Sc0.1c >> $FIG.ps
gmt math -T0/1/0.004 T  6 180 MUL MUL 150 SUB COSD = | gmt psxy -R -J -O -K -W1p >> $FIG.ps
gmt math -T0/1/0.004 T 18 180 MUL MUL 30 SUB COSD 0.5 MUL = | gmt psxy -R -J -O -K -W0.5p,- >> $FIG.ps
gmt pstext -R -J -O -Dj0.1i/0.1i -N -F+f16p,Times-Italic+j << EOF >> $FIG.ps
1.04 -2.5	TC t
0 2.6	RM d
EOF
\rm -f fake.txt noise.txt
#-------------------------------------------------
# Post-processing.

if ($#argv == 1) then
	gv $FIG.ps &
endif
