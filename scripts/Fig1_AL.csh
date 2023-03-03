#!/bin/csh
#	$Id: Fig1_AL1.csh 507 2016-05-23 00:54:38Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Draw autocorrelating
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.55 PS_SCALE_Y 0.55
#-------------------------------------------------
set dx1 = 3.5i
set dx2 = -3.5i
########### 1. d(t) and D(f)
## 1a. d(t)
gmt math -T-5.01/5.01/0.02 T 0.72 ADD PI MUL DUP SIN EXCH DIV 0.85 MUL T 0.72 SUB PI MUL DUP SIN EXCH DIV ADD 0.1 SUB = ft.d
gmt sample1d -I1 -Fl ft.d | awk '{if ($2 > 0) {print $1, 0, 90, $2} else {print $1, 0, -90, -$2}}' >! f.d

gmt psxy -R-6/6/-0.4/0.9 -JX2.5i/0.8i -P -K ft.d -W0.5p -X1.25i -Y8.6i >! $FIG.ps
echo "a)" | gmt pstext -R -J -O -K -F+cTL+f12p >> $FIG.ps
gmt pstext -R -J -O -K -Dj0.05i/0.05i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
6 -0.15 TC t
1 1.05 LB d(t)
EOF
gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -N -Wthicker,black << EOF >> $FIG.ps
-6 -.1 0 2.5i
0 -0.1 90 0.9i
EOF

gmt math -T-1.1/1.1/0.02 T 10 PI MUL MUL COS 0.05 MUL 1 T ABS SUB ADD = wiggle.d

## 1b. D(f)
gmt psxy -R-1.5/1.5/0/1.1 -JX2.5i/0.7i -O -K wiggle.d -X3.5i -Y0.225i >> $FIG.ps
echo "-1.5 0 0 2.5i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -N -Wthicker,black >> $FIG.ps
echo "0 0 90 0.9i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -N -Wthicker,black >> $FIG.ps
gmt pstext -R -J -O -K -Dj0.05i/0.05i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
0.25 1 BL D(f)
0 0 TC 0
1 0 TC f@-N@-
1.5 0 TC f
EOF
# 2. comb(t) and Comb(f)
gmt sample1d -I1 -Fl << EOF | awk '{print $1, 0, 90, $2}' >! c.d
0 0.5
4 0.5
EOF
gmt psxy -R-1/5/0/1 -JX2.5i/0.4i -O -K -Sv0.1i+e -Gblack -N c.d --PROJ_LENGTH_UNIT=inch -Wthicker,black -X${dx2} -Y-0.9i >> $FIG.ps
echo "b)" | gmt pstext -R -J -O -K -F+cTL+f12p >> $FIG.ps
echo "-1 0 0 2.5i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -N -Wthicker,black >> $FIG.ps
gmt pstext -R -J -O -K -Dj0.05i/0.05i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
5 0.8 RM @~D@~(t)
2 1.275 CM \031
EOF
gmt pstext -R -J -O -K -Dj0.05i/0.05i -N -F+f10p,Times-Italic+jTC << EOF >> $FIG.ps
0 0 -@~D@~t
1 0 0
2 0 @~D@~t
3 0 @~2D@~t
5 0 t
EOF

gmt sample1d -I1 -Fl << EOF | awk '{print $1, 0, 90, $2}' >! t.d
-1 0.5
1 0.5
EOF

gmt psxy -R-2/2/0/1 -JX2.5i/0.4i -O -K -Sv0.1i+e -Gblack -N t.d -X${dx1} --PROJ_LENGTH_UNIT=inch -Wthicker,black >> $FIG.ps
echo "-2 0 0 2.5i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -N -Wthicker,black >> $FIG.ps
gmt pstext -R -J -O -K -Dj0.05i/0.05i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
-1.4 1 TR @~D@~(f)
-1 0   TC -1/@~D@~t
0 0    TC 0
1 0    TC 1/@~D@~t
2 0    TC f
0 1.2  CM *
EOF
# 3. Sampling

#-------------------------------------------------
gmt math -T-5.01/5.01/0.02 T 0.72 ADD PI MUL DUP SIN EXCH DIV 0.85 MUL T 0.72 SUB PI MUL DUP SIN EXCH DIV ADD 0.15 SUB = ft.d
gmt sample1d -I1 -Fl ft.d | awk '{if ($2 > 0) {print $1, 0, 90, 1.2*$2} else {print $1, 0, -90, -$2}}' >! f.d

gmt psxy -R-6/6/-0.5/1 -JX2.5i/0.9i -O -K -Sv0.1i+e -Gblack -N f.d --PROJ_LENGTH_UNIT=inch -Wthicker,black -X${dx2} -Y-1.55i >> $FIG.ps
echo "c)" | gmt pstext -R -J -O -K -F+cTL+f12p >> $FIG.ps
echo "-6 0 0 2.5i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -N --PROJ_LENGTH_UNIT=inch -Wthicker,black >> $FIG.ps
gmt psxy -R -J -O -K -W0.25p << EOF >> $FIG.ps
-6 0
6 0
EOF
gmt pstext -R -J -O -K -Dj0.05i/0.05i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
2 1.2 TC d@-t@-
6 0   TC t
0 1.4 CM =
EOF

