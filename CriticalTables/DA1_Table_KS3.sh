#!/bin/bash
# Make the table rows for the critical values for K-S and Lilliefors distributions
# These are included in the Appendix for critical values via \input{DA1_Table_KS1,2,3}

if [ -f DA1_Table_KS3.tex ]; then
	echo "Found existing DA1_Table_KS3.tex"
else
	echo "Making DA1_Table_KS3.tex"
	cat << EOF >  DA1_Table_KS3.tex
\\bf{1}	 &   *  &   *   &   *   &   *   &   *   &   *   &   *   &   *    &   *    &   *    \\\\
	 &   *  &   *   &   *   &   *   &   *   &   *   &   *   &   *    &   *    &   *    \\\\ \\hline
\\bf{2}	 &   *  &   *   &   *   &   *   &   *   & 16/16	& 18/18	& 20/20	 & 22/22  & 24/24  \\\\
	 &   *  &   *   &   *   &   *   &   *   &   *   &   *   &   *    &   *    &   *    \\\\ \\hline
\\bf{3}	 &   *  &   *   & 15/15	& 18/18	& 21/21	& 21/24	& 24/27	& 27/30	 & 30/33  & 30/36  \\\\
	 &   *  &   *   &   *   &   *   &   *   & 24/24	& 27/27	& 30/30	 & 33/33  & 36/36  \\\\ \\hline
\\bf{4}	 & 	& 16/16	& 20/20	& 20/24	& 24/28	& 28/32	& 28/36	& 30/40	 & 33/44  & 36/48  \\\\
	 & 	&   *   &   *   & 24/24	& 28/28	& 32/32	& 32/36	& 36/40	 & 40/44  & 44/48  \\\\ \\hline
\\bf{5}	 & 	& 	&   *   & 24/30	& 30/35	& 30/40	& 35/45	& 40/50	 & 39/55  & 43/60  \\\\
	 & 	& 	&   *   & 30/30	& 35/35	& 35/40	& 40/45	& 45/50	 & 45/55  & 50/60  \\\\ \\hline
\\bf{6}	 & 	& 	& 	& 30/36	& 30/42	& 34/48	& 39/54	& 40/60	 & 43/66  & 48/72  \\\\
	 & 	& 	& 	& 36/36	& 36/42	& 40/48	& 45/54	& 48/60	 & 54/66  & 60/72  \\\\ \\hline
\\bf{7}	 & 	& 	& 	& 	& 42/49	& 40/56	& 42/63	& 46/70	 & 48/77  & 53/84  \\\\
	 & 	& 	& 	& 	& 42/49	& 48/56	& 49/63	& 53/70	 & 59/77  & 60/84  \\\\ \\hline
\\bf{8}	 & 	& 	& 	& 	& 	& 48/64	& 46/72	& 48/80	 & 53/88  & 60/96  \\\\
	 & 	& 	& 	& 	& 	& 56/64	& 55/72	& 60/80	 & 64/88  & 68/96  \\\\ \\hline
\\bf{9}	 & 	& 	& 	& 	& 	& 	& 54/81	& 53/90	 & 59/99  & 63/108 \\\\
	 & 	& 	& 	& 	& 	& 	& 63/81	& 70/90	 & 70/99  & 75/108 \\\\ \\hline
\\bf{10} & 	& 	& 	& 	& 	& 	& 	& 70/100 & 60/110 & 66/120 \\\\
	 & 	& 	& 	& 	& 	& 	& 	& 80/100 & 77/110 & 80/120 \\\\ \\hline
\\bf{11} & 	& 	& 	& 	& 	& 	& 	& 	 & 77/121 & 72/132 \\\\
	 & 	& 	& 	& 	& 	& 	& 	& 	 & 88/121 & 86/132 \\\\ \\hline
\\bf{12} & 	& 	& 	& 	& 	& 	& 	& 	 & 	  & 96/144 \\\\
	 & 	& 	& 	& 	& 	& 	& 	& 	 & 	  & 84/144 \\\\ \\hline
EOF
fi
										