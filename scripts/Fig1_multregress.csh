#!/bin/csh
#	$Id: Fig1_LMS.csh 170 2015-05-12 05:51:14Z pwessel $
#
# This script will create the EPS file for a figure.
# Run script with arbitrary argument to invoke gv
#
# Purpose:
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.7 PS_SCALE_Y 0.7
#-------------------------------------------------
cat << EOF > xyz.txt
-2 2 -1
-1 2 0
0 2 3
1 2 2
2 2 4
-2 1 1
-1 1 -1
0 1 2
1 1 2
2 1 3
-2 0 0
-1 0 0
0 0 1
1 0 2
2 0 2
-2 -1 -2
-1 -1 0
0 -1 1
1 -1 1
2 -1 2
-2 -2 -1
-1 -2 -1
0 -2 0
1 -2 -1
2 -1 1
EOF
awk '{print $1, $2, $3, 0.8 + 19*$1/25 + 0.5*$2}' xyz.txt > zp.txt

cat << EOF | awk '{print $1, $2, 0.8 + 19*$1/25 + 0.5*$2}' > plane.txt
-2.25	-2.25
2.25	-2.25
2.25	2.25
-2.25	2.25
EOF
awk '{if ($4 > $3) printf ">\n%g %g %g\n%g %g %g\n", $1, $2, $3, $1, $2, $4}' zp.txt | gmt psxyz -R-2.5/2.5/-2.5/2.5/-2/5 -JX3i -JZ1.25i -P -K -B0 -BWSZ --MAP_FRAME_TYPE=graph -p155/20 -W0.25p,- >! $FIG.ps
awk '{if ($4 > $3) print $1, $2, $3}' zp.txt | gmt psxyz -R -J -JZ -O -K -p -Su0.05i -W0.25p -Gred >> $FIG.ps
gmt psxyz -R -J -JZ -O -K -p -Glightgreen@50 plane.txt >> $FIG.ps
# Draw grid on plane
gmt math -T-2/2/1 -o0 0 = g.txt
awk '{printf "> x=%g\n%g\t%g\t%g\n%g\t%g\t%g\n", $1, $1, -2, 0.8 + 19*$1/25 -1, $1, 2, 0.8 + 19*$1/25 + 1}' g.txt > grid.txt
awk '{printf "> y=%g\n%g\t%g\t%g\n%g\t%g\t%g\n", $1, -2, $1, 0.8 -38/25 + 0.5*$1, 2, $1, 0.8 + 38/25 + 0.5*$1}' g.txt >> grid.txt
gmt psxyz -R -J -JZ -O -K -p -W0.25p,. grid.txt >> $FIG.ps
awk '{print $1, $2, $4}' zp.txt | gmt psxyz -R -J -JZ -O -K -p -Gblack -Sc0.05c >> $FIG.ps
awk '{if ($4 <= $3) printf ">\n%g %g %g\n%g %g %g\n", $1, $2, $3, $1, $2, $4}' zp.txt | gmt psxyz -R -J -JZ -O -K -p -W0.25p >> $FIG.ps
awk '{if ($4 <= $3) print $1, $2, $3}' zp.txt | gmt psxyz -R -J -JZ -O -K -p -Su0.05i -W0.25p -Gred >> $FIG.ps
echo -2. -2. -2 -2. -2. 5 | gmt psxyz -R -J -JZ -O -Sv0.15i+e+s -Wthicker,black -p -N >> $FIG.ps
#-------------------------------------------------
# Post-processing
rm -f xyz.txt zp.txt plane.txt g.txt grid.txt

if ($#argv == 1) then
	gv $FIG.ps &
endif
