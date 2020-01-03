#!/bin/csh
#	$Id: Fig1_dotproduct.csh 536 2017-07-20 19:54:06Z pwessel $
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
gmt set PS_SCALE_X 0.9 PS_SCALE_Y 0.9
#-------------------------------------------------
gmt psxy -R0/1/0/1 -JX1.5i -P -K -W0.5p << EOF >! $FIG.ps
>
0	0
1	1
>
0.2	0
1	0.8
>
0.4	0
1	0.6
>
0.6	0
1	0.4
>

EOF
gmt psxy -R -J -O -K -Sc0.1i -Gwhite -W0.25p << EOF >> $FIG.ps
0.5 0.5
0.6 0.4
0.7 0.3
0.8 0.2
EOF
gmt psxy -R -J -O -K -Sl0.08i+tx -W0.25p -Gblack -D0/-0.0065i << EOF >> $FIG.ps
0.5 0.505
0.6 0.405
0.7 0.305
0.8 0.205
EOF
gmt psxy -R -J -O -K -S+0.05i -W0.5p << EOF >> $FIG.ps
0.55 0.45
0.65 0.35
0.75 0.25
EOF
gmt pstext -R -J -O -N -Dj0.05i/0.05i -F+f+a+j << EOF >> $FIG.ps
0 0 11p,Times-Italic 0 CT 2
0.2 0 11p,Times-Italic 0 CT 1
0.4 0 11p,Times-Italic 0 CT 4
0.6 0 11p,Times-Italic 0 CT 5
1 1 11p,Times-Italic 0 LM 1
1 0.8 11p,Times-Italic 0 LM 3
1 0.6 11p,Times-Italic 0 LM 4
1 0.4 11p,Times-Italic 0 LM 2
1 0 11p,Times-Italic 0 LT 31 (@~b@~)
-0.15 0 11p,Times-Italic 0 CT (@%5%a@%%)
1.1 0.7 11p,Times-Italic 0 LM (@%5%b@%%)
0.9 0.1 11p,Times-Italic -45 CM =
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
