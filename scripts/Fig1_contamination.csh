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
gmt set PS_SCALE_X 0.5 PS_SCALE_Y 0.5
#-------------------------------------------------

gmt psxy -R0/8/1/7 -JX2.25i/1.75i -P -K -B0 -BWS -Sc0.06i -Gblack --MAP_FRAME_TYPE=graph << EOF >! $FIG.ps
   1.0000000e+00	   3.0811412e+00	
   1.2142857e+00	   3.4013797e+00	
   1.4285714e+00	   3.6119523e+00	
   1.6428571e+00	   3.7249112e+00	
   1.8571429e+00	   4.0358728e+00	
   2.0714286e+00	   4.0830068e+00	
   2.2857143e+00	   4.3562879e+00	
   2.5000000e+00	   4.6626333e+00	
   2.7142857e+00	   4.7162580e+00	
   2.9285714e+00	   4.9563496e+00	
   3.1428571e+00	   5.1834102e+00	
   3.3571429e+00	   5.3968872e+00	
   3.5714286e+00	   5.6921871e+00	
   3.7857143e+00	   5.8401519e+00	
   4.0000000e+00	   6.0397629e+00	
   7.0861149e+00	   2.0082898e+00	
   6.9932728e+00	   1.6669511e+00	
   6.9764103e+00	   2.0084767e+00	
   7.0523354e+00	   1.9760978e+00	
   6.7759197e+00	   2.0486200e+00	
   6.7922598e+00	   2.1165126e+00	
   7.1351875e+00	   1.8043248e+00	
   6.9925671e+00	   1.9988154e+00	
EOF
gmt pstext -R -J -O -K -F+f12p,Times-Italic+jLB << EOF >> $FIG.ps
4 5 1-@~e@~
7 2.5 @~e@~
1 6 r @~\273@~ 1
EOF
gmt psxy -R -J -O -K -B0 -BWS -Sc0.06i -Gblack -X2.75i --MAP_FRAME_TYPE=graph << EOF >> $FIG.ps
   1.1428571e+00	   2.3684211e+00	
   2.6543779e+00	   2.5964912e+00	
   3.6682028e+00	   3.3859649e+00	
   5.1612903e+00	   4.3157895e+00	
   4.6820276e+00	   5.6315789e+00	
   2.9124424e+00	   5.8947368e+00	
   1.7511521e+00	   4.9649123e+00	
   1.5483871e+00	   4.1228070e+00	
   2.5622120e+00	   4.0175439e+00	
   3.8156682e+00	   4.8245614e+00	
   2.8018433e+00	   5.0000000e+00	
   3.1889401e+00	   5.3333333e+00	
   3.8341014e+00	   4.4210526e+00	
   2.7281106e+00	   4.2807018e+00	
   2.0829493e+00	   3.8596491e+00	
   2.4331797e+00	   3.3508772e+00	
   2.7096774e+00	   2.8070175e+00	
   1.7695853e+00	   2.5263158e+00	
   1.6589862e+00	   3.3684211e+00	
   3.1889401e+00	   3.2105263e+00	
   3.6313364e+00	   3.7192982e+00	
   2.1382488e+00	   3.8947368e+00	
   2.4884793e+00	   4.8947368e+00	
   3.1520737e+00	   4.4736842e+00	
   3.0967742e+00	   5.4561404e+00	
   4.5529954e+00	   5.5263158e+00	
   4.4423963e+00	   6.1403509e+00	
   3.7419355e+00	   6.1754386e+00	
   3.7972350e+00	   5.0175439e+00	
   4.3317972e+00	   4.7192982e+00	
   3.6313364e+00	   4.4210526e+00	
   2.1935484e+00	   4.1403509e+00	
   1.6221198e+00	   3.4035088e+00	
   1.5483871e+00	   2.0877193e+00	
   2.5253456e+00	   2.4210526e+00	
   1.5483871e+00	   2.8245614e+00	
   7.0861149e+00	   2.0082898e+00	
   6.9932728e+00	   1.6669511e+00	
   6.9764103e+00	   2.0084767e+00	
   7.0523354e+00	   1.9760978e+00	
   6.7759197e+00	   2.0486200e+00	
   6.7922598e+00	   2.1165126e+00	
   7.1351875e+00	   1.8043248e+00	
   6.9925671e+00	   1.9988154e+00	
EOF
gmt pstext -R -J -O -F+f12p,Times-Italic+jLB << EOF >> $FIG.ps
5.5 5 1-@~e@~
7 2.5 @~e@~
1 6 r @~\273@~ 0.1
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
