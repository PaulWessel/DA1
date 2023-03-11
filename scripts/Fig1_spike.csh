#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Demonstrate sum of 40 cosines equal spike
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.35 PS_SCALE_Y 0.35
#-------------------------------------------------
gmt math -T-0.5/0.5/0.001 -N3/0 T 0 MUL = sum.txt
gmt psxy -R-4/4/0/5.3 -Jx0.9i -P -K -W0.25p << EOF > $FIG.ps
0	0
0	5.3
EOF
gmt psxy -R -J -O -K -T -Y-0.1i >> $FIG.ps
foreach w (`gmt math -T1/40/1 -o0 T =`)
	gmt math -T-0.5/0.5/0.001 -N3/0 -C2 T 360 MUL $w MUL COSD = t.txt
	gmt pswiggle -R-0.5/0.5/-0.5/0.5 -JX7.2i/0.225i -O -K -Gblack -W0.25p,black t.txt -Y0.09i -Z4 >> $FIG.ps
	gmt math sum.txt t.txt ADD = tmp.txt
	mv tmp.txt sum.txt
end
set y = `gmt info -C sum.txt | cut -f6`
set s = `gmt math -Q $y 0.35 MUL =`
set n = `gmt math -Q $y 1.25 MUL =`
set scl = `gmt math -Q $y 0.5 MUL =`
gmt math sum.txt DUP MEAN SUB = t.txt
gmt pswiggle -R-0.5/0.5/-$s/$n -JX7.2i/0.9i -O -K -W0.5p,black t.txt -T0.25p -Gblack -Y0.315i -Z$scl >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
\rm -f t.txt tmp.txt sum.txt
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
