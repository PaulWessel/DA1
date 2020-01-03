#!/bin/csh
#	$Id: Fig1_CCLag.csh 519 2016-07-17 04:31:43Z pwessel $
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
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8
#-------------------------------------------------
gmt math -T-10/10/0.1 T 5 ADD PI MUL 2 MUL DUP SIN EXCH DIV T 5 SUB PI MUL 0.8 MUL DUP SIN EXCH DIV ADD 0 0.05 NRAND ADD = $$.d
grep -v NaN $$.d >! t1.d
gmt math -T-10/10/0.1 T 5 ADD PI MUL 2.3 MUL DUP SIN EXCH DIV T 5 SUB PI MUL 0.6 MUL DUP SIN EXCH DIV ADD 0 0.05 NRAND ADD = $$.d
grep -v NaN $$.d >! t2.d

awk '{print $1, $2+1.5}' t1.d | gmt psxy -R-10/20/-1/3 -JX4i/1.5i -P -K -W0.5p >! $FIG.ps
gmt psxy -R -J -O -K -W0.25p,- << EOF >> $FIG.ps
>
0 -0.5
0 3
>
10 -0.5
10 3
EOF
gmt pstext -R -J -O -K -F+f12p,Times-Italic+jLB << EOF >> $FIG.ps
-4 2 x(t)
EOF
echo "-7 0.5 0 0.5i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -N >> $FIG.ps
awk '{print $1+10, $2}' t2.d | gmt psxy -R -J -O -K -W0.5p >> $FIG.ps
gmt pstext -R -J -O -F+f12p,Times-Italic+jLB << EOF >> $FIG.ps
6 0.5 y(t-@~t@~)
EOF
\rm -f $$.d t1.d t2.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
