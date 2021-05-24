#!/bin/csh
#	$Id: Fig1_earthfilter.csh 533 2017-07-08 23:59:21Z pwessel $
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
gmt math -T0/1/0.002 T 0.3 SUB 80 MUL DUP SIN EXCH DIV 0 0.05 NRAND ADD = | grep -v NaN >! pulse.d
gmt math -T0/1/0.002 T 0.2 SUB 80 MUL DUP SIN EXCH DIV T 0.7 SUB 30 MUL DUP SIN EXCH DIV 0.8 MUL ADD 0 0.1 NRAND ADD = | grep -v NaN >! response.d
gmt filter1d -Fg0.1 response.d >! smooth.d
gmt psxy -R0/1/-0.5/1 -JX1.5i/0.75i -P -K -W0.5p -Bx0 -By0g2 -BWS pulse.d --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt psxy -R0/6/-0.25/0.5 -Jx1i -O -K -Sv0.1i+e -Gblack -Wthicker,black -N << EOF >> $FIG.ps
1.6 0 0 0.2i
3.0 0 0 0.2i
EOF
gmt pstext -R0/1/-0.5/1 -JX1i/0.75i -O -K -X1.9i -Glightgray -W1p -M -F+f+a+j << EOF >> $FIG.ps
> 0.5 0 12p 0 Times-Roman CM 12p 0.9i c
"Earth Filter"
EOF
gmt psxy -R -JX1.5i/0.75i -O -W0.25p smooth.d -Bx0 -By0g2 -BWS -X1.4i --MAP_FRAME_TYPE=graph >> $FIG.ps
\rm -f response.d pulse.d smooth.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
