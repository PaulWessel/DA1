#!/bin/csh
#	$Id: Fig1_lithology.csh 129 2015-05-06 04:58:40Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Draw lithology from Davis, Fig 4-5
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
#-------------------------------------------------
cat << EOF >! t.letter
A
B
C
A
B
B
D
C
B
B
D
D
C
D
B
D
C
A
B
D
B
D
C
A
D
C
A
B
D
C
A
D
C
A
B
D
C
A
B
D
C
C
A
D
C
A
D
C
A
B
C
A
D
C
A
B
C
A
B
C
A
B
A
B
D
C
A
A
D
C
A
D
C
D
B
D
C
C
A
D
B
D
C
A
B
B
D
C
A
A
D
C
A
B
D
D
C
C
B
D
EOF
tr 'A-D' '0-3' < t.letter >! t.d

cat << EOF >! build.awk
{
	if (\$2 == int(\$2))
	{
		if (NR > 1) printf "%s\t%s\n0\t%s\n", \$1, \$2, \$2 
		if (\$2 < 100) printf "> XX%0.2d\n0\t%s\n%s\t%s\n", \$2, \$2, \$1, \$2 
	}
	if (\$2 < 100) print \$0
}
EOF
awk '{printf "> -Z%lg\n0 %d\n1 %d\n1 %d\n0 %d\n0 %d\n", $1+0.5, NR-1, NR-1, NR, NR, NR-1}' t.d >! box.d
cat << EOF >! sed.fix
s/A/-Glightblue/g
s/B/-Glightgreen/g
s/C/-Gblack/g
s/D/-Glightgray/g
EOF
sed -f sed.fix < t.letter >! sed_input.txt
awk '{printf "s/XX%0.2d/%s/g\n", NR-1, $1}' sed_input.txt > sed.fix2
gmt math -T0/100/0.1 0 0.2 NRAND 0.5 ADD = | gmt filter1d -E -Fg2 | awk '{print $2, $1}' >! path.d
awk -f build.awk path.d > pols.d
sed -f sed.fix2 < pols.d > pols.txt
gmt psxy -R0/100/0/1 -JX5i/0.75i -K -L pols.txt -Glightgray -: -P >! $FIG.ps
awk '{if ((NR-1)%10 == 0) { printf "> \n0 %g\n%g %g\n", $2, $1, $2}}' path.d | gmt psxy -R -J -O -K -W0.25p -: >> $FIG.ps
gmt psxy -R -J -O -K path.d -W1p -: >> $FIG.ps
gmt psbasemap -R0/100/0/1 -J -O -K -By0 -Bx5f1 -BS --MAP_FRAME_TYPE=graph >> $FIG.ps
echo 102 -0.1 z | gmt pstext -R -J -O -F+f10p,Times-Italic+jTL -N >> $FIG.ps
\rm -f sed_input.txt box.d path.d pols.d pols.txt build.awk sed.fix sed.fix2 t.letter lith.txt t.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
