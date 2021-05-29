#!/bin/csh
#
# This script will create the EPS file for Figure Fig1_Answer_c2407_residuals_a
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
gmt math ../problems/c2407.txt -C2 SQRT = > t.txt
gmt regress t.txt -i2,1 -Fxr > residuals.txt
gmt math residuals.txt DIFF = diffs.txt
gmt psbasemap -R0/1100/-500/500 -JX6i/1.5i -P -K -Bxafg+u" km" -Byafg+u" m" -BWSne --FONT_LABEL=16p >! $FIG.ps
gmt convert t.txt diffs.txt -A | gmt psxy -R -J -O -W0.25 -i0,4 >> $FIG.ps
#-------------------------------------------------
# Post-processing
rm -f t.txt residuals.txt diffs.txt
if ($#argv == 1) then
	gv $FIG.ps &
endif
