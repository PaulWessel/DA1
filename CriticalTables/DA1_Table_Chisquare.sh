#!/bin/bash
# Make the table rows for the critical values for Chi-square distribution
# This is included in the Appendix for critical values via \input{DA1_Table_Chisquare}
# It goes with Fig1_App_Chisquare.csh
if [ -f DA1_Table_Chisquare.tex ]; then
	echo "Found existing DA1_Table_Chisquare.tex"
else
echo "Making DA1_Table_Chisquare.tex"
for a in 0.995 0.99 0.975 0.95 0.9 0.1 0.05 0.025 0.01 0.005; do
	gmt math -T1/30/1 $a = chi.txt
	gmt math -T40/100/10 $a = >> chi.txt
	gmt math -T1/30/1 T = n.txt
	gmt math -T40/100/10 T = >> n.txt
	gmt math chi.txt n.txt CHI2CRIT = chi.$a.txt
done
cat << EOF > c.awk
{
	for (i = 1; i <= NF; i++)
	{
		if (i%2)
			printf "%s\t", \$i
		else
			{
				if (\$i > 100)
					printf ("%5.1f\t", \$i)
				else if (\$i > 10)
					printf ("%5.2f\t", \$i)
				else
					printf ("%5.3f\t", \$i)
			}
	}
	printf "\n"
}
EOF
paste chi.0.005.txt chi.0.01.txt chi.0.025.txt chi.0.05.txt chi.0.1.txt chi.0.9.txt chi.0.95.txt chi.0.975.txt chi.0.99.txt chi.0.995.txt > chi.tmp1.txt
awk -f c.awk chi.tmp1.txt > chi.tmp2.txt
awk '{if ($1 < 100) {printf "\\bf{%d}\t&\t%s\t&\t%s\t&\t%s\t&\t%s\t&\t%s\t&\t%s\t&\t%s\t&\t%s\t&\t%s\t&\t%s \\\\\n", \
	$1, $2, $4, $6, $8, $10, $12, $14, $16, $18, $20}}' chi.tmp2.txt > DA1_Table_Chisquare.tex
awk '{if ($1 == 100) {printf "\\bf{%d}\t&\t%s\t&\t%s\t&\t%s\t&\t%s\t&\t%s\t&\t%s\t&\t%s\t&\t%s\t&\t%s\t&\t%s \\\\ \\hline\n", \
	$1, $2, $4, $6, $8, $10, $12, $14, $16, $18, $20}}' chi.tmp2.txt >> DA1_Table_Chisquare.tex
rm -f chi.txt chi.0.005.txt chi.0.01.txt chi.0.025.txt chi.0.05.txt chi.0.1.txt chi.0.9.txt chi.0.95.txt chi.0.975.txt chi.0.99.txt chi.0.995.txt
rm -f chi.tmp2.txt chi.tmp1.txt n.txt c.awk
fi
