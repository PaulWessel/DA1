#!/bin/csh
#
# This script will create the EPS file for a figure.
# Run script with arbitrary argument to invoke gv
#
# Purpose: The geometrical meaning of LMS criteria
#
set name = $0
set FIG = $name:r
#-------------------------------------------------
cp -f gmt.conf.DA1 gmt.conf
gmt set PS_SCALE_X 0.6 PS_SCALE_Y 0.6
#-------------------------------------------------

gmt psxy -R-90/90/0/0.8 -JX4i/1.3i -P -K -Bxa30+u"\232" -Bya0.2+l"E(@~b@~)" -BWSe -W1p -L+yb -Glightgray << EOF >! $FIG.ps
  -8.9170507e+01	   7.0175439e-01	
  -8.5437788e+01	   7.1052632e-01	
  -8.4193548e+01	   6.9005848e-01	
  -8.2119816e+01	   6.9590643e-01	
  -7.7557604e+01	   7.1345029e-01	
  -7.5483871e+01	   6.4327485e-01	
  -7.3410138e+01	   6.6374269e-01	
  -7.0921659e+01	   6.4035088e-01	
  -6.6774194e+01	   6.2573099e-01	
  -6.1797235e+01	   6.1695906e-01	
  -6.0967742e+01	   5.8187135e-01	
  -5.7649770e+01	   5.7309942e-01	
  -5.5576037e+01	   5.9064327e-01	
  -5.4331797e+01	   5.7017544e-01	
  -5.1428571e+01	   5.4385965e-01	
  -4.8525346e+01	   5.1461988e-01	
  -4.6451613e+01	   5.0000000e-01	
  -4.3963134e+01	   5.0877193e-01	
  -4.2304147e+01	   5.3216374e-01	
  -3.7741935e+01	   5.4678363e-01	
  -3.4838710e+01	   5.5263158e-01	
  -3.3179724e+01	   5.4385965e-01	
  -3.0276498e+01	   5.6140351e-01	
  -2.6958525e+01	   5.2046784e-01	
  -2.4884793e+01	   4.4444444e-01	
  -2.2811060e+01	   4.2105263e-01	
  -2.1152074e+01	   3.9766082e-01	
  -1.7834101e+01	   3.9181287e-01	
  -1.2027650e+01	   4.0058480e-01	
  -9.1244240e+00	   4.2105263e-01	
  -6.6359447e+00	   4.2982456e-01	
  -3.7327189e+00	   4.1812865e-01	
  -2.0737327e+00	   4.0643275e-01	
   1.2442396e+00	   4.1228070e-01	
   2.9032258e+00	   4.4736842e-01	
   5.8064516e+00	   5.5263158e-01	
   8.2949309e+00	   5.6725146e-01	
   9.1244240e+00	   5.4678363e-01	
   9.9539171e+00	   4.7368421e-01	
   1.1198157e+01	   4.3567251e-01	
   1.2857143e+01	   4.2397661e-01	
   1.4930876e+01	   4.0350877e-01	
   1.7419355e+01	   4.1812865e-01	
   1.9078341e+01	   3.6842105e-01	
   2.1981567e+01	   3.1578947e-01	
   2.3640553e+01	   2.1929825e-01	
   2.9032258e+01	   1.4327485e-01	
   3.0276498e+01	   5.5555556e-02	
   3.5668203e+01	   1.4327485e-01	
   3.8156682e+01	   2.9532164e-01	
   4.1474654e+01	   2.6900585e-01	
   4.3548387e+01	   3.2163743e-01	
   4.7281106e+01	   3.0994152e-01	
   5.1843318e+01	   3.5087719e-01	
   5.6405530e+01	   5.0584795e-01	
   6.1382488e+01	   5.1754386e-01	
   6.3456221e+01	   5.7309942e-01	
   6.8433180e+01	   5.8479532e-01	
   7.0921659e+01	   5.6432749e-01	
   7.3824885e+01	   6.0526316e-01	
   7.9631336e+01	   6.5204678e-01	
   8.2949309e+01	   7.2514620e-01	
   8.6682028e+01	   7.1929825e-01	
   8.9585253e+01	   7.3391813e-01
EOF
cat << EOF | gmt psxy -R -J -O -K -Sv0.1i+e -Gblack >> $FIG.ps
30 0.6 -90 0.75i
EOF
cat << EOF | gmt pstext -R -J -O -N -Dj0.05i/0.05i -F+f10p,Times-Roman+jCB >> $FIG.ps
30 0.6 @~b@~
30 0.63 ^
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
