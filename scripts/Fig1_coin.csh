#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: timeseries turned into histogram
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 9p FONT_LABEL 12p MAP_LABEL_OFFSET 0.05i PS_SCALE_X 0.9 PS_SCALE_Y 0.9 

foreach n (1 2 3 4 5)
	gmt math -T1/10000/1 0 1 RAND RINT 2 MUL 1 SUB 0.5 GT SUM T DIV = t$n.txt
	sleep 1
end
gmt psxy -R1/10000/0/1.25 -JX4il/1i -P  -K -Gblack << EOF >! $FIG.ps
> heads -Glightgreen@50
1	1
10000	1
10000	0.5
1	0.5
> tails -Glightred@50
1	0.5
10000	0.5
10000	0
1	0
EOF
gmt psbasemap -R -J -O -K -Baf -BWS --MAP_FRAME_TYPE=graph >> $FIG.ps
foreach n (1 2 3 4 5)
	gmt psxy -R -J -W0.5p -O t$n.txt -K >> $FIG.ps
end
gmt psxy -R -J -O -K -W0.25p,- << EOF >> $FIG.ps
1	0.5
1000	0.5
EOF
gmt pstext -R -J -O -F+f10p,Helvetica-Bold+jCM << EOF >> $FIG.ps
100 0.8 HEADS
100 0.2 TAILS
EOF
#-------------------------------------------------
# Post-processing
rm -f t[12345].txt

if ($#argv == 1) then
	gv $FIG.ps &
endif
