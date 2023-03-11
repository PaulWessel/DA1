#!/bin/csh
#
# Creates 3-D plot of misfit function E(m1, m2) as well
# as two cross-sections
#
# Purpose:
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set FONT_LABEL 12p,Times-Italic PS_SCALE_X 0.75 PS_SCALE_Y 0.75
#-------------------------------------------------

#gmt grdmath -R0/10/0/10 -I0.05 X 6 SUB 1.25 MUL Y 5 SUB 0.75 MUL R2 5 MUL 35 ADD = error.grd
gmt grdmath -R0/10/0/10 -I0.2 X 6 SUB 1.25 MUL Y 5 SUB 0.75 MUL R2 5 MUL 35 ADD = error.grd
gmt grdgradient -A225 -Nt1 error.grd -Gerror_i.grd
#gmt makecpt -Cgray -T0/100/10 -N > t.cpt
gmt makecpt -Chot -T0/100/10 -N > t.cpt
echo "100 - 10000 -" >> t.cpt	# Truncate cpt at 100
cat << EOF | gmt psxyz -R0/10/0/10/0/100 -JX2i -JZ1.5i -p120/30 -W0.25p,- -P -K -Bx5+l"m@-1@-" -By5+l"m@-2@-" -Bz25+l"E(m@-1@-, m@-2@-)" -BWSZ >! $FIG.ps
> to x
6	10	0
6	0	0
> to y
10	5	0
0	5	0
EOF
cat << EOF | gmt psxyz -R -J -JZ -p -W0.5p -O -K >> $FIG.ps
> vertical line
6	5	0
6	5	35
EOF
gmt grdcontour -R -JX -JZ -p error.grd -C5 -A25 -L0/100 -O -K -GlZ-/BL >> $FIG.ps
gmt grdview -R -JX -JZ -p -Qs -W0.5p -Ct.cpt error.grd -Ierror_i.grd -O -K >> $FIG.ps

gmt math -T0/10/0.1 T 6 SUB 1.25 MUL 2 POW 5 MUL 35 ADD = t.d
gmt  psxy -R0/10/0/100 -JX2i/0.8i -O -K -X3i -W1p t.d -Bxaf -Bx+l"m@-1@-" -By25+l"E(m@-1@-)" -BWS --MAP_LABEL_OFFSET=0  >> $FIG.ps
cat << EOF | gmt psxy -R -JX -O -K -W0.25p,- >> $FIG.ps
>
6	0
6	35
>
0	35
10	35
EOF
gmt math -T0/10/0.1 T 5 SUB 0.75 MUL 2 POW 5 MUL 35 ADD = t.d
gmt psxy -R0/10/0/100 -JX2i/0.8i -O -K -Y1.25i -W1p t.d -Bxaf -Bx+l"m@-2@-" -By25+l"E(m@-2@-)" -BWS --MAP_LABEL_OFFSET=0 >> $FIG.ps
cat << EOF | gmt psxy -R -JX -O -W0.25p,- >> $FIG.ps
>
5	0
5	35
>
0	35
10	35
EOF

#-------------------------------------------------
# Post-processing

rm -f error.grd error_i.grd t.d t.cpt
if ($#argv == 1) then
	gv $FIG.ps &
endif
