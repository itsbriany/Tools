#!/bin/bash

# Copyright (C) 2015 itsbriany

# Finds the field offset containing the specified field via a specified delimiter in a file 
# Usage ./find_field.sh <SEARCH LIMIT> <DELIMETER> <TARGET> <INPUT FILE>

# Example: The input file contains A.B.C.D
# ./find_field.sh 5 \. C MyInputFile
# Target found at field 3 

INDEX=1
SEARCH_LIMIT=$1
DELIMETER=$2
TARGET=$3
INPUT=$4

if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
  echo "Usage: ./find_field.sh <SEARCH LIMIT> <DELIMETER> <TARGET> <INPUT FILE>"
  exit 1
fi

if [ -z "$4" ]; then
  echo "Usage: ./find_field.sh <SEARCH LIMIT> <DELIMETER> <TARGET> <INPUT FILE>"
  exit 1
fi
  

while [ $INDEX -le $SEARCH_LIMIT ];
do
  FIELD=$(cut -d $DELIMETER -f$INDEX $INPUT) 2> /dev/null 
  if [ "$TARGET" == "$FIELD" ]
  then
    echo Target found at field $INDEX
    exit 1
  fi
  INDEX=$(($INDEX+1))
done

echo Could not find $TARGET in $INPUT