gmt math -T-1.1/1.1/0.02 T 10 PI MUL MUL COS 0.05 MUL 1 T ABS SUB ADD = wiggle.d

awk '{print $1+1.6, $2}' wiggle.d >! t1.d
awk '{print $1+3.2, $2}' wiggle.d >! t2.d
awk '{print $1+4.8, $2}' wiggle.d >! t3.d
awk '{print $1+6.4, $2}' wiggle.d >! t4.d
# I used awk and matlab to add these together to file
# data/Fig_sample6.txt

gmt psxy -R0/8/0/1.1 -JX2.5i/0.6i -O -K wiggle.d t?.d -W0.25p,- -X${dx1} -Y0.33i >> $FIG.ps
gmt psxy -R -J -O -K -W1p data/Fig_sample6.txt >> $FIG.ps
echo "0 0 0 2.5i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -N -Wthicker,black >> $FIG.ps
echo "1.6 0 90 0.9i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -N -Wthicker,black >> $FIG.ps
gmt pstext -R -J -O -K -Dj0.05i/0.10i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
1.8 1 BL D(f)
1.6 0 TC 0
2.7 0 TR f@-N@-
3.3 0 TL 1/@~D@~t
8.1 0.04 TC f
4 1.5 CM =
EOF
gmt psxy -R -J -O -K -W0.5p -Y-0.05i << EOF >> $FIG.ps
>
1.6 0
1.6 0.05
>
2.7 0
2.7 0.05
>
3.3 0
3.3 0.05
EOF
# 4. Gate functions
#-------------------------------------------------

gmt psxy -R-6/6/0/1 -JX2.5i/0.9i -O -K -W1p -X${dx2} -Y-1.5i << EOF >> $FIG.ps
-6 0
-5 0
-5 0.5
5 0.5
5 0
6 0
EOF
echo "d)" | gmt pstext -R -J -O -K -F+cTL+f12p >> $FIG.ps
gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -N -Wthicker,black << EOF >> $FIG.ps
-6 0 0 2.5i
0 0 90 1i
EOF
gmt pstext -R -J -O -K -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
1 0.9 TC h@-t@-
6 -0.05 TC t
0 1.2 CM \031
EOF

gmt math -T-6.01/6.01/0.02 T PI MUL DUP SIN EXCH DIV = ft.d

gmt psxy -R-6/6/-0.5/1 -JX2.5i/0.9i -O -K ft.d -X${dx1} -Y-0.32i  >> $FIG.ps
gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -N -Wthicker,black << EOF >> $FIG.ps
-6 0 0 2.5i
0 0 90 1i
2.5 0.4 220 0.3i
EOF
echo "1 0" | gmt psxy -R -J -O -K -Sc0.1i -W0.25p >> $FIG.ps
gmt pstext -R -J -O -K -Dj0.05/0.05 -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
0.5 1.1 LB H(f)
0 -0.05 TC 0
6 -0.05 TC f
2.5 0.4 LB 1/T
0 1.8 CM *
EOF
# 5. Truncation
#-------------------------------------------------
gmt math -T-5.01/5.01/0.02 T 0.72 ADD PI MUL DUP SIN EXCH DIV 0.85 MUL T 0.72 SUB PI MUL DUP SIN EXCH DIV ADD 0.15 SUB = ft.d
gmt sample1d -I1 -Fl ft.d | awk '{if ($2 > 0) {print $1, 0, 90, 1.2*$2} else {print $1, 0, -90, -$2}}' >! f.d

gmt psxy -R-6/6/-0.5/1 -JX2.5i/0.9i -O -K -Sv0.1i+e -Gblack -N f.d --PROJ_LENGTH_UNIT=inch -Wthicker,black -X${dx2} -Y-1.3i >> $FIG.ps
echo "e)" | gmt pstext -R -J -O -K -F+cTL+f12p >> $FIG.ps
gmt psxy -R -J -O -K -Sv0.1i+e+s -Gblack -Wthicker,black -N  << EOF >> $FIG.ps
-6 0 6 0
EOF
gmt pstext -R -J -O -K -Dj0.05i/0.05i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
2 1.2 TC d@-t@-
6 0 TC t
0 1.55 CM =
EOF

gmt math data/Fig_sample6.txt T 40 MUL SIN 0.1 MUL ADD = wiggle.d

