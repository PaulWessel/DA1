#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Lord Rayleigh's scatter plot
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8 
#-------------------------------------------------
cat << EOF >! rayleigh.txt
2.30143	1893.9123	C
2.29816	1893.9178	C
2.30182	1893.9205	C
2.29890	1893.9260	C
2.31017	1893.9370	A
2.30986	1893.9425	A
2.31010	1893.9562	A
2.31001	1893.9644	A
2.29889	1893.9753	C
2.29940	1893.9808	C
2.29849	1894.0247	C
2.29889	1894.0356	C
2.31024	1894.0740	A
2.31030	1894.0822	A
2.31028	1894.0877	A
EOF
gmt set FONT_LABEL 12p FONT_ANNOT_PRIMARY 10p
gmt psxy -R2.295/2.315/1893.9/1894.1 -JX4i/0.8i -Bxaf+lWeight -Bya1f1+lDate -BWS rayleigh.txt -Sc0.05i -Gblack -P --MAP_FRAME_TYPE=graph >! $FIG.ps
\rm -f rayleigh.txt
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
