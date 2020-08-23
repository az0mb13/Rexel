#!/bin/bash

SAVEIFS=$IFS
IFS=$'\n'
dir_url=$1

declare -A dir_list

curl_out=`curl -s $1 > curl_outfile`
dir_names=($(grep -o '">.*<' curl_outfile))
dir_urls=($(grep -o '".*\/"' curl_outfile))


for ((i=0;i<${#dir_names[@]}; i++)); do
    dir_list[${dir_names[$i]:2:-2}]=$dir_url${dir_urls[$i]:1:-1}
done

for key in "${!dir_list[@]}"; do
    echo "$key => ${dir_list[$key]}";
done
