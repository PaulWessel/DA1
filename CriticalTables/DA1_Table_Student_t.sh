#!/bin/bash
# Make the table rows for the critical values for Student t distribution
# This is included in the Appendix for critical values via \input{DA1_Table_Student_t}
# It goes with Fig1_App_Student_t.csh
if [ -f DA1_Table_Student_t.tex ]; then
	echo "Found existing DA1_Table_Student_t.tex"
else
echo "Making DA1_Table_Student_t.tex"
gmt grdmath -R0.005/0.1/1/30 -I0.005/1 1 X SUB Y TCRIT = t.nc
cat << EOF > t.skip
0.095	
0.09	
0.085	
0.08	
0.075	
0.07	
0.065	
0.06	
0.055	
0.045	
0.04	
0.035	
0.03	
0.02	
0.015	
EOF
cat << EOF > t.awk
{
	if (\$1 == 0.1) {
		if (\$3 > 9.999)
			printf "%s\t&\t%.2f\t&\t", \$2, \$3
		else
			printf "%s\t&\t%.3f\t&\t", \$2, \$3
	}
	else if (\$1 == 0.005 && \$2 == 999999) {
		if (\$3 > 9.999)
			printf "%.2f \\\\\\\\ \\\\hline\n", \$3
		else
			printf "%.3f \\\\\\\\ \\\\hline\n", \$3
	}
	else if (\$1 == 0.005) {
		if (\$3 > 9.999)
			printf "%.2f \\\\\\\\\n", \$3
		else
			printf "%.3f \\\\\\\\\n", \$3
	}
	else {
		if (\$3 > 9.999)
			printf "%.2f\t&\t", \$3
		else
			printf "%.3f\t&\t", \$3
	}
}
EOF
cat << EOF > t.txt
0.1  	0.1
0.05 	0.05
0.025	0.025
0.01 	0.01
0.005	0.005
EOF
gmt grd2xyz t.nc | grep -v -f t.skip | tail -r | awk -f t.awk > DA1_Table_Student_t.tex
gmt math 1 t.txt SUB ZCRIT = | awk '{print $1, 999999, $2}' | awk -f t.awk | sed -e 's/999999/\$\\infty\$/g' >> DA1_Table_Student_t.tex
rm -f t.awk t.txt t.nc t.skip
fi