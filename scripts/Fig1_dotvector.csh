#!/bin/csh
#	$Id: Fig1_dotvector.csh 219 2015-05-26 00:58:29Z pwessel $
#
# This script will create the EPS file for a figure.
# Run script with arbitrary argument to invoke gv
#
# Purpose:
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.9 PS_SCALE_Y 0.9
#-------------------------------------------------
gmt psxy -R0/4/0/1 -Jx1i -P -K -Sv0.15i+e -N -Gblack -W1p << EOF >! $FIG.ps
0 0 0 4i
0 0 18.43 3.1622i
EOF
gmt psxy -R -Jx -O -K -W0.5p,- << EOF >> $FIG.ps
3 0
3 1
EOF
echo 0 0 1i 0 18.4 | gmt psxy -R -J -O -K -W0.5p -Sm0.1i+e -Gblack >> $FIG.ps
echo 0 -0.1 3 -0.1 | gmt psxy -R -J -O -K -W0.25p -Sv0.1i+bt+et+s -Gblack -N >> $FIG.ps
gmt pstext -R -J -O -N -Dj0.075i/0.075i -F+f+a+j -Gwhite << EOF >> $FIG.ps
3 1 11p,Times-Bold 0 LM b
4 0 11p,Times-Bold 0 LM a
1.5 -0.1 11p,Times-Bold 0 CM \174b\174\267@%4%cos@~q@~@%%
0.988 0.156 11p,Symbol 9 LM q
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
