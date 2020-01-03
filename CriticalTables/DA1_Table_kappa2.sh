#!/bin/bash
# Make the table rows for kappa vs meanR lookup in 3-D
# These are included in the Appendix for critical values via \input{DA1_Table_kappa2}
# Based on inverting eq  3.35 in N.I. Fisher, Statistical analysis of circular data, 1993, Cambridge U. Press

cat << EOF > R2.awk
{
	if (\$2 > 99.9999)
		printf ("%3.2f\t%7.3f\n", \$1, \$2)
	else if (\$2 > 9.99999)
			printf ("%3.2f\t%7.4f\n", \$1, \$2)
	else
		printf ("%3.2f\t%7.5f\n", \$1, \$2)
}
EOF
if [ -f DA1_Table_kappa2.tex ]; then
	echo "Found existing DA1_Table_kappa2.tex"
else
	echo "Making DA1_Table_kappa2.tex"
	gmt math -T0.00001/51/0.00001 -o1,0 T I1 T I0 DIV = k.txt
	# First R = 0-0.33:
	echo "0.00	0.00000" > kr1.txt
	gmt math -T0.01/0.33/0.01 -o1 T = r.txt
	gmt sample1d k.txt -Tr.txt | awk -f R2.awk >> kr1.txt
	# Next R = 0.34-0.67:
	gmt math -T0.34/0.67/0.01 -o1 T = r.txt
	gmt sample1d k.txt -Tr.txt | awk -f R2.awk > kr2.txt
	# Last R = 0.68-1.00:
	gmt math -T0.68/0.99/0.01 -o1 T = r.txt
	gmt sample1d k.txt -Tr.txt | awk -f R2.awk > kr3.txt
	echo "1.00	$\infty$" >> kr3.txt
	echo "	" >> kr3.txt
	paste kr1.txt kr2.txt kr3.txt > kr.txt
	n=`cat kr.txt | wc -l | awk '{printf "%d\n", $1}'`
	awk '{if (NR < '"$n"') printf "%s & %s & %s & %s & %s & %s \\\\\n", $1, $2, $3, $4, $5, $6}' kr.txt > DA1_Table_kappa2.tex
	awk '{if (NR == '"$n"') printf "%s & %s & %s & %s & %s & %s \\\\ \\hline\n", $1, $2, $3, $4, $5, $6}' kr.txt >> DA1_Table_kappa2.tex
fi
rm -f R2.awk k.txt r.txt kr1.txt kr2.txt kr3.txt kr.txt
