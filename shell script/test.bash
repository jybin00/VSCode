#! /bin/bash

echo "bash script test!"

A=10
B=20

echo "A=$A"
echo "B=$B"

result=`expr $A + $B`
echo "A+B=$result"

echo -n "Input something: "

read input

echo "your input : $input"
echo "$input"

if [ "$input" == "hello" ]
then
        echo "문자열이 같습니다."
else
        echo "문자열이 다릅니다."
fi 