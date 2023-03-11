#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Draw autocorrelating
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6 FONT_ANNOT_PRIMARY 16p
#-------------------------------------------------
gmt math -T0/25/0.25 85 20 NRAND = | awk '{print 1, $2}' > dir.d
gmt psrose -R0/1/0/360 -P -S1in -W0.5p -Bx1g1 -By90g90 -K dir.d -L >! $FIG.ps
echo "a)" | gmt pstext -R0/1/0/1 -JX1i -O -K -F+cTL+f20p -N -D-0.2i/0.95i >> $FIG.ps
gmt psrose -R0/1/0/360 -A7.5r -Glightgray -O -K -S1in -W0.25p -Bx1g1 -By90g90 -X3i dir.d -L >> $FIG.ps
echo "b)" | gmt pstext -R0/1/0/1 -JX1i -O -F+cTL+f20p -N -D-0.2i/0.95i >> $FIG.ps
cat << EOF >! t.sed
s/WEST/270/g
s/EAST/90/g
s/SOUTH/180/g
s/NORTH/0/g
EOF
sed -f t.sed < $FIG.ps > t.ps
mv -f t.ps $FIG.ps
\rm -f dir.d t.sed
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
