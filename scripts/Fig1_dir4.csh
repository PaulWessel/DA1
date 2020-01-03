#!/bin/csh
#	$Id: Fig1_dir4.csh 622 2017-12-19 20:50:23Z pwessel $
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
gmt set PS_SCALE_X 0.7 PS_SCALE_Y 0.7
#-------------------------------------------------
gmt psxy -R0/4/0/2 -JX4i/2i -P -K -Sc1i -Glightgray -W0.5p -N << EOF >! $FIG.ps
0.5 0.5
3 1.5
EOF
gmt psxy -R -J -O -K -Sc0.1i -Gwhite -W0.25p << EOF >> $FIG.ps
0.5 0.5
3 1.5
EOF
gmt psxy -R -J -O -K << EOF >> $FIG.ps
> main -W1.5p
0.5 0.5
3 1.5
> gentle -W0.5p,-
0.5 1
3 1
> steep -W0.5p,-
0.85 0.14
2.70 1.91
> hor -W0.25p
0.5 0.5
2 0.5
> r
0.5 0.5
0.27 0.94
EOF
gmt pstext -R -J -O -F+f+a+j << EOF >> $FIG.ps
1.75 1.1 10p,Times-Roman 30 CB d@-0@-
0.8 0.575 10p,Symbol 0 LM a@-0@-
2.175 1.29 10p,Symbol 30 LM Da
0.42 0.75 10p,Times-Roman 10 LM s@-r@-
0.5 0.4 14p,Helvetica-Bold 0 TC A
3 1.4 14p,Helvetica-Bold 0 TC B
EOF

#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
