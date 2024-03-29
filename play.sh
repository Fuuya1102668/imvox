#!/bin/sh

#yearMonth=`date +%y%m`
#day=`date +%d`

folder=/home/fuuya/voicevox/itmedia/$1/wave/*

for filePath in ${folder}
do
	echo ${filePath}
	aplay -q ${filePath}
done
