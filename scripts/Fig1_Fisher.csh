#!/bin/csh
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Show a fisher distribution on a sphere
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.4 PS_SCALE_Y 0.4 PROJ_ELLIPSOID sphere
#-------------------------------------------------
set KAPPA = 40
gmt grdmath -Rg -I1 90 30 SDIST KM2DEG COSD $KAPPA MUL EXP $KAPPA MUL 4 PI MUL $KAPPA SINH MUL DIV DUP 0.05 GT MUL 0 NAN = fisher_dist.nc
gmt grdcontour fisher_dist.nc -L0.075/0.087 -C0.01 -D > cont.txt
gmt pscoast -Rg -JG30/30/6i -A1000 -P -Bafg30 -Gburlywood -K > $FIG.ps
gmt makecpt -Cjet -T0/6.5/0.5 > t.cpt
gmt psclip -R -J -O -K cont.txt >> $FIG.ps
gmt grdimage fisher_dist.nc -J -O -K -Ct.cpt -Q -t50 >> $FIG.ps
gmt psclip -C -O -K >> $FIG.ps
gmt grdcontour fisher_dist.nc -J -O -A5 -C1 -Wa2p -Wc1p -GlZ+/90/-90 >> $FIG.ps
\rm -f fisher_dist.nc cont.txt t.cpt
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
