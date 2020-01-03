#!/bin/csh
#	$Id: Fig1_LMS_regress.csh 507 2016-05-23 00:54:38Z pwessel $
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
gmt set PS_SCALE_X 0.5 PS_SCALE_Y 0.5
#-------------------------------------------------

gmt psxy -R0/2.5/-0.1/2 -Jx1i -P -K -B0 -Bws -Sc0.075i -Gblack --MAP_FRAME_TYPE=graph << EOF >! $FIG.ps
0.25 1.48
0.75 1.12
1.25 0.83
1.75 1.9
2.25 0.22
EOF
echo "1.75 0.57" | gmt psxy -R -J -O -K -Sc0.075i -Gwhite -W0.25p >> $FIG.ps
gmt psxy -R -Jx -O -K -W1p << EOF >> $FIG.ps
> LMS
0.1 1.54
2.4 0.16
> -W0.5p,-
1.75 0.6
1.75 1.85
EOF
gmt pstext -R -J -O -K -Dj0.1i/0.1i -F+f+j << EOF >> $FIG.ps
0.25 1.48 12p,Times-Roman TC 1
0.75 1.12 12p,Times-Roman TC 2
1.25 0.83 12p,Times-Roman TC 3
1.75 1.9 12p,Times-Roman LM 4
2.25 0.22 12p,Times-Roman TC 5
2.25 0.4 12p,Times-Roman CB LMS
EOF

gmt psxy -R -J -O -K -B0 -Bws -Sc0.075i -Gblack --MAP_FRAME_TYPE=graph -X2.75i << EOF >> $FIG.ps
2.4 0.23
0.35 0.68
0.45 1.00
0.55 1.47
0.65 1.89
EOF
echo "0.25 0.23" | gmt psxy -R -J -O -K -Sc0.075i -Gwhite -W0.25p >> $FIG.ps
gmt psxy -R -J -O -K -W1p << EOF >> $FIG.ps
> LMS
0.1875 0
0.6875 2
> -W0.5p,-
0.30 0.23
2.35 0.23
EOF
gmt pstext -R -J -O -Dj0.1i/0.1i -N -F+f+j << EOF >> $FIG.ps
2.4 0.23 12p,Times-Roman LM 1
0.35 0.68 12p,Times-Roman LM 2
0.45 1.00 12p,Times-Roman LM 3
0.55 1.47 12p,Times-Roman LM 4
0.65 1.89 12p,Times-Roman LM 5
0.6 1.9 12p,Times-Roman RM LMS
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
