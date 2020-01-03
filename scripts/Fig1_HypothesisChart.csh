#!/bin/csh
#	$Id$
#
# This script will create the EPS file for a figure.
# Run script with arbitrary argument to invoke gv
#
# Purpose: Show hypothesis chart
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.8 PS_SCALE_Y 0.8
#-------------------------------------------------
gmt psxy -R-6.2/4.8/-0.5/5.5 -Jx0.75i -P -K -W2p << EOF > $FIG.ps
> vertical top
-3	4.5
-3	1.5
> Hor to normal
-3	3
-1	3
> # to #1
-3.5	1.5
-5.3	1.5
-5.3	0.25
> # to #2
-3	1.5
-3	0.25
> # to #2
-2.5	1.5
-0.8	1.5
-0.8	0.25
> # to #1 nonparametric
2.2	1.5
1.6	1.5
1.6	0.25
> # to #2 nonparametric
3.2	1.5
3.7	1.5
3.7	0.25
> # Connect par and nonpar
-3	4.5
2.7	4.5
2.7	1.5
> # Not normal
-1	3
2.7	3
> # Was normal
-1	3
-1	2.25
-3	2.25
> Dashed divider -W6p,gray,8_8:0p
0.4	5.5
0.4	-0.5
EOF

gmt psxy -R -J -O -K -W1p -Gwhite << EOF >> $FIG.ps
> ordinal data
-3.75	4.5
-3	4
-2.25	4.5
-3	5
> large data?
-3.75	3
-3	2.5
-2.25	3
-3	3.5
> Assume normal?
-1.75	3
-1	2.5
-0.25	3
-1	3.5
> Number of samples
-3.75	1.5
-3	1
-2.25	1.5
-3	2
> #1
-6.2	0.5
-4.2	0.5
-4.2	-0.3
-6.2	-0.3
> #2
-4	0.5
-2	0.5
-2	-0.3
-4	-0.3
> #>2
-1.8	0.5
0.2	0.5
0.2	-0.3
-1.8	-0.3
> Number of samples nonparametric
1.95	1.5
2.7	1
3.45	1.5
2.7	2
> #1 nonparametric
0.6	0.5
2.6	0.5
2.6	-0.3
0.6	-0.3
> #2 nonparametric
2.8	0.5
4.8	0.5
4.8	-0.3
2.8	-0.3
EOF
# Text
gmt pstext -R -J -O -K -F+f16p,Helvetica+jCM << EOF >> $FIG.ps
-3	5.25	PARAMETRIC
2.7	5.25	NONPARAMETRIC
EOF
gmt pstext -R -J -O -K -F+f11p,Helvetica+jCM << EOF >> $FIG.ps
-3	4.6	ORDINAL
-3	4.4	DATA
-3	4.2	?
-2	4.65	YES
-3.25	3.75	NO
-3	3.1	LARGE
-3	2.9	SAMPLE
-3	2.7	?
-2	3.15	NO
-3.25	2.25	YES
-1	3.1	NORMAL
-1	2.9	POPUL.
-1	2.7	?
0	3.15	NO
-0.7	2.25	YES
-3	1.6	SAMPLE
-3	1.4	COUNT
2.7	1.6	SAMPLE
2.7	1.4	COUNT
-4.4	1.65	1
-3.25	0.75	2
-1.65	1.65	>2
1.35	1	1
3.95	1	2
EOF
gmt pstext -R -J -O -K -F+f9p,Helvetica+jCM << EOF >> $FIG.ps
-5.2	0.35	Mean (@%6%t, z@%%)
-5.2	0.20	Standard deviation (@~c@~@+2@+)
-5.2	0.05	Correlation (@%6%r@%%)
-5.2	-0.10	Distribution (@~c@~@+2@+)
-3	0.35	Two means (@%6%t, z@%%)
-3	0.125	Two std. deviations (@%6%F@%%)
-3	-0.1	Two distributions (@~c@~@+2@+)
-0.9	0.25	ANOVA
-0.9	0	(1-way or 2-way)
1.6	0.35    Sign test median, run test
1.6	0.125   Kolmogorov-Smirnov (1)
1.6	-0.1 	Spearman correlation (@%6%r@-s@-@%%)
3.8	0.25	U-test for two means
3.8	0.0	Kolmogorov-Smirnov (2)
-4.4	2.7	Central Limits Theorem
EOF
gmt psxy -R -J -O -T >> $FIG.ps
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
