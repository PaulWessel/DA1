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
gmt set PS_SCALE_X 0.65 PS_SCALE_Y 0.65
#-------------------------------------------------

gmt pshistogram -R-7/8/0/10 -JX2.25i/1.1i -P -K -B0 -BWS -Glightgray -W0.25p -Z1 -T0.3 --MAP_FRAME_TYPE=graph << EOF >! $FIG.ps
   3.7581926e+00	
   2.3080598e+00	
   3.6801786e+00	
   1.9274590e+00	
   3.8997721e+00	
   8.7690760e-01	
   3.2847123e+00	
   2.2666771e+00	
   2.2266244e+00	
   3.1518417e+00	
   2.6631569e+00	
   3.9707607e+00	
   2.8927636e+00	
   4.0134919e+00	
   2.5246532e+00	
   3.0689481e+00	
   3.3985921e+00	
   4.1163262e+00	
   3.6204511e+00	
   2.7123255e+00	
   1.6282267e+00	
   2.3141316e+00	
   3.3316847e+00	
   2.0022782e+00	
   3.2914181e+00	
   4.1070784e+00	
   3.2449586e+00	
   3.1649758e+00	
   3.4062313e+00	
   4.2159812e+00	
   4.4484243e+00	
   1.9748625e+00	
   3.2054180e+00	
   3.5888822e+00	
   2.7359764e+00	
   5.4953178e+00	
   3.8559477e+00	
   2.1490464e+00	
   3.8118788e+00	
   3.7002417e+00	
   3.7599383e+00	
   1.2870908e+00	
   4.5370212e+00	
   1.3901532e+00	
   4.1095260e+00	
   1.8902960e+00	
   3.3854694e+00	
   3.9652308e+00	
   3.8182972e+00	
   3.0370488e+00	
   2.0739876e+00	
   2.8880813e+00	
   2.1969703e+00	
   1.3349941e+00	
   2.0985994e+00	
   3.5883497e+00	
   3.5541593e+00	
   2.5848274e+00	
   3.0617949e+00	
   3.4574316e+00	
   3.1990139e+00	
   3.2575578e+00	
   5.0807298e+00	
   7.2276349e-01	
   3.3390224e+00	
   3.2898939e+00	
   3.6622609e+00	
   2.4191398e+00	
   3.8877519e+00	
   3.1718710e+00	
   3.8488214e+00	
   3.9637690e+00	
   4.3219180e+00	
   2.9356551e+00	
   4.3170531e+00	
   3.2280173e+00	
   1.5703628e+00	
   2.8502990e+00	
   2.4950324e+00	
   1.2708585e+00	
   2.5825278e+00	
   2.3850315e+00	
   3.7207767e+00	
   3.3393638e+00	
   3.8828451e+00	
   3.2842452e+00	
   2.8544587e+00	
   2.9103541e+00	
   3.2891609e+00	
   4.1648308e+00	
   3.8057293e+00	
   1.6443565e+00	
   3.1208929e+00	
   2.7778221e+00	
   3.5717323e+00	
   2.6998596e+00	
   4.1342768e+00	
   2.8206436e+00	
   1.5329333e+00	
   4.3953457e+00	
   3.4408357e+00	
   3.5653840e+00	
   2.3063774e+00	
   3.8338692e+00	
   7.6262161e-01	
   4.0976441e+00	
   2.9983831e+00	
   1.3854267e+00	
   1.7712732e+00	
   3.2074046e+00	
   3.2209420e+00	
   1.9939269e+00	
   2.5469329e+00	
   4.3994533e+00	
   2.5380360e+00	
   3.0327159e+00	
   3.7987832e+00	
   3.8968158e+00	
   3.1378917e+00	
   1.3808536e+00	
   1.3533943e+00	
   3.4287069e+00	
   2.2627692e+00	
   3.5649261e+00	
   1.6158333e+00	
   3.4602680e+00	
   3.6293836e+00	
   3.3798473e+00	
   1.9866701e+00	
   2.6527572e+00	
   3.4419123e+00	
   1.4097597e+00	
   2.2985833e+00	
   1.9223994e+00	
   4.0022197e+00	
   4.7294805e+00	
   3.7090322e+00	
   2.2521031e+00	
   3.2288624e+00	
   2.7765034e+00	
   2.1467247e+00	
   3.3456268e+00	
   3.1097645e+00	
   1.8669610e+00	
   2.3168765e+00	
   2.7221438e+00	
   3.6547899e+00	
   1.7516060e+00	
   2.4024610e+00	
   2.5181875e+00	
   3.9833722e+00	
   4.7621207e+00	
   4.4274017e+00	
   3.9117630e+00	
   3.3268227e+00	
   3.0696185e+00	
   1.5002373e+00	
   2.5817768e+00	
   2.9789632e+00	
   3.2284245e+00	
   1.9918042e+00	
   2.3353778e+00	
   3.5581766e+00	
   1.8114579e+00	
   2.2245185e+00	
   3.2710421e+00	
   4.5349757e+00	
   1.9477173e+00	
   3.6255586e+00	
   2.2023739e+00	
   2.6864780e+00	
   2.3977902e+00	
   4.2590603e+00	
   3.8584843e+00	
   8.9470812e-01	
   2.6390628e+00	
   3.5535567e+00	
   1.4436162e+00	
   2.7933343e+00	
   2.5744325e+00	
   3.4937782e+00	
   2.1290924e+00	
   3.0798277e+00	
   2.4783809e+00	
   1.5861391e+00	
   2.6157068e+00	
   2.5420778e+00	
   2.7085293e+00	
   2.6987760e+00	
   1.4114062e+00	
   4.0942867e+00	
   4.3241669e+00	
   2.8735204e+00	
   2.2628362e+00	
   3.2137188e+00	
   2.5994709e+00	
   3.0649377e+00	
   1.2420044e+00	
   4.6867480e+00	
   3.3274002e+00	
   3.7159668e+00	
   4.5986479e+00	
   9.3525909e-01	
   2.2563684e+00	
   3.1761845e+00	
   3.5278388e+00	
   2.4468474e+00	
   3.2982798e+00	
   1.7733932e+00	
   2.8103239e+00	
   2.6982867e+00	
   3.9569560e+00	
   2.4666341e+00	
   2.0989182e+00	
   2.1074485e+00	
   3.2787165e+00	
   2.2541933e+00	
   4.6034635e+00	
   3.5742696e+00	
   3.3206546e+00	
   2.8486170e+00	
   3.3157622e+00	
   4.3437026e+00	
   7.6216804e-01	
   4.2929064e+00	
   2.6215411e+00	
   3.0025214e+00	
   3.8846408e+00	
   3.5824504e+00	
   1.3857561e+00	
   1.4963345e+00	
   3.5735859e+00	
   2.0894630e+00	
   1.3687226e+00	
   2.6408617e+00	
   2.6023839e+00	
   1.8386929e+00	
   1.8901618e+00	
   3.2906724e+00	
   1.0897614e+00	
   4.3147683e+00	
   3.6653193e+00	
   2.7248854e+00	
   2.9769784e+00	
   2.0920235e+00	
   1.9563431e+00	
   3.3735157e+00	
   3.9015324e+00	
   4.2785392e+00	
   2.8715437e+00	
   3.6128214e+00	
   4.9565181e+00	
   5.2663265e+00	
   2.6260414e+00	
   5.2380388e+00	
   2.8404199e+00	
   2.2967187e+00	
   3.5634770e+00	
   2.9497036e+00	
   4.1635927e+00	
   3.6588084e+00	
   1.4499113e+00	
  -2.9118163e-02	
   3.5405782e+00	
   1.9910016e+00	
   3.9080472e+00	
   4.5823033e+00	
   2.0209118e+00	
   4.0079021e+00	
   3.1584914e+00	
   2.4130728e+00	
   4.5740817e+00	
   2.4833509e+00	
   4.2277999e+00	
   4.5838758e+00	
   9.1104962e-01	
   5.9495453e+00	
   4.3561249e+00	
   4.0500679e+00	
   2.2328299e+00	
   2.7423472e+00	
   1.6281548e+00	
   1.7323443e+00	
   2.1050517e+00	
   3.5890889e+00	
   4.8426293e+00	
   4.3479673e+00	
   2.5087473e+00	
   8.2243206e-01	
   3.2369995e+00	
   2.2645888e+00	
   1.2205805e+00	
   3.4480303e+00	
   3.5812141e+00	
   3.8566074e+00	
   2.7337368e+00	
   2.5825299e+00	
   2.7941939e+00	
   2.8256770e+00	
   3.2175771e+00	
  -5.2593677e+00	
  -1.6617110e+00	
   3.6252743e+00	
  -8.2451374e-01	
   6.7546812e+00	
  -4.0873472e+00	
  -1.3408129e+00	
   1.3680567e+00	
   3.7315077e+00	
  -1.1381081e+00	
  -1.2410391e+00	
   3.0881507e+00	
   1.0231575e-01	
   1.8711683e+00	
   3.0769089e+00	
   7.6225705e-01	
   2.6944278e+00	
   1.9128774e+00	
  -3.2989503e+00	
  -1.2729784e+00	
   1.3877895e+00	
  -4.8940634e+00	
  -1.9011330e+00	
  -6.1097160e+00	
  -1.6484142e+00	
  -2.8694824e-01	
   7.5019864e-01	
  -1.4599889e+00	
  -7.6843616e+00	
   3.8776041e+00	
  -1.0184219e+00	
   3.5702382e+00	
  -3.3831055e+00	
   2.2599250e+00	
   1.3541770e+00	
  -1.1625506e+00	
   6.0760387e+00	
   5.0511982e+00	
   1.9932179e+00	
   7.7490923e-02	
   1.3518459e+00	
   1.7098037e+00	
  -1.4751293e+00	
  -6.5271074e-01	
   3.7926711e+00	
   2.5181467e+00	
   7.5855264e-01	
  -2.0427013e+00	
  -1.2279802e+00	
   2.1686666e+00	
   9.0197437e-01	
  -2.0092704e-01	
   1.8732523e+00	
  -4.4799205e+00	
   3.0330638e+00	
  -1.5130998e-01	
  -9.8130072e-01	
   1.5238673e+00	
   1.6089493e+00	
   2.5488029e+00	
   2.3360917e+00	
   3.0714559e+00	
  -6.2371591e-01	
  -1.7689565e+00	
  -1.4845611e+00	
  -6.5577605e-01	
   3.1071184e+00	
  -3.8722555e+00	
  -9.6690075e-01	
   6.8774565e-01	
   2.0653856e+00	
  -2.4481967e+00	
  -2.6074202e-01	
   3.1962259e-01	
   1.5635911e-01	
   9.2906027e-01	
  -2.5990636e-01	
  -1.7419384e+00	
  -9.6705680e-01	
   4.0334352e-02	
   3.4230294e+00	
   1.0421933e+00	
   1.7185221e-01	
   7.3546837e-01	
   1.1815818e+00	
   4.4568366e+00	
   6.5144256e-01	
   3.7768194e+00	
   7.9242103e-01	
   2.0086819e+00	
   1.4521840e+00	
   4.4464612e+00	
  -2.3451872e+00	
  -2.2916810e+00	
   9.4001464e-01	
   2.2744495e+00	
   3.8562479e-01	
  -5.0566019e-01	
   3.7217690e+00	
  -1.5540968e+00	
   2.0238427e+00	
   4.8219831e+00	
   9.9014252e-01	
  -2.1534978e+00	
   6.0798394e+00	
  -2.1012941e+00	
   7.0112715e-01	
   2.0510401e+00	
   3.0695697e+00	
  -1.5891242e-01	
   1.6131621e+00	
  -4.4282938e+00	
   1.4902907e-01	
  -1.9004433e+00	
  -4.2272536e+00	
   2.7591803e+00	
   3.6562494e+00	
   5.9053232e-01	
  -2.7442264e+00	
   6.0380813e+00	
  -1.0052809e+00	
   2.2853273e+00	
  -3.3989798e-01	
   3.2854823e+00	
   8.0590282e-01	
  -1.1912402e+00	
   1.9040376e-01	
  -2.6286713e-01	
   3.5425334e+00	
   1.7697764e+00	
   9.1979417e-01	
  -1.5071112e+00	
  -2.1302744e+00	
   1.6378058e+00	
   3.6754601e+00	
  -2.0260087e+00	
  -3.1903933e+00	
   4.3056702e+00	
   2.5469396e-01	
  -2.0049928e+00	
  -3.1270937e+00	
   3.0942930e+00	
   3.8204116e+00	
   4.4423069e+00	
   1.5779188e+00	
   2.0814637e-01	
   5.3501085e+00	
   3.1586734e+00	
  -4.3766129e+00	
  -3.6081000e-02	
