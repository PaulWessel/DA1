#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Show reading of Student-t table
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.75 PS_SCALE_Y 0.75
#-------------------------------------------------

gmt math -T-5/5/0.05 T 3 TPDF = $$
set tl = `gmt math -Q 0.1 3 TCRIT 0.05 DIV RINT 0.05 MUL =`
set y = `gmt math -Q $tl 3 TPDF =`
gmt psxy -R-4.5/4.5/0/0.5 -JX2.5i/1.25i $$ -Gwhite -P -K >! $FIG.ps
echo '> left tail' >! tail.d
awk '{if ($1 <= '"$tl"') print $0}' $$ >> tail.d
echo "$tl 0" >> tail.d
gmt psxy -R -J -O -K -Ggray tail.d >> $FIG.ps
gmt psxy -R -J -O -K -W1p $$ -B5 -Bs --MAP_FRAME_TYPE=graph >> $FIG.ps
gmt psxy -R -J -O -K -W0.05p -N << EOF >>$FIG.ps
> 0
0 0
0 0.45
>
$tl 0
$tl $y
EOF
gmt pstext -R -J -O -K -N -F+f14p,Times-Italic+j << EOF >> $FIG.ps
5.61 0.3 CM P = 1 - @~a@~
EOF
gmt pstext -R -J -O -K -N -F+f12p,Times-Italic+j << EOF >> $FIG.ps
$tl -0.04 TC -t@-@~a,n@~@-
3.5 -0.04 LT t
EOF
set tl = `gmt math -Q 0.05 3 TCRIT 0.05 DIV RINT 0.05 MUL =`
set tr = `gmt math -Q 0.95 3 TCRIT 0.05 DIV RINT 0.05 MUL =`
set y = `gmt math -Q $tl 3 TPDF =`
gmt psxy -R -J $$ -Gwhite -O -K -X3i >> $FIG.ps
echo '> left tail' >! tail.d
awk '{if ($1 <= '"$tl"') print $0}' $$ >> tail.d
echo "$tl 0" >> tail.d
echo '> right tail' >> tail.d
awk '{if ($1 >= '"$tr"') print $0}' $$ >> tail.d
echo "$tr 0" >> tail.d
gmt psxy -R -J -O -K -Ggray tail.d >> $FIG.ps
gmt psxy -R -J -O -K -W1p $$ -B5 -Bs --MAP_FRAME_TYPE=graph >> $FIG.ps
gmt psxy -R -J -O -K -W0.05p -N << EOF >>$FIG.ps
> 0
0 0
0 0.45
>
$tl 0
$tl $y
>
$tr 0
$tr $y
EOF
gmt pstext -R -J -O -K -N -F+f12p,Times-Italic+j << EOF >> $FIG.ps
$tl -0.04 TC -t@-@~a/2,n@~@-
$tr -0.04 TC -t@-@~a/2,n@~@-
3.5 -0.04 LT t
EOF
gmt psxy -R -J -O -K -Sv0.15i+e -Gblack -W1p -N -X-3i << EOF >> $FIG.ps
5.61	0.25	-15	1.4i	
5.61	0.25	-165	1.4i
EOF
gmt psxy -R -J -O -T >> $FIG.ps

\rm -f $$ tail.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
