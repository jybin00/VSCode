#! /bin/bash

echo "bash script test!"

A=10
B=20

echo "A=$A"
echo "B=$B"

result=`expr $A + $B`
echo "A+B=$result"