EOF
gmt pstext -R -J -O -K -N -Dj0/0.05i -F+f11p,Times-Roman+jTC << EOF >> $FIG.ps
2 -0.1 L@-2@-
4.3 -0.1 LMS
EOF
gmt psxy -R -J -O -K -N -Sc0.05i -Gwhite -W0.25p << EOF >> $FIG.ps
2.1693 0
3.4 0
EOF
gmt psxy -R-2/7/0/200 -J -O -K -B0 -BWS -W1p,4_1:0p -X2.75i --MAP_FRAME_TYPE=graph << EOF >> $FIG.ps
  -1.0000000e+01	   6.9272468e+02	
  -9.7979798e+00	   6.7056072e+02	
  -9.5959596e+00	   6.4876778e+02	
  -9.3939394e+00	   6.2734586e+02	
  -9.1919192e+00	   6.0629495e+02	
  -8.9898990e+00	   5.8561507e+02	
  -8.7878788e+00	   5.6530621e+02	
  -8.5858586e+00	   5.4536836e+02	
  -8.3838384e+00	   5.2580154e+02	
  -8.1818182e+00	   5.0660573e+02	
  -7.9797980e+00	   4.8778095e+02	
  -7.7777778e+00	   4.6932718e+02	
  -7.5757576e+00	   4.5124444e+02	
  -7.3737374e+00	   4.3353271e+02	
  -7.1717172e+00	   4.1619201e+02	
  -6.9696970e+00	   3.9922232e+02	
  -6.7676768e+00	   3.8262365e+02	
  -6.5656566e+00	   3.6639600e+02	
  -6.3636364e+00	   3.5053938e+02	
  -6.1616162e+00	   3.3505377e+02	
  -5.9595960e+00	   3.1993918e+02	
  -5.7575758e+00	   3.0519561e+02	
  -5.5555556e+00	   2.9082306e+02	
  -5.3535354e+00	   2.7682153e+02	
  -5.1515152e+00	   2.6319102e+02	
  -4.9494949e+00	   2.4993153e+02	
  -4.7474747e+00	   2.3704306e+02	
  -4.5454545e+00	   2.2452561e+02	
  -4.3434343e+00	   2.1237918e+02	
  -4.1414141e+00	   2.0060377e+02	
  -3.9393939e+00	   1.8919938e+02	
  -3.7373737e+00	   1.7816600e+02	
  -3.5353535e+00	   1.6750365e+02	
  -3.3333333e+00	   1.5721232e+02	
  -3.1313131e+00	   1.4729200e+02	
  -2.9292929e+00	   1.3774271e+02	
  -2.7272727e+00	   1.2856444e+02	
  -2.5252525e+00	   1.1975718e+02	
  -2.3232323e+00	   1.1132095e+02	
  -2.1212121e+00	   1.0325573e+02	
  -1.9191919e+00	   9.5561537e+01	
  -1.7171717e+00	   8.8238361e+01	
  -1.5151515e+00	   8.1286205e+01	
  -1.3131313e+00	   7.4705068e+01	
  -1.1111111e+00	   6.8494952e+01	
  -9.0909091e-01	   6.2655854e+01	
  -7.0707071e-01	   5.7187777e+01	
  -5.0505051e-01	   5.2090719e+01	
  -3.0303030e-01	   4.7364681e+01	
  -1.0101010e-01	   4.3009662e+01	
   1.0101010e-01	   3.9025663e+01	
   3.0303030e-01	   3.5412684e+01	
   5.0505051e-01	   3.2170725e+01	
   7.0707071e-01	   2.9299785e+01	
   9.0909091e-01	   2.6799864e+01	
   1.1111111e+00	   2.4670964e+01	
   1.3131313e+00	   2.2913083e+01	
   1.5151515e+00	   2.1526222e+01	
   1.7171717e+00	   2.0510380e+01	
   1.9191919e+00	   1.9865558e+01	
   2.1212121e+00	   1.9591756e+01	
   2.3232323e+00	   1.9688973e+01	
   2.5252525e+00	   2.0157210e+01	
   2.7272727e+00	   2.0996466e+01	
   2.9292929e+00	   2.2206743e+01	
   3.1313131e+00	   2.3788039e+01	
   3.3333333e+00	   2.5740354e+01	
   3.5353535e+00	   2.8063690e+01	
   3.7373737e+00	   3.0758044e+01	
   3.9393939e+00	   3.3823419e+01	
   4.1414141e+00	   3.7259813e+01	
   4.3434343e+00	   4.1067227e+01	
   4.5454545e+00	   4.5245661e+01	
   4.7474747e+00	   4.9795114e+01	
   4.9494949e+00	   5.4715587e+01	
   5.1515152e+00	   6.0007079e+01	
   5.3535354e+00	   6.5669591e+01	
   5.5555556e+00	   7.1703123e+01	
   5.7575758e+00	   7.8107674e+01	
   5.9595960e+00	   8.4883246e+01	
   6.1616162e+00	   9.2029836e+01	
   6.3636364e+00	   9.9547447e+01	
   6.5656566e+00	   1.0743608e+02	
   6.7676768e+00	   1.1569573e+02	
   6.9696970e+00	   1.2432640e+02	
   7.1717172e+00	   1.3332808e+02	
   7.3737374e+00	   1.4270079e+02	
   7.5757576e+00	   1.5244452e+02	
   7.7777778e+00	   1.6255927e+02	
   7.9797980e+00	   1.7304504e+02	
   8.1818182e+00	   1.8390182e+02	
   8.3838384e+00	   1.9512963e+02	
   8.5858586e+00	   2.0672846e+02	
   8.7878788e+00	   2.1869830e+02	
   8.9898990e+00	   2.3103917e+02	
   9.1919192e+00	   2.4375106e+02	
   9.3939394e+00	   2.5683396e+02	
   9.5959596e+00	   2.7028789e+02	
   9.7979798e+00	   2.8411283e+02	
   1.0000000e+01	   2.9830880e+02	
