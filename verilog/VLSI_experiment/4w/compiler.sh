#! /bin/sh
echo
echo "베릴로그 컴파일러"
echo
echo "컴파일할 파일을 입력해주세요 (띄어쓰기 없이! + 파일 이름만!)"
read filename
echo

v=".v"
vvp=".vvp"

filename_v=$filename$v
filename_vvp=$filename$vvp

iverilog -o $filename$vvp $filename_v
sleep .5
vvp $filename$vvp
sleep .5

echo done


