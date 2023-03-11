#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Draw truncation
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------
gmt math -T0/1/0.01 T PI MUL 3.7 MUL SIN 0 0.2 NRAND ADD 0.9 MUL = | gmt filter1d -Fg0.1 -E >! t.d
set range = `gmt info -i1 -C t.d -I0.05`
set y = `gmt math -Q $range[2] 0.2 ADD =`

gmt psxy -R0/1/$range[1]/$range[2] -JX2.5i/1i -P -K -W0.5p t.d >! $FIG.ps
cat << EOF | gmt psxy -R -J -O -K -W1p >> $FIG.ps
0 0
0.15 0
0.15 $range[2]
0.85 $range[2]
0.85 0
0.95 0
EOF
echo "0 0 0 2.5i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N >> $FIG.ps
gmt pstext -R -J -O -K -Dj0.05i/0.05i -N -F+f12p,Times-Italic+jTC << EOF >> $FIG.ps
1 0 t
EOF
echo "0.15 $y 0.85 $y" | gmt psxy -R -J -O -K -Sv0.1i+s+et+bt -Gblack -W0.5p,black -N >> $FIG.ps
gmt pstext -R -J -O -K -N -F+f12p,Times-Italic+jCM -Gwhite << EOF >> $FIG.ps
0.5 $y T
EOF

echo "0 0 0 2.5i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N -X2.75i >> $FIG.ps
awk '{if ($1 >= 0.15 && $1 <= 0.85) print $0}' t.d >! trunc1.d
echo "0.15 $y 0.85 $y" | gmt psxy -R -J -O -K -Sv0.1i+s+et+bt -Gblack -W0.5p,black -N >> $FIG.ps
# trunc1.d will also be used in Fig_trunc2.csh
gmt psxy -R -J -O -K -W1p trunc1.d >> $FIG.ps
gmt pstext -R -J -O -K -Dj0.05i/0.05i -N -F+f12p,Times-Italic+jTC << EOF >> $FIG.ps
1 0 t
EOF
gmt pstext -R -J -O -N -F+f12p,Times-Italic+jCM -Gwhite << EOF >> $FIG.ps
0.5 $y T
EOF
\rm -f t.d trunc1.d
#-----------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
