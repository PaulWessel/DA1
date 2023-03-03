#!/bin/csh
#	$Id: Fig1_astronomy.csh 507 2016-05-23 00:54:38Z pwessel $
#
# This script will create the EPS file for a figure.
# Run script with arbitrary argument to invoke gv
#
# Purpose: Show LMS fit
# Needs: data/hertzsprung-russell.txt
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.75 PS_SCALE_Y 0.75
#-------------------------------------------------

gmt psbasemap -R3.3/5.2/3/7 -JX-3i/1.75i -P -K -Baf -Bx+l"Log (T)" -By+l"Log (I)" -BWS >! $FIG.ps
grep -v '^#' data/hertzsprung-russell.txt | awk '{ if ($2 > 3.6) print $2, $3}' | gmt psxy -R -J -O -K -Sc0.045i -Gblue >> $FIG.ps
grep -v '^#' data/hertzsprung-russell.txt | awk '{ if ($2 < 3.6) print $2, $3}' | gmt psxy -R -J -O -K -Sc0.045i -Gred >> $FIG.ps
gmt pstext -R -J -O -K -N -F+f10p,Times-Roman+jLB << EOF >> $FIG.ps
5.1 4.9 L@-2@-
3.88 3.1 LMS
EOF
gmt psxy -R -J -O -W0.5p << EOF >> $FIG.ps
> LMS
3.3 0.5654
5.2 7.9716
> L2 -W0.5p,-
3.3 5.4303
5.2 4.6532
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
