#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Line segment for digitizing
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
#-------------------------------------------------
gmt set PS_SCALE_X 0.9 PS_SCALE_Y 0.9

gmt pscoast -R26/29/-71/-69 -JM6i -Dh -W1 -M > $$
gmt psxy -R26/28:30/-70:10/-69:52 -JX5id/1.5id $$ -W0.25p -P -K >! $FIG.ps
gmt psxy -R -JX $$ -Sc0.03i -Gblack -O >> $FIG.ps
\rm -f $$

#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
