#!/bin/bash

# 
# Written for godot by raptor

input_file=$1
output_buffer=""		# Output text
langs=()				# List of languages

function transfunc()
{
	# file is in format : key, "en-value"
	# This function converts file into : key,en-value,l1-value,l2-value.....
	
	transTexts=()			# This will hold translated value
	text=""					# This will hold en value (values as text)
	keys=()					# This will hold keys
	values=()				# This will hold values (values in array)

	# Read keys and values
	while read char
	do
		# Skip empty strings
		if [ "$char" != "" ] && [ "$char" != "\n" ]
		then
			# Get key
			key=$(echo "$char" | awk -F "," '{print $1;}')
			# Get Value
			value=$(echo "$char" | awk -F "," '{print $2;}') 
			# append value to text
			text="$text$value,"
			keys+=($key)
			# remove ""
			value=$(echo $value | sed -e 's/^[ \t]*//g;s/\"//g')
			values+=("$value")
		fi
	done

	# Translate text to langs
	for lang in "${langs[@]}"
	do
		echo "Translating to $lang"
		# Translate text
		transTxt=$(trans "$text" -t "$lang" -b)
		# Split Text by ,
		IFS=','
		read -ra strings <<< "$transTxt"
		transTexts+=("${strings[@]}")
		echo "Done translation for $lang. Taking a 4 second pause..."
		sleep 4
	done
	
	IFS=''

	# Write to buffer
	for (( i=0; i<${#keys[@]}; i++ ))
	do
		# Add key and en text
		output_buffer="$output_buffer\n${keys[$i]},${values[$i]}"
		# Add lang texts
		for (( j=0; j<${#langs[@]}; j++ ))
		do
			let index=$i+${#keys[@]}*$j
			# Trim spaces tabs and ""
			value=$(echo "${transTexts[$index]}" | sed -e 's/^[ \t]*//g;s/\"//g')
			output_buffer="$output_buffer,$value"
		done
	done
	
	# Write output buffer to file
	echo -e $output_buffer > translation.csv
}

# Check arg count
if [ $# -lt 2 ]
then
	echo "Please provide additional arguments"
	echo "Usage : $0 file.txt [languages . . .]"
	echo "Example : $0 file.txt fr ru"
	exit
fi	


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

# set buffer
output_buffer="keys,en"
for i in "${langs[@]}"
do
	output_buffer="$output_buffer,$i"
done

# Read and process input file
cat $input_file | transfunc
echo "Done -----------------------------"
echo "File saved as translation.csv"
