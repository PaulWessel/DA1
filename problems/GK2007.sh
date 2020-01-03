#!/bin/bash
# SPlit normal and reverse
awk '{ if (NR%2) print $2}' GK2007.txt > GK2007_normal.txt
awk '{ if (NR%2 == 0) print $2}' GK2007.txt > GK2007_reverse.txt
cat GK2007_normal.txt GK2007_reverse.txt > GK2007_all.txt
