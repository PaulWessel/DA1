#!/bin/csh
#
# Data from Table 7 in Rousseeuw and Leroy, 1987.
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.35 PS_SCALE_Y 0.35
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 16p FONT_LABEL 20p MAP_LABEL_OFFSET 0.05i

gmt regress -Ey -Nw -i0:1l ../problems/bb_weights.txt > model.txt
gmt regress -Ey -Nw -i0:1l ../problems/bb_weights.txt -Fxmc -T-2/6/0.1 > rls_line.txt
grep -v '^>' model.txt > A.txt
grep -v '^#' ../problems/bb_weights.txt > B.txt
awk '{if ($7 == 0) printf "%dp\n", NR}' A.txt > sed.txt
echo 0 gray > t.cpt
echo 1 white >> t.cpt
gmt psbasemap -R0.01/1e6/0.1/1e5 -JX6il -P -Ba1pf3 -Bx+l"Log@-10@- body weight (kg)" -By+l"Log@-10@- brain weight (g)" -BWSne -K -X1.5i -Y4i >! $FIG.ps
sed -n -f sed.txt B.txt | gmt pstext -R0.01/1e6/0.1/1e5 -JX6il -O -K -F+f16p+jRM -Dj0.15i >> $FIG.ps
gmt psxy -R-2/6/-1/5 -JX6i -O -K -L+d+p0.25p,- -G235 rls_line.txt >> $FIG.ps
gmt psxy -R -J -O -K rls_line.txt -W3p >> $FIG.ps
gmt psxy -R -J -O -K -Sc0.16i -Ct.cpt -Wfaint -i0,1,6 model.txt >> $FIG.ps
awk '{print $1, $2, NR}' A.txt | gmt pstext -R -J -O -K -F+f8p+jCM  -B0 >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
rm -f rls_line.txt model.txt A.txt B.txt sed.txt t.cpt
if ($#argv == 1) then
	gv $FIG.ps &
endif
