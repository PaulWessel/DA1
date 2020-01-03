#!/bin/csh
#	$Id: Fig1_outcrop.csh 635 2018-07-30 01:21:43Z pwessel $
#
# This script will create the EPS file for Figure
# Run script with arbitrary argument to invoke gv
#
# Purpose: Existant and available populations
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8 
#-------------------------------------------------

cat << EOF >! sand.d
0 1
3.5 2.65
3.45 3.3
0 1.65
EOF
cat << EOF >! shale.d
0 1
3.5 2.65
3.6 2
3.8 1.9
0 0.35
EOF
gmt psxy -R0/7/0/4 -Jx1.5c/1c -P -Gdarkgray sand.d -K >! $FIG.ps
gmt psxy -R -J -O -K -Glightgray shale.d >> $FIG.ps
gmt psxy -R -J -O -K -W2p << EOF >> $FIG.ps
> outline
0 2.25
0.4 2.35
0.85 2.4
1.3 2.6
1.5 2.9
1.85 3
2.3 3.05
2.4 3.3
2.9 3.4
3.3 3.35
3.45 3.3
3.5 2.65
3.6 2
3.6 2
3.8 1.9
4 1.8
4.05 0.95
4.2 0.8
4.5 0.5
5 0.4
5.5 0.35
5.7 0.4
> boundaries -W0.5p
0 1
3.5 2.65
> boundaries -W0.5p
3.45 3.3
0 1.65
> boundaries -W0.5p
3.8 1.9
0 0.35
> boundaries -W0.5p
4.05 0.95
2 0
EOF
gmt psxy -R -J -O -K -Sv0.15i+e -Gblack << EOF >> $FIG.ps
4.3 3.3 234 2.8c
4.7 1.6 193 1.35c
EOF
echo "3.85 1.4 100 0.5 0.3" | gmt psxy -R -J -O -K -Se -W0.25p,- >> $FIG.ps
gmt pstext -R -J -O -D0.1i/0 -F+f9p,Helvetica-Bold+jLB << EOF >> $FIG.ps
4.3 3.5 Extant
4.3 3.1 Population
4.7 1.8 Available
4.7 1.4 Population
EOF
\rm -f sand.d shale.d
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
