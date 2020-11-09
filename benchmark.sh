#!/bin/bash
SLN="SanitisedNet471"
REPEATS=50

mytime=$(date -u)
mydir=$(realpath "`dirname \"$0\"`")

results0=$mydir/"results0.txt"
results1=$mydir/"results1.txt"
global=$mydir/"global.json"
global0=$mydir/"global0.json"
global1=$mydir/"global1.json"

# Makes sure that there are no dangling dotnet processes left after each restore 
export MSBUILDDISABLENODEREUSE=1

# exit when any command fails
set -e

# Read the dotnet version
cp $global0 $global
version0=$(cd $mydir/$SLN && dotnet --version)

cp $global1 $global
version1=$(cd $mydir/$SLN && dotnet --version)

# Insert test run markers
echo "Starting the benchmark. mydir=$mydir, SLN=$SLN, Version=$version0, Repeats=$REPEATS, Time=$mytime" >> $results0
echo "Starting the benchmark. mydir=$mydir, SLN=$SLN, Version=$version1, Repeats=$REPEATS, Time=$mytime" >> $results1

dt=0
dt0=0
dt1=0
i=0
while [[ $i -le $REPEATS ]]
do
	if [ $i -gt 0 ]
	then
		eta=$(echo "($dt0 + $dt1) * ($REPEATS - $i + 1)"| bc)
		echo "$i, $dt0, $dt1, ETA:$eta"
	else
		echo "warmup run"
	fi
	
	##############
	# Prepare 0
	##############
	cp $global0 $global
	(cd $mydir/$SLN && git clean -fxd) >> /dev/null
	sleep 5

	##############
	# Measure 0
	##############
	starttime0=$(date +%s.%N)

	##############
	# Command 0
	##############
	(cd $mydir/$SLN && dotnet restore -clp:summary) >> /dev/null

	endtime0=$(date +%s.%N)
	dt0=$(echo "$endtime0 - $starttime0" | bc)

	if [ $i -gt 0 ]
	then
		echo "$dt0" >> $results0
	else
		echo "warmup run:$dt0" >> $results0
	fi
	
	##############
	# Prepare 1
	##############
	cp $global1 $global
	(cd $mydir/$SLN && git clean -fxd) >> /dev/null
	sleep 5

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

	
    let i=i+1 
done