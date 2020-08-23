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

inc=1
for key in "${!dir_list[@]}"; do
    echo "[$inc] $key";
    ((inc++))
done

read -p 'Enter directory number to navigate: ' choice
KEYS=("${!dir_list[@]}")
selected_key=${KEYS[$((choice-1))]} 
selected_value=${dir_list[$selected_key]}

printf '\n'

#for files

curl_out=`curl -s $selected_value > curl_outfile`
file_names=($(grep -o '">.*<' curl_outfile))
file_urls=($(grep -oP '(?<=href=").*(?=")' curl_outfile))
file_url=$selected_value

declare -A file_list

for ((i=0;i<${#file_names[@]}; i++)); do
    #echo "${file_names[$i]:2:-1} -----> $file_url${file_urls[$i]}"
    file_list[${file_names[$i]:2:-1}]=$file_url${file_urls[$i]}
done

incc=1
for key2 in "${!file_list[@]}"; do
    echo "[$incc] $key2";
    ((incc++))
done

read -p 'Select which file to download or Enter "A" to download all files: ' filechoice

if [ "$filechoice" = "A" ]; then
    mkdir $selected_key
    for dk in "${!file_list[@]}"; do
        echo "${file_list[$dk]}";
        cd $selected_key
        axel -n 8 -a ${file_list[$dk]}
    done
fi