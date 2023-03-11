#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Show search for median.
#
set name = $0
set FIG = $name:r
#------------------------------------------------- 
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------
cat << EOF > medians.txt
1	-2936.5
2	-4162.02
3	-4721.55
4	-4911.98
5	-4949.13
6	-4955.31
7	-4956
EOF
gmt psxy -R0/8/-5500/-2500 -JX4i/1.25i -Sc0.2c -Gblack -Bxa1f+l"Iterations" -Byaf+lMedian -BWSne -P -K medians.txt >! $FIG.ps
gmt psxy -R -J -O -K -W0.25p,- << EOF >> $FIG.ps
0	-4956	
8	-4956
EOF
echo "8 -2500 n = 11313 " | gmt pstext -R -J -O -K -F+f12p+jTR -Dj0.1i >> $FIG.ps
gmt psxy -R -J -W1p -O -K medians.txt >> $FIG.ps

#-------------------------------------------------
# Post-processing
gmt psxy -R -J -O -T >> $FIG.ps
rm -f medians.txt
if ($#argv == 1) then
	gv $FIG.ps &
endif
