#!/bin/csh
#
# Testing gmtregress on the data in Draper & Smith [1998]
# Applied Regression Analysis, 3rd Ed, Wiley.

set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.9 PS_SCALE_Y 0.9
cat << EOF >! draper.txt
# Table 1.1 in Draper & Smith, Applied Regression Analysis
35.3	10.98
29.7	11.13
30.8	12.51
58.8	8.40
61.4	9.27
71.3	8.73
74.4	6.36
76.7	8.50
70.7	7.82
57.5	9.14
46.4	8.24
28.9	12.19
28.1	11.88
39.1	9.57
46.8	10.94
48.5	9.58
59.3	10.09
70.0	8.11
70.0	6.83
74.5	8.88
72.1	7.68
58.1	8.47
44.6	8.86
33.4	10.36
28.6	11.08
EOF
set txt = `gmt regress -Ey -N2 -Fxm -T25/80/55 draper.txt | awk '{if (NR == 1) printf "25 6 y = %.4f %.4f x\n", $17, $15}'`
# Plot basic LS fit but also show 68%, 95% & 99% confidence band
gmt regress -Ey -N2 -Fxmc -T25/80/1 -C99 draper.txt | gmt psxy -R25/80/6/13 -JX3i/2i -P -K -L+d -Glightgreen > $FIG.ps
gmt regress -Ey -N2 -Fxmc -T25/80/1 -C95 draper.txt | gmt psxy -R -J -O -K -L+d -Glightorange >> $FIG.ps
gmt regress -Ey -N2 -Fxmc -T25/80/1 -C68 draper.txt | gmt psxy -R -J -O -K -L+d -Glightred -W2p >> $FIG.ps
gmt regress -Ey -N2 -Fxym draper.txt | awk '{printf "> error\n%s %s\n%s %s\n", $1, $2, $1, $3}' | gmt psxy -R -J -O -K -W0.25p >> $FIG.ps
gmt psxy -R -J -O -K draper.txt -Sc0.1c -Gblue -Baf -BWSne >> $FIG.ps
echo "$txt" | gmt pstext -R -J -O -K -F+jLB+f10p,Times-Italic -Dj0.1i >> $FIG.ps
gmt pslegend -DjTR+w1.1i+jRT+o0.1i/0.1i -R -J -O -F+p1p --FONT_ANNOT_PRIMARY=8p << EOF >> $FIG.ps
S 0.05i s 0.125i lightgreen  - 0.15i 99% Confidence
S 0.05i s 0.125i lightorange - 0.15i 95% Confidence
S 0.05i s 0.125i lightred    - 0.15i 68% Confidence
EOF
#-------------------------------------------------
# Post-processing
\rm -f draper.txt

if ($#argv == 1) then
	gv $FIG.ps &
endif
