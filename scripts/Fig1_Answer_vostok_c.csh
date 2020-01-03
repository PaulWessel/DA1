#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to Vostok core dft problem
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 11p FONT_LABEL 13p MAP_LABEL_OFFSET 0.05i
#set s2 = 7.4027
#set sj = `gmt info ../problems/vostok_dft.txt -e~Inf -C -o7`
#set m = `gmt info -Fi ../problems/vostok_dft.txt -o2`
#set glim = `gmt math -Q 1 0.01 LOG $m LOG SUB $m 1 SUB DIV EXP SUB 2 MUL $s2 MUL =`
#echo $s2 $sj $m $glim
gmt psxy ../problems/vostok_dft.txt -e~Inf -i2+s1e-5,3 -R0/4.5/0/6 -JX6i/1.75i -P -K -Wfaint -Bxa+l"Period (10@+5@+ yr)" -Byag10+l"power" -BWS --MAP_FRAME_TYPE=graph >! $FIG.ps
gmt psxy -R -J -O -K ../problems/vostok_dft.txt -e~Inf -i2+s1e-5,3 -Sc0.1c -Gblack >> $FIG.ps
#gmt psxy -R -J -O -K -W0.5p,red << EOF >> $FIG.ps
#0	$glim
#4.5	$glim
#EOF
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
