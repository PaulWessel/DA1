#!/bin/csh
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
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8
#-------------------------------------------------
gmt psxy -R-0.2/2.5/-0.25/2 -Jx0.8i/0.5i -P -B0 -BWS -W0.5p -K --MAP_FRAME_TYPE=graph << EOF >! $FIG.ps
> line y = 0.7 x  -W2p
0 0
2.5 1.75
> -W0.5p
0.25 0.175
0.05	0.175
>
0.7	0.49
1.1	0.49
>
1.6	1.12
1.2	1.12
>
2.0	1.4
2.3	1.4
>
2.4	1.68
2.0 1.68
EOF
gmt psxy -R -J -O -K -Sc0.05i -Gblack << EOF >> $FIG.ps
0.05	0.175
1.1	0.49
1.2	1.12
2.3	1.4
2.0 1.68
EOF
gmt pstext -R -J -O -K -N -Dj0.05i/0.05i -F+f12p,Times-Italic+j << EOF >> $FIG.ps
2.3 -0.35 LT x
-0.2 2 RB d
1.4 1.12 CB e@-i@-
EOF
#
# Orthogonal plot
#
gmt psxy -R -J -O -B0 -BWS -W0.5p -K -X2.5i --MAP_FRAME_TYPE=graph << EOF >> $FIG.ps
> line y = 0.7 x  -W2p
0 0
2.5 1.75
> -W0.5p
0.08 0.076
0.05	0.175
>
1.05	0.695
1.1	0.49
>
1.25	0.914
1.2	1.12
>
2.25	1.557
2.3	1.4
>
2.06	1.470
2.0	1.68
EOF
gmt psxy -R -J -O -K -Sc0.05i -Gblack << EOF >> $FIG.ps
0.05	0.175
1.1	0.49
1.2	1.12
2.3	1.4
2.0 1.68
EOF
gmt pstext -R -J -O -N -Dj0.05i/0.05i -F+f12p,Times-Italic+j << EOF >> $FIG.ps
2.3 -0.35 LT x
-0.2 2 RB d
1.26 1.05 LB e@-i@-
EOF

#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
