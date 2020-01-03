#!/bin/csh
#	$Id: Fig1_conv4.csh 665 2018-12-06 16:40:23Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Draw autocorrelating
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.7 PS_SCALE_Y 0.7
#-------------------------------------------------
gmt psxy -R0/3/0/1 -Jx1i -P -K -W1p -Sr -N -Glightgreen@50 << EOF >! $FIG.ps
> top strip
0.25 0.6 0.5i 0.25i
0.75 0.6 0.5i 0.25i
1.25 0.6 0.5i 0.25i
> top strip -Glightgreen
1.75 0.6 0.5i 0.25i
> bottom strip -Glightred
1.75 0.2 0.5i 0.25i
> bottom strip -Glightred@50
2.25 0.2 0.5i 0.25i
2.75 0.2 0.5i 0.25i
EOF
gmt pstext -R -J -O -Dj0.05i/0 -N -F+f12p,Times-Italic+j << EOF >> $FIG.ps
-0.1 0.6 RM d(t) =
1.4 0.2 RM p(t) =
0.25 0.6 CM d@-3@-
0.75 0.6 CM d@-2@-
1.25 0.6 CM d@-1@-
1.75 0.6 CM d@-0@-
1.75 0.4 CM \327
1.75 0.2 CM p@-0@-
2.25 0.2 CM p@-1@-
2.75 0.2 CM p@-2@-
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
