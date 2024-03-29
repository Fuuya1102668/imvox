#!/bin/sh

#yearMonth=`date +%y%m`
yearMonth=$1
#day=`date +%d`
day=$2

num=100
folder=/home/ppr/voicevox/itmedia/${yearMonth}${day}/text/*
mkdir /home/ppr/voicevox/itmedia/${yearMonth}${day}/wave/

for filePath in ${folder}
do
	cat ${filePath} | while read line
	do
		fileName=`basename ${filePath}`
		echo ${line} > temp
		curl -s \
		    -X POST \
		    "localhost:50021/audio_query?speaker=1"\
		    --get --data-urlencode text@temp \
		    > /home/ppr/voicevox/itmedia/${yearMonth}${day}/text/query.json

		echo ${num} ${filePath}...

		curl -s \
		    -H "Content-Type: application/json" \
		    -X POST \
		    -d @/home/ppr/voicevox/itmedia/${yearMonth}${day}/text/query.json \
		    "localhost:50021/synthesis?speaker=1" \
		    > /home/ppr/voicevox/itmedia/${yearMonth}${day}/wave/${fileName}_${num}.wav

		((num++))
	done
done

