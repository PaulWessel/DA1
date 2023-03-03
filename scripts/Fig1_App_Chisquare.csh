#!/bin/csh
#	$Id$
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
gmt set PS_SCALE_X 0.65 PS_SCALE_Y 0.65
#-------------------------------------------------
gmt math -T0/15/0.05 T 4 CHI2PDF = >! $$
set cl = `gmt math -Q 0.1 4 0.05 DIV RINT 0.05 MUL CHI2CRIT =`
set yl = `gmt math -Q $cl 4 CHI2PDF =`
set cr = `gmt math -Q 0.9 4 0.05 DIV RINT 0.05 MUL CHI2CRIT =`
set yr = `gmt math -Q $cr 4 CHI2PDF =`
echo '> left tail' >! tail.d
awk '{if ($1 <= '"$cl"') print $0}' $$ >> tail.d
echo "$cl 0" >> tail.d
# Left tail
gmt psxy -R0/15/0/0.25 -JX3i/0.9i -P -K -Gwhite $$ >! $FIG.ps
gmt psxy -R -J -O -K -Ggray tail.d >> $FIG.ps
gmt psxy -R -J -O -K -W2p $$ -Ba20 -By0 -Bws --MAP_FRAME_TYPE=graph >> $FIG.ps
gmt psxy -R -J -O -K -W0.05p << EOF >> $FIG.ps
>
$cl 0.0
$cl $yl
EOF
gmt pstext -R0/4/0/0.9 -Jx1i -O -K -N -F+f+j << EOF >> $FIG.ps
0.225 -0.12 12p,Times-Italic TC @~c@~@+2@+
0.25 -0.25 9p,Times-Italic TL 1-@~a@~
0.75 0.20 12p,Times-Italic CM P = 1 - @~a@~
2.95 -0.12 12p,Times-Italic TL @~c@~@+2@+
1.5 0.90 12p,Times-Roman CT Left tail
EOF
# Right tail
echo '> right tail' >! tail.d
echo "$cr 0" >> tail.d
awk '{if ($1 >= '"$cr"') print $0}' $$ >> tail.d
gmt psxy -R0/15/0/0.25 -JX3i/0.9i -O -K -Gwhite $$ -X3.5i >> $FIG.ps
gmt psxy -R -J -O -K -Ggray tail.d >> $FIG.ps
gmt psxy -R -J -O -K -W2p $$ -Ba20 -By0 -Bws --MAP_FRAME_TYPE=graph >> $FIG.ps
gmt psxy -R -J -O -K -W0.05p << EOF >> $FIG.ps
$cr 0.0
$cr $yr
EOF
gmt pstext -R0/4/0/0.9 -Jx1i -O -N -F+f+j << EOF >> $FIG.ps
1.575 -0.12 12p,Times-Italic TC @~c@~@+2@+
1.60 -0.25 9p,Times-Italic TL @~a@~
0.75 0.20 12p,Times-Italic CM P = 1 - @~a@~
2.95 -0.12 12p,Times-Italic TL @~c@~@+2@+
1.5 0.90 12p,Times-Roman CT Right tail
EOF

\rm -f tail.d $$

#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
