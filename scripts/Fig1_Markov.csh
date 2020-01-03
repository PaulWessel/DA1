#!/bin/csh
#	$Id: Fig1_Markov.csh 519 2016-07-17 04:31:43Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Draw Markov diagram
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.65 PS_SCALE_Y 0.65
#-------------------------------------------------
if ($#argv == 2) then # Special vertical plot for cover
	set start = "-O -K"
	set stop = "-O -K"
	set FIG = ${FIG}_cover
else	# Regular figure
	set start = "-K"
	set stop = "-O"
endif
gmt psxy -R-1/1/-1/1 -JX2i -P $start -Sv0.1i+e -Gblack -X1.5i << EOF >! $FIG.ps
0.04 1 -90 1.8i
-0.04 -1 90 1.8i
0.1 -0.9 45 1.05i
1 -0.1 225 1.1i
-0.1 -0.9 135 1.05i
-1 -0.1 315 1.1i
EOF
gmt psxy -R -J -O -Sc0.3i -W1p -Glightgray -K -N << EOF >> $FIG.ps
>  -Glightgray
-1 0
>  -Gblack
0 -1
>  -Glightgreen
1 0
>  -Gpink
0 1
EOF
gmt pstext -R -J -O -K -N -F+f+a+j << EOF >> $FIG.ps
-1 0 16p,Helvetica-Bold 0 CM D
1 0 16p,Helvetica-Bold 0 CM B
0 1 16p,Helvetica-Bold 0 CM A
-0.8 0 12p,Helvetica-Bold 0 TL 11%
0.8 0 12p,Helvetica-Bold 0 TR 7%
0.2 -0.9 12p,Helvetica-Bold 0 LT 29%
-0.2 -0.9 12p,Helvetica-Bold 0 RT 60%
-0.1 0.65 12p,Helvetica-Bold 90 RB 19%
0.1 -0.65 12p,Helvetica-Bold 90 LT 23%
0 1.2 12p,Helvetica-Bold 0 CB A@~\256@~A (77%)
1.2 0 12p,Helvetica-Bold 0 LM B@~\256@~B (71%)
-1.2 0 12p,Helvetica-Bold 0 RM D@~\256@~D (40%)
0 -1.2 12p,Helvetica-Bold 0 CT C@~\256@~C (63%)
EOF
gmt pstext -R -J $stop -N -F+f+a+j << EOF >> $FIG.ps
0 -1 16p,Helvetica-Bold,white 0 CM C
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
