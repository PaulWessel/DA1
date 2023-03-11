#!/bin/csh
#
# This script will create the EPS file for a figure.
# Run script with arbitrary argument to invoke gv
#
# Purpose: Show F distribution
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.75 PS_SCALE_Y 0.75
#-------------------------------------------------
gmt math -T0/8/0.01 T 20 12 FPDF = f_dist.d
echo '> left tail' >! tail.d
awk '{if ($1 <= 0.44) print $0}' f_dist.d >> tail.d
echo "0.44 0" >> tail.d
echo '> right tail' >> tail.d
echo "2.54 0" >> tail.d
awk '{if ($1 >= 2.54) print $0}' f_dist.d >> tail.d
gmt psxy -R0/4/0/0.99 -JX4i/1.25i -P -K -Glightgreen f_dist.d >! $FIG.ps
gmt psxy -R -J -O -K -Glightred tail.d >> $FIG.ps
gmt psxy -R -J -O -K -W2p f_dist.d -Ba1 -By0 -Bws --MAP_FRAME_TYPE=graph >> $FIG.ps
gmt psxy -R -J -O -K -W0.05p << EOF >> $FIG.ps
>
0.44 0.0
0.44 0.462384741555
>
2.54 0
2.54 0.0690385903076
EOF
gmt pstext -R -J -O -N -F+f+j << EOF >> $FIG.ps
0.1 -0.1 12p,Times-Italic TC F
0.15 -0.18 9p,Times-Italic TL 1-@~a@~/2,@~n@~@-1@-,@~n@~@-2@-
2.3 -0.1 12p,Times-Italic TC F
2.35 -0.18 9p,Times-Italic TL @~a@~/2,@~n@~@-1@-,@~n@~@-2@-
1.0 0.25 12p,Times-Italic CM P = 1 - @~a@~
4.05 -0.1 12p,Times-Italic LT F
EOF
\rm -f tail.d f_dist.d

#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
