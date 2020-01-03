#!/bin/csh
#
# This script will create the EPS file for a figure.
# Run script with arbitrary argument to invoke gv
#
# Purpose:
# Needs: data/Euler_stamps.png
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
#-------------------------------------------------
gmt psimage data/Euler_stamps.png -Dx0/0+jLB+w4i -P >! $FIG.ps

#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
