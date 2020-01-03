load GK2007_normal.txt;
load GK2007_reverse.txt;
b=0:0.25:40;
histogram (GK2007_normal, b)
pause
histogram (GK2007_reverse,b )
pause
histogram ([GK2007_reverse; GK2007_normal],b )
pause
b = -2.5:0.1:2.5;
histogram (log10([GK2007_reverse; GK2007_normal]), b)
