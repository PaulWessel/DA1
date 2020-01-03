#!/bin/csh
#	$Id: Fig1_correlations.csh 507 2016-05-23 00:54:38Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Various types of correlations
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.7 PS_SCALE_Y 0.7
#-------------------------------------------------

gmt psxy -R0/1/0/1 -JX1.25i/1.25i -P -K -B0 -BWS -Sc0.05i -Gblack --MAP_FRAME_TYPE=graph << EOF >! $FIG.ps
0.9 0.15
0.72 0.19
0.79 0.22
0.7 0.27
0.6 0.33
0.53 0.44
0.59 0.5
0.4 0.57
0.37 0.74
0.22 0.73
0.08 0.9
EOF
gmt pstext -R -J -O -K -N -F+f+j << EOF >> $FIG.ps
-0.05 0.95 10p,Helvetica-Bold RT d)
0.05 0.05 10p,Times-Italic LB r = -0.9
EOF
gmt psxy -R -J -O -K -B0 -BWS -Sc0.05i -Gblack -X1.65i --MAP_FRAME_TYPE=graph << EOF >> $FIG.ps
0.1 0.6
0.22 0.6
0.35 0.6
0.41 0.6
0.57 0.6
0.7 0.6
0.73 0.6
0.9 0.6
0.96 0.6
EOF
gmt pstext -R -J -O -K -N -F+f+j << EOF >> $FIG.ps
-0.05 0.95 10p,Helvetica-Bold RT e)
0.05 0.05 10p,Times-Italic LB r undefined
EOF
gmt psxy -R -J -O -K -B0 -BWS -Sc0.05i -Gblack -X1.65i --MAP_FRAME_TYPE=graph << EOF >> $FIG.ps
    0.8000    0.5000
    0.7524    0.6622
    0.6246    0.7729
    0.4573    0.7969
    0.3035    0.7267
    0.2122    0.5845
    0.2122    0.4155
    0.3035    0.2733
    0.4573    0.2031
    0.6246    0.2271
    0.7524    0.3378
    0.8000    0.5000
EOF
gmt pstext -R -J -O -K -N -F+f+j << EOF >> $FIG.ps
-0.05 0.95 10p,Helvetica-Bold RT f)
0.05 0.05 10p,Times-Italic LB r = 0
EOF
gmt psxy -R -J -O -K -B0 -BWS -Sc0.05i -Gblack -X-3.3i -Y1.4i --MAP_FRAME_TYPE=graph << EOF >> $FIG.ps
0.1 0.15
0.22 0.19
0.21 0.28
0.3 0.27
0.4 0.33
0.5 0.44
0.45 0.5
0.6 0.67
0.63 0.74
0.8 0.79
0.95 0.9
EOF
gmt pstext -R -J -O -K -N -F+f+j << EOF >> $FIG.ps
-0.05 0.95 10p,Helvetica-Bold RT a)
0.05 0.05 10p,Times-Italic LB r = 0.95
EOF
gmt psxy -R -J -O -K -B0 -BWS -Sc0.05i -Gblack -X1.65i --MAP_FRAME_TYPE=graph << EOF >> $FIG.ps
0.15 0.3
0.3 0.8
0.36 0.82
0.45 0.15
0.46 0.4
0.7 0.71
0.77 0.88
0.92 0.98
0.98 0.7
EOF
gmt pstext -R -J -O -K -N -F+f+j << EOF >> $FIG.ps
-0.05 0.95 10p,Helvetica-Bold RT b)
0.05 0.05 10p,Times-Italic LB r = 0.54
EOF
gmt psxy -R -J -O -K -B0 -BWS -Sc0.05i -Gblack -X1.65i --MAP_FRAME_TYPE=graph << EOF >> $FIG.ps
0.16 0.8
0.25 0.17
0.4 0.3
0.5 0.9
0.6 0.3
0.8 0.1
0.82 0.3
0.9 0.95
EOF
gmt pstext -R -J -O -N -F+f+j << EOF >> $FIG.ps
-0.05 0.95 10p,Helvetica-Bold RT c)
0.05 0.05 10p,Times-Italic LB r = 0.16
EOF

#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
