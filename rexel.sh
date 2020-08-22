#!/bin/bash

dir_url=$1

curl_out=`curl -s $1 > curl_outfile`
directories=($(grep -o '".*\/"' curl_outfile))

for t in ${directories[@]}; do
    echo $dir_url${t:1:-1}
done
#echo $result

