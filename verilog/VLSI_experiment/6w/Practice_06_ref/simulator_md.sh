#! /bin/sh

vcd=".vcd"

echo "2023 VLSI 설계 및 실험 베릴로그 시뮬레이터"
echo 
path="${1#*${2}/}"     # n주차 폴더에는 6을 n으로 바꾸면 됨.
path="${path%%/*}"   # 여기서 / 앞 부분 가져오기


if [ -f "$path" ]; then
    echo "유형 : file입니당"
else
    cd ${path}
    echo "유형 : 폴더 입니당(${path})"
fi
#echo "파일 이름을 입력해주세요! (확장자 없이!)"
#read filename

# #*{특정 문자열} => 해당 문자열 뒷 부분 가져오기.
file_name="${1#*${3}/}"
file_name="${file_name%%.v*}" 
# %%{특정 문자열}* => 해당 문자열 기준 앞 부분 가져오기.
echo "simul file : ${file_name}"

filename_vcd=$file_name$vcd

sleep .5

#open -a Scansion $filename_vcd
open -a Gtkwave $filename_vcd
echo "done"