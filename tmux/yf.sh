# Prints the name of the current day.

run_segment() {
	#echo `date`
	echo `http -b get http://mymymy.herokuapp.com/rate/usdjpy` | sed -e "s/[\"\n]//g"
	return 0
}
