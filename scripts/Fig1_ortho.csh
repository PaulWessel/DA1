#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Show two Fourier harmonics are orthogonal
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.45 PS_SCALE_Y 0.45 FONT_ANNOT_PRIMARY 12p
#-------------------------------------------------
# Plot fake data
cat << EOF > t.txt
0	af	0
0.25	f
0.5	af	@~p@~
0.75	f
1	af	@~2p@~
EOF
gmt psbasemap -R0/1.015/-1.15/1.49 -JX6i/1.5i -P -K -Bxct.txt -Bya1f0.5g10 -BWS --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt math -T0/360/1 T  3 MUL COSD = | gmt psxy -R0/365.4/-1.15/1.49 -J -O -K -W2p,4_2:p >> $FIG.ps
gmt math -T0/360/1 T  COSD = | gmt psxy -R -J -O -K -W2p >> $FIG.ps
gmt math -T0/330/30 T  3 MUL COSD  = > 3.txt
gmt math -T0/330/30 T  COSD  = 1.txt
paste 1.txt 3.txt > t.txt
awk '{printf ">\n%s %s\n%s %s\n", $1, $2, $1, $4}' t.txt | gmt psxy -R -J -O -K -W1.5p,red -N >> $FIG.ps
gmt math t.txt 0 MAX = a.txt
awk '{printf ">\n%s %s\n%s %s\n", $1, $2, $1, $4}' a.txt | gmt psxy -R -J -O -K -W1.5p,blue -N >> $FIG.ps
cat << EOF > tmp
>
0	0
0	1
>
180	0
180	-1
EOF
gmt psxy -R -J -O -K -W1.5p,blue -N tmp >> $FIG.ps
gmt psxy -R -J -O -K -W1.5p,red,- -N tmp >> $FIG.ps
gmt psxy -R -J -O -K -Sc0.25c -Glightgreen -W0.25p 1.txt -N >> $FIG.ps
gmt psxy -R -J -O -K -Ss0.25c -Glightgreen -W0.25p 3.txt -N >> $FIG.ps
gmt pstext -R -J -O -Dj0.1i/0.1i -N -F+f18p,Times-Italic+j << EOF >> $FIG.ps
375 -1.1	TC @~f@~
0 1.35	RM d
EOF
\rm -f 3.txt 1.txt t.txt a.txt tmp
#-------------------------------------------------
# Post-processing.

if ($#argv == 1) then
	gv $FIG.ps &
endif
