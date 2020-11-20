#!/bin/bash

# 
# Written for godot by raptor

input_file=$1
output_buffer=""		# Output text
word_count=0			# Total number of words
words_done=0			# Number of words processed
langs=()				# List of languages

function transfunc()
{
	while read char 
	do
		# Skip empty strings
		if [ "$char" != "" ]
		then
			# Get key
			key=$(echo "$char" | awk -F "," '{print $1;}')
			# Get text
			text=$(echo "$char" | awk -F "," '{print $2;}') 
			# Trim spaces tabs and ""
		    text=$(echo "$text" | sed -e 's/^[ \t]*//g;s/\"//g')
			# Write to output buffer
		    output_buffer="$output_buffer\n$key,$text"
			for lang in "${langs[@]}"
			do
				tword=$(trans "$text" -t "$lang" -b)
				output_buffer="$output_buffer,$tword"
				# Show progress
				let words_done++
				echo -ne "Done  $words_done / $word_count"\\r
			done			
		fi
	done
	# Write output buffer to file
	echo -e $output_buffer > translation.csv	
}




# Get list of languages
counter=0
for i in "$@"
do
	if [ $counter -ne 0 ]
	then
	    langs+=("$i")
	fi
	counter=1
done

# calculate total number of words
let word_count=("$#"-1)*"$(cat $input_file | wc -l)"

# set buffer
output_buffer="keys,en"
for i in "${langs[@]}"
do
	output_buffer="$output_buffer,$i"
done

# Read and process input file
cat $input_file | transfunc
echo "Done -----------------------------"
