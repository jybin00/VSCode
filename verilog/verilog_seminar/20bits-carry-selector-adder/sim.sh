#! /bin/sh

vcd=".vcd"

echo "베릴로그 시뮬레이터"
echo 
echo "파일 이름을 입력해주세요! (확장자 없이!)"
read filename
filename_vcd=$filename$vcd
echo $filename_vcd

sleep .5

# open -a Scansion $filename_vcd
open -a GTKWave $filename_vcd

echo "done"