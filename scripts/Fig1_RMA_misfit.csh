#!/bin/csh
#	$Id: Fig1_RMA_misfit.csh 632 2018-07-28 21:09:10Z pwessel $
#
# This script will create the EPS file for a figure.
# Run script with arbitrary argument to invoke gv
#
# Purpose:
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------

gmt psbasemap -R0/3/0.6/2.75 -Jx1.25i -P -K -B0 -Bws --MAP_FRAME_TYPE=graph >! $FIG.ps
echo "1.655 1.895" | gmt psxy -R -J -O -K -Sc2.2i -W0.5p -G230 -N >> $FIG.ps
gmt psxy -R -J -O -K -Gwhite << EOF >> $FIG.ps
1.655 1.6
1.9 1.6
1.9 1.895
1.655 1.895
EOF
gmt psxy -R -J -O -K -Sc0.075i -Gblack << EOF >> $FIG.ps
0.25 0.7
0.8 0.9
1.2 1.7
1.9 1.6
2.1 2.4
2.6 2.7
EOF
gmt psxy -R -J -O -K << EOF >> $FIG.ps
> fit -W2p
0 0.3
3 3.2
> detail -W0.5p
1.9 1.6
1.655 1.895
>
1.9 1.6
1.655 1.6
1.655 1.895
>
1.9 1.6
1.9 1.895
1.655 1.895
EOF
echo "1.655 1.895" | gmt psxy -R -J -O -K -Sc0.075i -W0.25p -Gwhite >> $FIG.ps
gmt pstext -R -J -O -Dj0.075i/0.075i -F+f+j -N << EOF >> $FIG.ps
1.9 1.6 12p,Times-Roman LT (@%6%x@-i@-@%%, @%6%y@-i@-@%%)
1.655 1.895 12p,Times-Roman RB (@%6%X@-i@-@%%, @%6%Y@-i@-@%%)
1.7775 1.6 12p,Times-Italic TC @~D@~x
1.9 1.7475 12p,Times-Italic LM @~D@~y
3 0.57 12p,Times-Italic TR x
-0.05 2.75 12p,Times-Italic TR y
EOF

#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
