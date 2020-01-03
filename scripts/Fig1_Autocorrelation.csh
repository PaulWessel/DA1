#!/bin/csh
#	$Id: Fig1_Autocorrelation.csh 636 2018-07-30 01:41:50Z pwessel $
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
if ($#argv == 2) then # Special vertical plot for cover
	set start = "-O -K"
	set stop = "-O -K"
	set FIG = ${FIG}_cover
	set pen1 = red
	set pen2 = blue
else	# Regular figure
	set start = "-K"
	set stop = "-O"
	set pen1 = black
	set pen2 = black
endif
gmt math -T-10/10/0.1 T 5 ADD PI MUL 2 MUL DUP SIN EXCH DIV T 5 SUB PI MUL 3 MUL DUP SIN EXCH DIV -0.7 MUL ADD 0 0.05 NRAND ADD = $$.d
grep -v NaN $$.d >! t.d
sed -n 1p t.d | awk '{printf "> tie\n%s\t%lg\n%s\t%lg\n", $1, $2, $1, $2+1.5}' >! tie.d
sed -n 50p t.d | awk '{printf "> tie\n%s\t%lg\n%s\t%lg\n", $1, $2, $1, $2+1.5}' >> tie.d
sed -n 149p t.d | awk '{printf "> tie\n%s\t%lg\n%s\t%lg\n", $1, $2, $1, $2+1.5}' >> tie.d

gmt psxy -R-10/10/-1/3 -JX1.75i/1.5i -P -W0.5p,$pen1 $start t.d >! $FIG.ps
awk '{print $1, $2+1.5}' t.d | gmt psxy -R -J -O -K -W0.5p,$pen2 >> $FIG.ps
gmt psxy -R -J -O -K -W0.25p,- tie.d >> $FIG.ps
gmt pstext -R -J -O -K -F+f12p,Times-Italic+j << EOF >> $FIG.ps
-4 0.5 LB y(t)
-4 2 LB y(t)
EOF
echo "8 0.75 0 0.35i" | gmt psxy -R -J -O -K -Sv0.25i+e+a45 -Gblack -W5p -N >> $FIG.ps
sed -n 1p t.d | awk '{printf "> tie\n%s\t%lg\n%s\t%lg\n", $1+5, $2, $1, $2+1.5}' >! tie.d
sed -n 50p t.d | awk '{printf "> tie\n%s\t%lg\n%s\t%lg\n", $1+5, $2, $1, $2+1.5}' >> tie.d
sed -n 149p t.d | awk '{printf "> tie\n%s\t%lg\n%s\t%lg\n", $1+5, $2, $1, $2+1.5}' >> tie.d
awk '{print $1, $2+1.5}' t.d | gmt psxy -R-10/15/-1/3 -JX2.1875i/1.5i -O -K -W0.5p,$pen2 -X1.85i >> $FIG.ps
awk '{print $1+5, $2}' t.d | gmt psxy -R -J -O -K -W0.5p,$pen1 >> $FIG.ps
gmt psxy -R -J -O -K -W0.25p,- tie.d >> $FIG.ps
gmt pstext -R -J $stop -F+f12p,Times-Italic+jLB << EOF >> $FIG.ps
0.5 0.5 y(t-@~t@~)
-3 2 y(t)
EOF
\rm -f tie.d t.d $$.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
