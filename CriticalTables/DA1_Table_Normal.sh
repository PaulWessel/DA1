#!/bin/bash
# Make the table rows for the area under the Normal distribution
# This is included in the Appendix for critical values via \input{DA1_Table_Normal}
# It goes with Fig1_App_Normal.csh
if [ -f DA1_Table_Normal.tex ]; then
	echo "Found existing DA1_Table_Normal.tex"
else
echo "Making DA1_Table_Normal.tex"
rm -f DA1_Table_Normal.tex
gmt math -T-3.4/0/0.1 -o1 T ABS = | awk '{printf "\\bf{-%.1f}\n", $1}' > DA1_Table_Normal.tex
for D in 0.09 0.08 0.07 0.06 0.05 0.04 0.03 0.02 0.01; do
	gmt math -T-3.4/0/0.1 -o1 T $D SUB ZCDF 10000 MUL RINT = | awk '{printf " & .%4.4d\n", $1}' > tmp
	paste -d' ' DA1_Table_Normal.tex tmp > new
	mv new DA1_Table_Normal.tex
done
gmt math -T-3.4/0/0.1 -o1 T ZCDF 10000 MUL RINT = | awk '{printf " & .%4.4d \\\\ \\hline\n", $1}' > tmp
paste -d' ' DA1_Table_Normal.tex tmp > new
mv new DA1_Table_Normal.tex
rm -f tmp
fi
