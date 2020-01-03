#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Solution to COD.txt analysis
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.5 PS_SCALE_Y 0.5
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 11p FONT_LABEL 12p MAP_LABEL_OFFSET 0.05i
gmt math ../problems/COD.txt -C0 DUP MEAN SUB -C1 DUP MEAN SUB -Ca = > t.txt
set s = `gmt regress t.txt -Fp -o5`
set ds = `gmt regress t.txt -Fp -o7`
gmt psbasemap -R-300/400/-1.5/2 -JX4i/2i -P -K -Bxafg+l"@~D@~mg/L" -Byafg+l"@~D@~UV" -BWSne --FONT_LABEL=16p >! $FIG.ps
gmt psxy -R -J -O -K t.txt -Sc0.25c -Gblack >> $FIG.ps
gmt regress t.txt -T2 -Fxm | gmt psxy -R -J -O -K -W2p >> $FIG.ps
gmt regress t.txt -T2 -Fxm -Eo | gmt psxy -R -J -O -K -W0.5p,- >> $FIG.ps
gmt regress t.txt -T2 -Fxm -Er | gmt psxy -R -J -O -K -W0.5p,. >> $FIG.ps
gmt math -T-400/400/200 T $s $ds SUB MUL =  | gmt psxy -R -J -O -K -Wfaint >> $FIG.ps
gmt math -T-400/400/200 T $s $ds ADD MUL =  | gmt psxy -R -J -O -K -Wfaint >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
rm -f t.txt
if ($#argv == 1) then
	gv $FIG.ps &
endif
