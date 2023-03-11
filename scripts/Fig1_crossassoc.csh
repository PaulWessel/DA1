#!/bin/csh
#
# This script will create the EPS file for a figure.
# Run script with arbitrary argument to invoke gv
#
# Purpose: Cross-associations for problem in Chapter 7
# Needs: 
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8
#-------------------------------------------------
cat << EOF > $$.a.txt
0	1
1	1
2	2
3	2
4	3
5	2
6	3
7	3
8	3
9	1
10	2
11	1
12	1
13	2
14	2
15	3
16	3
EOF
cat << EOF > $$.b.txt
1.3	3
2.3	3
3.3	1
4.3	1
5.3	2
6.3	2
7.3	3
8.3	2
9.3	3
10.3	3
11.3	3
12.3	1
13.3	1
14.3	2
15.3	2
EOF
cat << EOF > $$.t.cpt
0.5	lightblue	1.5	lightblue
1.5	black		2.5	black
2.5	lightgreen	3.5	lightgreen
EOF
awk '{printf "%g\t%g\t%g\t0.5i\t0.1i\n", 0.5, $1, $2}' $$.a.txt | gmt psxy -R-1/7/-1/19 -JX4i/2i -P -K -Sr -C$$.t.cpt -W0.5p >! $FIG.ps
awk '{printf "%g\t%g\t%g\t0.5i\t0.1i\n", 3.5, $1, $2}' $$.b.txt | gmt psxy -R -J -O -K -Sr -C$$.t.cpt -W0.5p >> $FIG.ps
gmt psxy -R -J -O -K -W2p << EOF >> $FIG.ps
-0.5 16.5
1	16.5
1.3	16.3
1.5	16.0
2	15.7
2.3	15.5
2.7	15.7
3	15.7
4	15.7
4.2	15.9
4.5	16.3
5	16.1
EOF
gmt psxy -R -J -O -K -Sr -C$$.t.cpt -W0.5p << EOF >> $FIG.ps
6 8  1 0.5i 0.1i
6 10 2 0.5i 0.1i
6 12 3 0.5i 0.1i
EOF
gmt psxy -R -J -O -K -W0.5p,- << EOF >> $FIG.ps
> top
1	12.5
3	13.8
> top
1	10.5
3	11.8
EOF
gmt pstext -R -J -O -Dj0.075i/0.075i -F+f11p,Helvetica+j -N << EOF>> $FIG.ps
2	12.6 CB ?
2	10.6 CB ?
0.5	16.5 CB A
3.5	15.5 CB B
6.6	8 LM  Shale
6.6	10 LM Coal
6.6	12 LM Limestone
EOF
\rm -f $$.*
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
