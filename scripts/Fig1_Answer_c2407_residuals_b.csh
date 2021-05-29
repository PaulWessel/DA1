#!/bin/csh
#
# This script will create the EPS file for Figure Fig1_Answer_c2407_residuals_b
# Run script with arbitrary argument to invoke gv
#
# Purpose: Residuals to c2407.txt analysis in problem set 7.8
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 9p FONT_LABEL 12p MAP_LABEL_OFFSET 0.05i
set n = `gmt info -Fi c2407.xcorr  -o2`
gmt psxy c2407.xcorr -R-0.2/20/-0.25/1.05 -JX6i/1.5i -P -K -Sc0.15c -Gblack -Bxafg100+p"@~t@~ = " -Byafg1  -BWSne --FONT_LABEL=16p >! $FIG.ps
gmt math -T0/20/10 3 $n SQRT DIV = | gmt psxy -R -J -O -W0.5p,- >> $FIG.ps
#-------------------------------------------------
# Post-processing
if ($#argv == 1) then
	gv $FIG.ps &
endif
