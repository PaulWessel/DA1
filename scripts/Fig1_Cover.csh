#!/bin/csh
#	$Id: Fig1_Cover.csh 636 2018-07-30 01:41:50Z pwessel $
#
# This script will create the EPS file for a figure.
# Run script with arbitrary argument to invoke gv
#
# Purpose: Make DA1 Cover image
#
# Requires: Fig1_KS_cover.csh  Fig1_nyquist1.csh  Fig1_lithology.csh  Fig1_LMS_geometry.csh
#	Fig1_type1_error.csh  Fig1_Markov.csh   Fig1_sincos.csh  Fig1_Autocorrelation.csh
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.9 PS_SCALE_Y 0.9
#-------------------------------------------------
#
gmt psbasemap -R0/6/0/6 -Jx1i -P -K -B0 -B+gbeige >! $FIG.ps
# Place KS figure
echo "V 300 400 T 0.6 0.6 scale" >> $FIG.ps
csh Fig1_KS.csh x x
cat Fig1_KS_cover.ps >> $FIG.ps
echo "U" >> $FIG.ps
# Place Nyquist figure
echo "V 3400 400 T 0.72 0.85 scale" >> $FIG.ps
csh Fig1_nyquist1.csh x x
cat Fig1_nyquist1_cover.ps >> $FIG.ps
echo "U" >> $FIG.ps
# Place Lithology figure
echo "V 300 2400 T 0.75 0.77 scale" >> $FIG.ps
csh Fig1_lithology.csh x x
cat Fig1_lithology_cover.ps >> $FIG.ps
echo "U" >> $FIG.ps
# Place Autocorrelation figure
echo "V 1000 2000 T 0.725 0.8 scale" >> $FIG.ps
csh Fig1_Autocorrelation.csh x x
cat Fig1_Autocorrelation_cover.ps >> $FIG.ps
echo "U" >> $FIG.ps
# Place LMS figure
echo "V 4750 2000 T 0.7 0.7 scale" >> $FIG.ps
csh Fig1_LMS_geometry.csh x x
cat Fig1_LMS_geometry_cover.ps >> $FIG.ps
echo "U" >> $FIG.ps
# Place sincos figure
echo "V 900 3400 T 0.65 0.65 scale" >> $FIG.ps
csh Fig1_sincos.csh x x
cat Fig1_sincos_cover.ps >> $FIG.ps
echo "U" >> $FIG.ps
# Place Type 1 error figure
echo "V 1000 5900 T 0.8 0.8 scale" >> $FIG.ps
csh Fig1_type1_error.csh x x
cat Fig1_type1_error_cover.ps >> $FIG.ps
echo "U" >> $FIG.ps
# Place Markov figure
echo "V 3280 4600 T 0.7 0.7 scale" >> $FIG.ps
csh Fig1_Markov.csh x x
cat Fig1_Markov_cover.ps >> $FIG.ps
echo "U" >> $FIG.ps
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing
rm -f Fig1_*_cover.ps

if ($#argv == 1) then
	gv $FIG.ps &
endif
