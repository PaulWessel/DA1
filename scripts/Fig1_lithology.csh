#!/bin/csh
#	$Id: Fig1_lithology.csh 479 2015-12-10 21:54:16Z pwessel $
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
if ($#argv == 2) then # Special vertical plot for cover
	set OL = 1
	set RJ = "-R0/1/0/62 -JX0.75i/-5i"
	set RJ2 = "-R0/1/0.5/62.5 -J"
	set colon = ""
	set B = "-Bx0 -By5f1 -BW"
	set start = "-O -K"
	set stop = "-O -K"
	set FIG = ${FIG}_cover
else	# Regular figure
	set OL = 0
	set RJ = "-R0/62/0/1 -JX5i/0.75i"
	set RJ2 = "-R0.5/62.5/0/1 -J"
	set colon = "-:"
	set start = "-K"
	set stop = "-O"
	set B = "-By0 -Bx5f1 -BS"
endif
cat << EOF >! t.letter
C
C
C
A
A
A
A
A
A
C
C
C
C
C
A
A
C
C
D
D
C
C
B
B
B
B
B
C
C
C
B
B
C
C
C
C
C
A
A
A
A
A
C
C
A
A
A
C
C
D
C
C
D
D
C
A
A
A
A
A
A
C
EOF
tr 'A-D' '0-3' < t.letter >! t.d

cat << EOF >! line.awk
BEGIN {last = 0}
{
	if (\$1 != last) {
		last = \$1
		printf "> \n0 %d\n1 %d\n", NR-1, NR-1
	}
}
EOF
cat << EOF >! build.awk
{
	if (\$2 == int(\$2))
	{
		if (NR > 1) printf "%s\t%s\n0\t%s\n", \$1, \$2, \$2 
		if (\$2 < 62) printf "> XX%0.2d\n0\t%s\n%s\t%s\n", \$2, \$2, \$1, \$2 
	}
	if (\$2 < 62) print \$0
}
EOF
cat << EOF >! sed.fix
s/A/-Glightblue/g
s/B/-Glightgreen/g
s/C/-Gblack/g
s/D/-Glightgray/g
EOF
sed -f sed.fix < t.letter >! sedinput.txt
awk '{printf "s/XX%0.2d/%s/g\n", NR-1, $1}' sedinput.txt > sed.fix2
gmt math -T0/62/0.1 0 0.2 NRAND 0.5 ADD = | gmt filter1d -E -Fg2 | awk '{print $2, $1}' >! path.d
awk -f build.awk path.d > pols.d
sed -f sed.fix2 < pols.d > pols.txt
gmt psxy $RJ $start -L pols.txt -Glightgray $colon -P >! $FIG.ps
gmt psxy -R -J -O -K path.d -W1p $colon >> $FIG.ps
if ($OL == 0) then
	awk -f line.awk t.d | gmt psxy -R -J -O -K -W0.25p $colon >> $FIG.ps
	awk '{printf "0.8 %g %s\n", NR-0.5, $1}' t.letter > lith.txt
	gmt pstext -R -J -O -K -N lith.txt -F+f6p,Helvetica+jCM+a0 -: >> $FIG.ps
endif
gmt psbasemap $RJ2 -O -K $B --MAP_FRAME_TYPE=graph >> $FIG.ps
echo 63 -0.1 z | gmt pstext -R -J -O -K -F+f10p,Times-Italic+jTL -N >> $FIG.ps
gmt psxy -R -J $stop -T >> $FIG.ps
\rm -f sedinput.txt box.d pols.d pols.txt path.d line.awk build.awk sed.fix sed.fix2 t.letter lith.txt t.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
