#!/bin/bash

set -e

FILE_LIST="$1"
NUMBER_ZEROS="$2"
TARGET="renamed/"

if [[ $# -ne 2 ]]; then
    echo -e "ERROR: Incorrect number of arguments supplied!"
    echo "Usage: rename.sh <file of filenames to rename> <desired padded length>"
    exit 2
fi

while read line; do
    filename=`basename "$line"`
    path=`echo "$line" | sed "s|$filename||g"`
    destination="$path$TARGET"
    mkdir -p "$destination"

    echo "Transforming: $filename"
    number=`echo "$filename" | awk '{ print $1 }'`
    padded_num=`printf "%0$NUMBER_ZEROS.0f" $number`
    new_name=`echo "$filename" | sed "s|$number|$padded_num|g"`
    echo -e "To: $new_name\n"
    cp "$line" "$destination$new_name"
done < $FILE_LIST

