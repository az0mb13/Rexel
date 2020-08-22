#!/bin/bash

SAVEIFS=$IFS
IFS=$'\n'
dir_url=$1

declare -A dir_list

curl_out=`curl -s $1 > curl_outfile`
dir_names=($(grep -o '">.*<' curl_outfile))
dir_urls=($(grep -o '".*\/"' curl_outfile))

for t in ${dir_names[@]}; do
    #echo $dir_url${t:1:-1}
    echo ${t:2:-2}
done
