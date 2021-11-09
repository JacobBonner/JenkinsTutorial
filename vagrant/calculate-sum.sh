#!/bin/bash
if [ $# -lt 1 ]; then
    echo "Must provided at least two numbers to add!"
    exit 1
fi

echo "Calculating the sum of the $# provided numbers ..."

sum=$((0))
sumStr=""
for arg in "$@"
do
    sum=$(($sum+$arg))
    
    if [ ${#sumStr} -eq 0 ]; then
        sumStr=$arg
    else
        sumStr="$sumStr + $arg"
    fi
done

echo "$sumStr = $sum"