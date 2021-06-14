#!/bin/csh
#
# This script will create the EPS file for a figure.
# Run script with arbitrary argument to invoke gv
#
# Purpose:
#
set name = $0
set FIG = $name:r
set ps = $FIG.ps
#-------------------------------------------------
cp -f gmt.conf.DA2 gmt.conf
gmt set PS_SCALE_X 0.5 PS_SCALE_Y 0.5
#-------------------------------------------------
cat << EOF > t.cpt
0	white	2	white
2	gray	4	gray
EOF
gmt psxy -R-1/20/0/10 -Jx0.25i -P -K -Ss0.3536i -N -Ct.cpt -W0.25p << EOF >! $ps
#Row
0 5.5 1
1 5.5 3
2 5.5 1
3 5.5 3
4 5.5 1
5 5.5 3
6 5.5 1
7 5.5 3
# Column
9 2 1
9 3 3
9 4 1
9 5 3
9 6 1
9 7 3
9 8 1
9 9 3
#RowA
15 8.5 1
16 8.5 1
17 8.5 1
18 8.5 1
# ColumnA
20 7 1
20 8 1
20 9 1
20 10 1
#RowB
15 2.5 3
16 2.5 3
17 2.5 3
18 2.5 3
# ColumnB
20 4 3
20 3 3
20 2 3
20 1 3
EOF
gmt pstext -R -J -O -K -N -F+f24p,Times-Bold+jCM << EOF >> $ps
8 5.5 \267
12 5.5 =
17 5.5 +
19 8.5 \267
19 2.5 \267
EOF
#-------------------------------------------------
gmt psxy -R -J -O -T >> $ps
# Post-processing
rm -f tmp.nc tmp t.cpt

if ($#argv == 1) then
	gv $ps &
endif
