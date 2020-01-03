#!/bin/bash
# Make the table rows for the critical values for Chi-square distribution
# This is included in the Appendix for critical values via \input{DA1_Table_F_$a}
# It goes with Fig1_Table_F.csh
gmt math -T1/10/1  -o1 T = num.txt
gmt math -T15/25/5 -o1 T = >> num.txt
echo 50 >> num.txt
gmt math -T1/30/1 -o1 T = den.txt
gmt math -T40/140/10 -o1 T = >> den.txt
cat << EOF > F.awk
{
	if (\$1 >= 999.9)
		printf ("%5.0f\n", \$1)
	else if (\$1 >= 99.99)
		printf ("%5.1f\n", \$1)
	else if (\$1 > 9.999)
		printf ("%5.2f\n", \$1)
	else
		printf ("%5.3f\n", \$1)
}
EOF
last=150
for a in 0.1 0.05 0.025 0.01; do
	if [ -f DA1_Table_F_$a.tex ]; then
		echo "Found existing DA1_Table_F_$a.tex"
		continue
	fi
	echo "Making DA1_Table_F_$a.tex"
	touch DA1_Table_F_$a.tex
	while read den; do
		echo -n "\\bf{$den}" >> DA1_Table_F_$a.tex
		while read num; do
			Fc=`gmt math -Q 1 $a SUB $num $den FCRIT DUP 4 EXCH LOG10 FLOOR 1 ADD SUB 10 EXCH POW STO@X MUL RINT @X DIV = | awk -f F.awk`
			echo -n " & $Fc" >> DA1_Table_F_$a.tex
		done < num.txt
		echo " \\\\" >> DA1_Table_F_$a.tex
	done < den.txt
	# For last denominator 100 we add hline
	echo -n "\\bf{$last}" >> DA1_Table_F_$a.tex
	while read num; do
		Fc=`gmt math -Q 1 $a SUB $num $last FCRIT DUP 4 EXCH LOG10 FLOOR 1 ADD SUB 10 EXCH POW STO@X MUL RINT @X DIV = | awk -f F.awk`
		echo -n " & $Fc" >> DA1_Table_F_$a.tex
	done < num.txt
	echo " \\\\ \\hline" >> DA1_Table_F_$a.tex
done
rm -f num.txt den.txt F.awk
