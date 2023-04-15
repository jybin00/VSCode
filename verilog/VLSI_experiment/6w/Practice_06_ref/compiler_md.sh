#! /bin/sh
echo
echo "베릴로그 컴파일러"
echo
path="${1#*6w/}"     # n주차 폴더에는 6을 n으로 바꾸면 됨.
path="${path%%/*}"   # 여기서 / 앞 부분 가져오기
echo "${path}"
cd ${path}

file_name= basename ${1}
file_name= "${file_name%%.v*}"
# #*{특정 문자열} => 해당 문자열 뒷 부분 가져오기.
#file_name="${file_name%%.v*}" # %%{특정 문자열}* => 해당 문자열 기준 앞 부분 가져오기.
echo "${file_name}"

vvp=".vvp"
v=".v"

filename_v=$file_name$v
filename_vvp=$file_name$vvp

iverilog -o $filename_vvp $filename_v
sleep .5
vvp $filename_vvp
sleep .5

echo
echo done


