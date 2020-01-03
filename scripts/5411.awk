BEGIN { sum = 0.0}
{
	print $1, sum/48
	sum += 1.0
	print $1, sum/48
}
