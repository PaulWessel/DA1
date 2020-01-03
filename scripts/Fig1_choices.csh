#!/bin/csh
#	$Id: Fig1_choices.csh 682 2019-01-12 07:15:25Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Tree diagram for choices
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.7 PS_SCALE_Y 0.7 

gmt psxy -R0/6/0/2 -JX6i/0.8i -P -K -W1p << EOF >! $FIG.ps
> TOP 1-0-3
1 1
3 2
5 1
> TOP 2-0
3	1
3	2
> LEFT BRANCH a-1-c
0.4 0
1.0 1
1.2 0
> LEFT BRANCH b-1-d
0.8 0
1.0 1
1.6 0
> MID BRANCH e-2-g
2.4 0
3.0 1
3.2 0
> MID BRANCH f-2-h
2.8 0
3.0 1
3.6 0
> RIGHT BRANCH i-3-k
4.4 0
5.0 1
5.2 0
> RIGHT BRANCH j-3-l
4.8 0
5.0 1
5.6 0
EOF
gmt pstext -R -J -O -K -N -Gwhite -W0.5p -C0.05i+tO -F+f+j << EOF >> $FIG.ps
3 2 12p,Helvetica-Bold CM ?
EOF
gmt pstext -R -J -O -K -N -Gwhite -W0.5p -C0.05i+tO -F+f10p,Helvetica-Bold+jCM << EOF >> $FIG.ps
1 1 1
3 1 2
5 1 3
EOF
gmt pstext -R -J -O -N -Gwhite -W0.5p -C0.05i+tO -F+f8p,Helvetica-Bold+jTC << EOF >> $FIG.ps
0.4 0 a
0.8 0 b
1.2 0 c
1.6 0 d
2.4 0 e
2.8 0 f
3.2 0 g
3.6 0 h
4.4 0 i
4.8 0 j
5.2 0 k
5.6 0 l
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
