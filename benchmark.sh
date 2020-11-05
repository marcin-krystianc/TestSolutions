#!/bin/bash
SLN="SanitisedNet471"
REPEATS=2

mytime=$(date -u)
mydir=$(realpath "`dirname \"$0\"`")

results1=$mydir/"results1.txt"
results2=$mydir/"results2.txt"
global=$mydir/"global.json"
global1=$mydir/"global1.json"
global2=$mydir/"global2.json"

# exit when any command fails
set -e

# Read the dotnet version
cp $global1 $global
version1=$(cd $mydir/$SLN && dotnet --version)

cp $global2 $global
version2=$(cd $mydir/$SLN && dotnet --version)

# Insert test run markers
echo "Starting the benchmark. mydir=$mydir, SLN=$SLN, Version=$version1, Repeats=$REPEATS, Time=$mytime" >> $results1
echo "Starting the benchmark. mydir=$mydir, SLN=$SLN, Version=$version2, Repeats=$REPEATS, Time=$mytime" >> $results2

dt=
i=0
while [[ $i -le $REPEATS ]]
do
	if [ $i -gt 0 ]
	then
		eta=$(echo "($dt1 + $dt2) * ($REPEATS - $i + 1)"| bc)
		echo "ETA:$eta"
	else
		echo "warmup run"
	fi
	
	##############
	# Prepare 1
	##############
	cp $global1 $global
	(cd $mydir/$SLN && git clean -fxd) >> /dev/null

	##############
	# Measure 1
	##############
	starttime1=$(date +%s.%N)

	##############
	# Command 1
	##############
	(cd $mydir/$SLN && dotnet restore -clp:summary) >> /dev/null

	endtime1=$(date +%s.%N)
	dt1=$(echo "$endtime1 - $starttime1" | bc)

	if [ $i -gt 0 ]
	then
		echo "$dt1" >> $results1
	else
		echo "warmup run:$dt1" >> $results1
	fi
	
	##############
	# Prepare 2
	##############
	cp $global2 $global
	(cd $mydir/$SLN && git clean -fxd) >> /dev/null

	##############
	# Measure 2
	##############
	starttime2=$(date +%s.%N)

	##############
	# Command 1
	##############
	(cd $mydir/$SLN && dotnet restore -clp:summary) >> /dev/null

	endtime2=$(date +%s.%N)
	dt2=$(echo "$endtime2 - $starttime2" | bc)
	
	if [ $i -gt 0 ]
	then
		echo "$dt2" >> $results2
	else
		echo "warmup run:$dt2" >> $results2
	fi

	
    let i=i+1 
done