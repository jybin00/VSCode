#! /bin/sh
echo
echo "2023 VLSI 설계 및 실험 베릴로그 컴파일러"

path=$(dirname ${1})
echo "$path"
#path="${1#*${2}/}"     # n주차 폴더에는 6을 n으로 바꾸면 됨.
#path="${path%%/*}"   # 여기서 / 앞 부분 가져오기

if [ -f "$path" ]; then
    echo "유형 : file입니당"
else
    cd ${path}
    echo "유형 : 폴더 입니당(${path})"
fi

echo

# #*{특정 문자열} => 해당 문자열 뒷 부분 가져오기.
file_name="${1#*$path/}"
file_name="${file_name%%.v*}" 
# %%{특정 문자열}* => 해당 문자열 기준 앞 부분 가져오기.
echo "compile file : ${file_name}"

vvp=".vvp"
v=".v"
filename_v="$file_name$v"

filename_v="$file_name$v"
filename_vvp="$file_name$vvp"

iverilog -o $filename_vvp $filename_v
sleep .5
vvp $filename_vvp
sleep .5

echo
echo done


