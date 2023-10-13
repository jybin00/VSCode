#! /bin/sh

out=".out"

echo "C++ version 14 compiler"
echo 
path=$(dirname ${1})
echo "$path"

if [ -f "$path" ]; then
    echo "유형 : file입니당"
else
    cd ${path}
    echo "유형 : 폴더 입니당(${path})"
fi
#echo "파일 이름을 입력해주세요! (확장자 없이!)"
#read filename

# #*{특정 문자열} => 해당 문자열 뒷 부분 가져오기.
file_name="${1#*$path/}"
file_name="${file_name%%.c*}" 
# %%{특정 문자열}* => 해당 문자열 기준 앞 부분 가져오기.
echo "compile file : ${file_name}"

filename_out=$file_name$out

sleep .5

#open -a Scansion $filename_vcd
./$filename_out
echo "done"