#!/bin/csh
#
# This script will create the EPS file for Figure Fig1_Answer_blackbox
# Run script with arbitrary argument to invoke gv
#
# Purpose: Show cross-correlation in problem set 7.9
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 9p FONT_LABEL 12p MAP_LABEL_OFFSET 0.05i
gmt psxy blackbox_xcorr.txt -R-10/25/150/400 -JX6i/1.5i -P -W0.25p -K -Bxafg100+p"@~t@~ = " -Byaf  -BWSne --FONT_LABEL=16p >! $FIG.ps
gmt psxy blackbox_xcorr.txt -R -J -O -Sc0.15c -Gblack >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
