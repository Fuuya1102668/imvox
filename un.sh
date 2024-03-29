#!/bin/sh

#yearMonth=`date +%y%m`
yearMonth=$1
#yearMonth="2209"
#day=`date +%d`
day=$2
#day="26"

mkdir /home/ppr/voicevox/itmedia/${yearMonth}${day}
mkdir /home/ppr/voicevox/itmedia/${yearMonth}${day}/text

for i in $(seq -w 300)
do
	echo ${i}
	curl https://www.itmedia.co.jp/news/articles/${yearMonth}/${day}/news${i}.html | iconv -f shift_jis -t utf-8 | grep -oP '(?<=<p>).*(?=</p>)' > /home/ppr/voicevox/itmedia/${yearMonth}${day}/text/news${i}
	curl https://www.itmedia.co.jp/mobile/articles/${yearMonth}/${day}/news${i}.html | iconv -f shift_jis -t utf-8 | grep -oP '(?<=<p>).*(?=</p>)' > /home/ppr/voicevox/itmedia/${yearMonth}${day}/text/mobile${i}
	curl https://www.itmedia.co.jp/pcuser/articles/${yearMonth}/${day}/news${i}.html | iconv -f shift_jis -t utf-8 | grep -oP '(?<=<p>).*(?=</p>)' > /home/ppr/voicevox/itmedia/${yearMonth}${day}/text/pcuser${i}
done

find -empty -delete /home/ppr/voicevox/itmedia/${yearMonth}${day}/text

bash encode.sh $1 $2

