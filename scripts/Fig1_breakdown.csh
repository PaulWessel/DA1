#!/bin/csh
#	$Id: Fig1_breakdown.csh 507 2016-05-23 00:54:38Z pwessel $
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

gmt psxy -R0/50/-0.75/1 -JX4.75i/1.75i -P -K -Bxaf+l"Fraction of outliers"+u% -By0.5f0.25g2+l"slope" -BWS -W1p << EOF >! $FIG.ps
> LS
0 1
2	0.88
3	0.5
4	0
5	-0.45
10	-0.51
20	-0.50
30	-0.515
40	-0.499
50	-0.5
> other 1
0	1
8	0.95
13	0.68
18	0
20	-0.4
30	-0.46
40	-0.511
50	-0.5
> other 2
0	1
8	0.97
15	0.92
20	0.9
25	0.8
28	0.6
30	0
33	-0.3
40	-0.502
50	-0.5
> LMS -W2p
0 1
10	0.99
20	1.00
30	0.98
40	0.99
45	0.96
49	0.94
50	-0.5
EOF
gmt pstext -R -J -O -F+f12p,Times-Roman+j << EOF >> $FIG.ps
8 -0.4 LB LS
16 0.6 LB other
18 0.4 LB robust
20 0.2 LB methods
40 0.9 LT LMS
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
