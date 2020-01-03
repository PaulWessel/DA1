#!/bin/csh
#
# 
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.5 PS_SCALE_Y 0.5
#-------------------------------------------------
# Note: Added duplicate max value per data set for psxy -Ay to end at 1 
cat << EOF | sort -g > A.txt	# Permeability at site A
18.76
18.76
13.24
1.83
3
5
10.12
8.40
8.60
18.18
15.04
9.62
13.22
EOF
cat << EOF | sort -g > B.txt	# Permeability at site B
15.90
5.80
1.31
17.50
17.50
9.22
7.20
1.92
13.46
2.61
8.51
EOF
gmt set FONT_ANNOT_PRIMARY 16p FONT_LABEL 20p MAP_LABEL_OFFSET 0.05i

gmt psbasemap -R0/20/0/1 -JX5i/2.25i -P -Baf -Bx+l"Permeability" -By+l"cdf" -BWSne -K -X1.5i >! $FIG.ps
awk '{print $1, (NR-1)/12}' A.txt | gmt psxy -R -J -O -K -Ay -W1p >> $FIG.ps
awk '{print $1, (NR-1)/10}' B.txt | gmt psxy -R -J -O -K -Ay -W1p,4_2:0 >> $FIG.ps
echo 7.5 0.25 7.5 0.5 | gmt psxy -R -J -O -K -Sv0.1i+s+b+e -Gblack -W0.5p >> $FIG.ps
gmt pstext -R -J -O -K -F+f13p+j -Dj0.05i/0.05i << EOF >> $FIG.ps
11 0.7 LB B
11 0.583 LB A
7.5 0.375 LM D
15 0.15 LM D = 0.25
EOF
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
rm -f A.txt B.txt
if ($#argv == 1) then
	gv $FIG.ps &
endif
