#!/bin/csh
#	$Id: Fig1_LMS_geometry.csh 176 2015-05-13 01:16:39Z pwessel $
#
# This script will create the EPS file for a figure.
# Run script with arbitrary argument to invoke gv
#
# Purpose: The geometrical meaning of LMS criteria
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.7 PS_SCALE_Y 0.7
#-------------------------------------------------
if ($#argv == 2) then # Special vertical plot for cover
	set start = "-O -K"
	set stop = "-O -K"
	set FIG = ${FIG}_cover
else	# Regular figure
	set start = "-K"
	set stop = "-O"
endif

gmt psxy -R0/2.5/-0.2/1.5 -Jx1i -P $start -B0 -Bws -Glightgreen --MAP_FRAME_TYPE=graph << EOF >! $FIG.ps
0.0 0.05
1.2 1.25
1.2 1.15
0.0 -0.05
EOF
gmt psxy -R -J -O -K -N -Sc0.045i -Gred -Wfaint << EOF >> $FIG.ps
0.1 0.07
0.1 0
0.12 0.17
0.2 0.13
0.18 0.12
0.3 0.38
0.33 0.26
0.27 0.30
0.4 0.43
0.49 0.41
0.5 0.58
0.51 0.53
0.6 0.58
0.63 0.61
0.7 0.69
0.67 0.73
0.8 0.87
0.78 0.72
0.9 0.91
0.92 0.8
0.87 0.99
2.4 0.4
EOF
gmt psxy -R -J -O -K -W1p << EOF >> $FIG.ps
> main fit
0.0 0
1.2 1.2
> top fit -W0.25p
0.0 0.05
1.2 1.25
> bottom fit -W0.25p
0.0 -0.05
1.2 1.15
> LS fit -W0.25p
0.0 0.55
2.5 0.4
EOF
cat << EOF | gmt pstext -R -J $stop -N -Dj0.05i/0.05i -F+f+j >> $FIG.ps
2.5 0.55 12p,Times-Roman RM LS
1.25 1.25 12p,Times-Roman LM LMS
2.3 -0.25 12p,Times-Italic LT x
0 1.4 12p,Times-Italic RT y
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
