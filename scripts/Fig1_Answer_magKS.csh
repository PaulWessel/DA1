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

cat << EOF | sort -g > A.txt	# Magnetization at site 1
68.9
68.9
41.1
-6.1
25.6
17.0
18.0
65.9
50.0
23.1
41.1
EOF
cat << EOF | sort -g > B.txt	# Magnetization at site 2
54.5
4.0
-18.5
62.5
62.5
21.0
6.0
-15.5
42.2
-13.0
15.0
EOF
gmt set FONT_ANNOT_PRIMARY 16p FONT_LABEL 20p MAP_LABEL_OFFSET 0.05i

gmt psbasemap -R-20/70/0/1 -JX5i/2.25i -P -Baf -Bx+l"Magnetization" -By+l"cdf" -BWSne -K -X1.5i >! $FIG.ps
awk '{print $1, (NR-1)/10}' A.txt | gmt psxy -R -J -O -K -Ay -W1p >> $FIG.ps
awk '{print $1, (NR-1)/10}' B.txt | gmt psxy -R -J -O -K -Ay -W1p,4_2:0 >> $FIG.ps
echo 16 0.1 16 0.6 | gmt psxy -R -J -O -K -Sv0.1i+s+b+e -Gblack -W0.5p >> $FIG.ps
gmt pstext -R -J -O -K -F+f12p+j -Dj0.05i/0.05i << EOF >> $FIG.ps
-13.0 0.3 LB Site 2
-6.1 0.1 LB Site 1
16 0.35 RM D = 0.5
EOF
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
rm -f A.txt B.txt
if ($#argv == 1) then
	gv $FIG.ps &
endif