gmt psxy -R0/8/0/1.1 -JX2.5i/0.6i -O -K wiggle.d -W0.75p -X${dx1} -Y0.33i >> $FIG.ps
echo "0 0 0 2.5i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N >> $FIG.ps
echo "1.6 0 90 0.9i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N >> $FIG.ps
gmt pstext -R -J -O -K -Dj0.05i/0.10i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
1.8 1.05 BL D(f)*@~D@~(f)*H(f)
1.6 0 TC 0
3.3 0 1/@~D@~t
8.1 0.04 TC f
4 1.61 CM =
EOF
gmt psxy -R -J -O -K -W0.5p -Y-0.05i << EOF >> $FIG.ps
>
1.6 0
1.6 0.05
>
3.3 0
3.3 0.05
EOF
# 6. Periodicity
#-------------------------------------------------
gmt sample1d -I1 -Fl << EOF | awk '{print $1, 0, 90, $2}' >! t.d
-1 0.5
1 0.5
EOF
gmt psxy -R-2/2/0/1 -JX2.5i/0.4i -O -K -Sv0.1i+e -Gblack -N t.d --PROJ_LENGTH_UNIT=inch -Wthicker,black -X${dx2} -Y-0.95i >> $FIG.ps
echo "f)" | gmt pstext -R -J -O -K -F+cTL+f12p >> $FIG.ps
echo "-2 0 0 2.5i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N >> $FIG.ps
gmt pstext -R -J -O -K -Dj0.05i/0.05i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
-1 0 TC -T
0 0 TC 0
1 0 TC T
2 0 TC t
0 1.5 CM *
EOF

gmt sample1d -I1 -Fl << EOF | awk '{print $1, 0, 90, $2}' >! c.d
0 0.5
4 0.5
EOF

gmt psxy -R-1/5/0/1 -JX2.5i/0.4i -O -K -Sv0.1i+e -Gblack -Wthicker,black -N c.d -X${dx1} --PROJ_LENGTH_UNIT=inch >> $FIG.ps
echo "-1 0 0 2.5i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N >> $FIG.ps
gmt pstext -R -J -O -K -Dj0.05i/0.05i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
2 1.5 CM \031
EOF
gmt pstext -R -J -O -K -Dj0.05i/0.05i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
1 0 TC -1/T
2 0 TC 0
3 0 TC 1/T
5 0 TC f
EOF

# 7. Final results
#-------------------------------------------------
gmt math -T-5.01/5.01/0.02 T 0.72 ADD PI MUL DUP SIN EXCH DIV 0.85 MUL T 0.72 SUB PI MUL DUP SIN EXCH DIV ADD 0.15 SUB = ft.d
gmt sample1d -I1 -Fl ft.d | awk '{if ($2 > 0) {print $1, 0, 90, 1.2*$2} else {print $1, 0, -90, -$2}}' >! f.d
awk '{if ($1 > -2) print $1-11, $2, $3, $4}' f.d >! r.d
cat f.d >> r.d
awk '{if ($1 < 2) print $1+11, $2, $3, $4}' f.d >> r.d


gmt psxy -R-13/13/-0.5/1.1 -JX2.5i/0.9i -O -K -Sv0.1i+e -Gblack r.d --PROJ_LENGTH_UNIT=inch -Wthicker,black -X${dx2} -Y-1.7i>> $FIG.ps
echo "g)" | gmt pstext -R -J -O -K -F+cTL+f12p -Dj0/-0.5i -N >> $FIG.ps
gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -N -Wthicker,black << EOF >> $FIG.ps
-13 0 0 2.6i
EOF
gmt psxy -R -J -O -K -Sv0.1i+et+bt+s -Gblack -N -Wthin << EOF >> $FIG.ps
-10 1.4 1 1.4
EOF
gmt pstext -R -J -O -K -Dj0.05i/0.05i -N -Gwhite -F+f10p,Times-Italic+j << EOF >> $FIG.ps
-13 1.4 TL d@-t@-
13.5 -0.05 TC t
0 1.65 CM =
-4.5 1.4 CM T
EOF

gmt math data/Fig_sample6.txt T 40 MUL SIN 0.1 MUL ADD = wiggle.d
#gmt sample1d -T0/8/0.5 -Fl wiggle.d | awk '{if ($2 > 0) {print $1, 0, 90, $2} else {print $1, 0, 90, -$2}}' >! w.d
gmt sample1d -T0/7.5/0.5 -Fl wiggle.d | awk '{if ($2 > 0) {print $1, 0, 90, $2} else {print $1, 0, 90, -$2}}' >! w.d


gmt psxy -R0/8/0/1.1 -JX2.5i/0.6i -O -K w.d -Sv0.1i+e -Gblack -N -X${dx1} -Y0.33i -Wthicker,black --PROJ_LENGTH_UNIT=inch >> $FIG.ps
echo "0 0 0 2.5i" | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack -Wthicker,black -N >> $FIG.ps
gmt pstext -R -J -O -K -Dj0.05i/0.10i -N -F+f10p,Times-Italic+j << EOF >> $FIG.ps
8.1 0.04 TC f
4 1.61 CM =
EOF
# Final dividing line
gmt psxy -R-0.01/0.01/0/8.8 -Jx1i -O -K -X-0.5i -Y-0.25i -W5p,lightgray,4_4:0p << EOF >> $FIG.ps
0	0
0	8.7
EOF
gmt pstext -R-0.01/0.01/0/8.8 -Jx1i -O -K -N -F+f12p+jBC << EOF >> $FIG.ps
-1.75	8.6	Time Domain
1.75	8.6	Frequency Domain
EOF
gmt psxy -R -J -O -T >> $FIG.ps
rm -f ft.d f.d wiggle.d r.d w.d c.d t.d t[1-4].d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