EOF
gmt psxy -R -J -O -K -W1p << EOF >> $FIG.ps
  -1.0000000e+01	   7.9790707e+02	
  -9.7979798e+00	   7.7259083e+02	
  -9.5959596e+00	   7.4768270e+02	
  -9.3939394e+00	   7.2318270e+02	
  -9.1919192e+00	   6.9909082e+02	
  -8.9898990e+00	   6.7540706e+02	
  -8.7878788e+00	   6.5213142e+02	
  -8.5858586e+00	   6.2926390e+02	
  -8.3838384e+00	   6.0680451e+02	
  -8.1818182e+00	   5.8475323e+02	
  -7.9797980e+00	   5.6311008e+02	
  -7.7777778e+00	   5.4187505e+02	
  -7.5757576e+00	   5.2104814e+02	
  -7.3737374e+00	   5.0062936e+02	
  -7.1717172e+00	   4.8061869e+02	
  -6.9696970e+00	   4.6101615e+02	
  -6.7676768e+00	   4.4182172e+02	
  -6.5656566e+00	   4.2303542e+02	
  -6.3636364e+00	   4.0465725e+02	
  -6.1616162e+00	   3.8668719e+02	
  -5.9595960e+00	   3.6912525e+02	
  -5.7575758e+00	   3.5197144e+02	
  -5.5555556e+00	   3.3522575e+02	
  -5.3535354e+00	   3.1888818e+02	
  -5.1515152e+00	   3.0295873e+02	
  -4.9494949e+00	   2.8743740e+02	
  -4.7474747e+00	   2.7232419e+02	
  -4.5454545e+00	   2.5761911e+02	
  -4.3434343e+00	   2.4332215e+02	
  -4.1414141e+00	   2.2943330e+02	
  -3.9393939e+00	   2.1595258e+02	
  -3.7373737e+00	   2.0287999e+02	
  -3.5353535e+00	   1.9021551e+02	
  -3.3333333e+00	   1.7795916e+02	
  -3.1313131e+00	   1.6611092e+02	
  -2.9292929e+00	   1.5467081e+02	
  -2.7272727e+00	   1.4363882e+02	
  -2.5252525e+00	   1.3321640e+02	
  -2.3232323e+00	   1.2316651e+02	
  -2.1212121e+00	   1.1334391e+02	
  -1.9191919e+00	   1.0392944e+02	
  -1.7171717e+00	   9.5221836e+01	
  -1.5151515e+00	   8.6609774e+01	
  -1.3131313e+00	   7.8405832e+01	
  -1.1111111e+00	   7.1389567e+01	
  -9.0909091e-01	   6.4222675e+01	
  -7.0707071e-01	   5.8017414e+01	
  -5.0505051e-01	   5.1696509e+01	
  -3.0303030e-01	   4.5610122e+01	
  -1.0101010e-01	   4.0210705e+01	
   1.0101010e-01	   3.4799272e+01	
   3.0303030e-01	   3.0606659e+01	
   5.0505051e-01	   2.7481236e+01	
   7.0707071e-01	   2.4144269e+01	
   9.0909091e-01	   2.2302934e+01	
   1.1111111e+00	   1.9196758e+01	
   1.3131313e+00	   1.5977317e+01	
   1.5151515e+00	   1.3666599e+01	
   1.7171717e+00	   1.1416349e+01	
   1.9191919e+00	   8.8913991e+00	
   2.1212121e+00	   7.4173886e+00	
   2.3232323e+00	   6.1777781e+00	
   2.5252525e+00	   5.5818054e+00	
   2.7272727e+00	   4.7464858e+00	
   2.9292929e+00	   4.3878037e+00	
   3.1313131e+00	   4.6350159e+00	
   3.3333333e+00	   5.2121869e+00	
   3.5353535e+00	   5.5152712e+00	
   3.7373737e+00	   7.1147044e+00	
   3.9393939e+00	   9.2054147e+00	
   4.1414141e+00	   1.2001378e+01	
   4.3434343e+00	   1.4967401e+01	
   4.5454545e+00	   1.8463975e+01	
   4.7474747e+00	   2.2364701e+01	
   4.9494949e+00	   2.6841333e+01	
   5.1515152e+00	   3.1726086e+01	
   5.3535354e+00	   3.7018962e+01	
   5.5555556e+00	   4.2719958e+01	
   5.7575758e+00	   4.8829077e+01	
   5.9595960e+00	   5.5346317e+01	
   6.1616162e+00	   6.2271678e+01	
   6.3636364e+00	   6.9605161e+01	
   6.5656566e+00	   7.7346766e+01	
   6.7676768e+00	   8.5496492e+01	
   6.9696970e+00	   9.4054341e+01	
   7.1717172e+00	   1.0302031e+02	
   7.3737374e+00	   1.1239440e+02	
   7.5757576e+00	   1.2217661e+02	
   7.7777778e+00	   1.3236695e+02	
   7.9797980e+00	   1.4296540e+02	
   8.1818182e+00	   1.5397198e+02	
   8.3838384e+00	   1.6538668e+02	
   8.5858586e+00	   1.7720950e+02	
   8.7878788e+00	   1.8944045e+02	
   8.9898990e+00	   2.0207951e+02	
   9.1919192e+00	   2.1512670e+02	
   9.3939394e+00	   2.2858200e+02	
   9.5959596e+00	   2.4244543e+02	
   9.7979798e+00	   2.5671698e+02	
   1.0000000e+01	   2.7139666e+02	
EOF
gmt psxy -R -J -O -K -W0.5p << EOF >> $FIG.ps
> L2
2.1693 0
2.1693 200
> LMS
2.9886 0
2.9886 200
EOF
gmt pstext -R -J -O -N -Dj0/0.05i -F+f11p,Times-Roman+jTC << EOF >> $FIG.ps
2 -0.1 L@-2@-
3.5 -0.1 LMS
EOF
#-------------------------------------------------
# Post-processing

if ($#argv == 1) then
	gv $FIG.ps &
endif
