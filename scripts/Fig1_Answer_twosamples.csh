#!/bin/csh
#	$Id$
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: t-test for two samples
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------

gmt set FONT_ANNOT_PRIMARY 9p FONT_LABEL 12p MAP_LABEL_OFFSET 0.05i
gmt math -T6/16/0.02 T 11.031 SUB 1.194 DIV DUP MUL 0.5 MUL NEG EXP 2 PI MUL SQRT 1.194 MUL DIV = $$.A
gmt math -T6/16/0.02 T 12.168 SUB 1.063 DIV DUP MUL 0.5 MUL NEG EXP 2 PI MUL SQRT 1.063 MUL DIV = $$.B
gmt math -T6/16/0.02 T 11.031 SUB 1.194 9 SQRT DIV DIV DUP MUL 0.5 MUL NEG EXP 2 PI MUL SQRT 1.194 9 SQRT DIV MUL DIV = $$.As
gmt math -T6/16/0.02 T 12.168 SUB 1.063 10 SQRT DIV DIV DUP MUL 0.5 MUL NEG EXP 2 PI MUL SQRT 1.063 10 SQRT DIV MUL DIV = $$.Bs
gmt psbasemap -R7/16/0/1.25 -JX4i/1.25i -P -K -Ba2f1 -BS >! $FIG.ps
gmt psxy -R -JX -O -K -W2p $$.[AB] >> $FIG.ps
gmt psxy -R -JX -O -W0.5p $$.[AB]s >> $FIG.ps
#-------------------------------------------------
# Post-processing
\rm -f $$.*
if ($#argv == 1) then
	gv $FIG.ps &
endif
