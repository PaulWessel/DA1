#!/bin/csh
#	$Id: Fig1_nyquist2.csh 665 2018-12-06 16:40:23Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Draw Nyquist diagram
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
	set W=4
	set fill = lightred
	set FIG = ${FIG}_cover
else	# Regular figure
	set W=6
	set start = "-K"
	set stop = "-O"
	set fill = lightgray
endif
cat << EOF | gmt sample1d -I0.1 | gmt filter1d -Fg2 -E > actual.d
0 1
1 1
2 0.9
2.5 0.6
3 0.6
4 0.6
5 0.3
6 0.3
7 0.15
8 0.07
9 0
EOF
awk '{if ($1 < 4) print $1, 0}' actual.d >! folded.d
tail -r actual.d  | awk '{if ($1 >= 6.5) print 13-$1, $2}' >> folded.d
paste folded.d actual.d | awk '{if ($1 <= 6.5) print $1, $2+$4}' >! total.d
gmt psxy -R0/9/0/1.05 -JX4i/1i -P $start -W1p -L+yb -Glightred total.d >! $FIG.ps
gmt psxy -R -J -O -W1p -K actual.d -L+yb -Glightgreen >> $FIG.ps
gmt psxy -R -J -O -W0.5p,- -K folded.d -L+yb -Glightorange >> $FIG.ps
gmt psxy -R -J -O -W0.5p,- -K folded.d >> $FIG.ps
gmt psxy -R -J -O -W0.5p -K total.d >> $FIG.ps
gmt psxy -R -J -O -Sv0.1i+e -Gblack -Wthicker,black -N -K << EOF >> $FIG.ps
0 0 0 4.2i
0 0 90 1.2i
EOF
gmt pstext -R -J -O -K -N -F+f+j << EOF >> $FIG.ps
0.2 1.1 10p,Times-Roman LB |@%6%D(f)@%%|
6.5 -0.1 10p,Times-Italic TC f@-N@-
3.5 -0.1 10p,Times-Italic TC f@-I@-
9 -0.1 10p,Times-Italic TC f
4 0.1 10p,Times-Roman LB aliased
6.4 0.5 10p,Times-Roman RB total
7.75 0.15 10p,Times-Roman CB actual
EOF
gmt psxy -R -J $stop  -W0.5p -Y-0.05i << EOF >> $FIG.ps
>
6.5 0
6.5 1.05
>
3.5 0
3.5 1.05
EOF
\rm -f actual.d folded.d total.d

#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
