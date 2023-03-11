#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Canada gold occurrence map from PNG
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
#gmt set PS_SCALE_X 0.975 PS_SCALE_Y 0.975
#-------------------------------------------------

gmt psimage -Dx0/0+w5.5i/0 -P CanadaGold200.png>! $FIG.ps
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
