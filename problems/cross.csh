#!/bin/csh
#	$Id: Fig1_CCLag.csh 179 2015-05-13 01:56:26Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Make fake data for cross=correlation homework.
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
#-------------------------------------------------
gmt math -T-20/25/0.1 T 5 ADD PI MUL 2 MUL DUP SIN EXCH DIV T 5 SUB PI MUL 0.8 MUL DUP SIN EXCH DIV ADD 0 0.20 NRAND ADD = $$.d
grep -v NaN $$.d >! t1.d
sleep 1
gmt math -T-20/25/0.1 T 5 ADD PI MUL 2 MUL DUP SIN EXCH DIV T 5 SUB PI MUL 0.8 MUL DUP SIN EXCH DIV ADD 0 0.20 NRAND ADD = $$.d
grep -v NaN $$.d | gmt filter1d t1.d -E -Fg1 > t2.d
awk '{print $1, $2+1.5}' t1.d | gmt psxy -R-10/25/-1/3 -JX4i/1.5i -P -K -W0.5p,blue >! $FIG.ps
gmt psxy -R -J -O -K -W0.25p,- << EOF >> $FIG.ps
>
0 -0.5
0 3
>
10 -0.5
10 3
EOF
gmt pstext -R -J -O -K -F+f10p,Times-Italic+jLB << EOF >> $FIG.ps
-4 2 x(t)
EOF
echo "-7 0.5 0 0.5i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -N >> $FIG.ps
awk '{print $1+7.3, $2}' t2.d | gmt psxy -R -J -O -K -W0.5p,red >> $FIG.ps
gmt pstext -R -J -O -F+f10p,Times-Italic+jLB << EOF >> $FIG.ps
6 0.5 y(t-@~t@~)
EOF
\rm -f $$.d
#\rm -f $$.d t1.d t2.d
#-------------------------------------------------
# Post-processing
# paste t1.d t2.d | awk '{print $1, $2*10+10, $4}' > ../problems/crosscorr.txt
if ($#argv == 1) then
	gv $FIG.ps &
endif
