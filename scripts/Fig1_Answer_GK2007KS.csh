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

tr '*' ' ' < ../problems/GK2007.txt | awk '{if (substr($1,length($1)) == "n") print $2}' | sort -g > n.txt
tr '*' ' ' < ../problems/GK2007.txt | awk '{if (substr($1,length($1)) == "r") print $2}' | sort -g > r.txt
gmt set FONT_ANNOT_PRIMARY 16p FONT_LABEL 20p MAP_LABEL_OFFSET 0.05i

gmt psbasemap -R0/5/0/1 -JX5i/2.25i -P -Baf -Bx+l"Interval duration (Myr)" -By+l"cdf" -BWSne -K -X1.5i >! $FIG.ps
awk '{print $1, (NR-1)/144}' n.txt | gmt psxy -R -J -O -K -Ay -W1p >> $FIG.ps
awk '{print $1, (NR-1)/144}' r.txt | gmt psxy -R -J -O -K -Ay -W0.25p >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
#rm -f r.txt n.txt
if ($#argv == 1) then
	gv $FIG.ps &
endif
