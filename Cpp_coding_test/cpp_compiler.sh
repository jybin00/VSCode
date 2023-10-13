#! /bin/sh
echo
echo "C++ version 14 compiler"

path=$(dirname ${1})
echo "$path"

if [ -f "$path" ]; then
    echo "유형 : file입니당"
else
    cd ${path}
    echo "유형 : 폴더 입니당(${path})"
fi

echo

# #*{특정 문자열} => 해당 문자열 뒷 부분 가져오기.
file_name="${1#*$path/}"
file_name="${file_name%%.c*}" 
# %%{특정 문자열}* => 해당 문자열 기준 앞 부분 가져오기.
echo "compile file : ${file_name}"

cpp=".cpp"
out=".out"

filename_cpp="$file_name$cpp"
filename_out="$file_name$out"

g++ -g -std=c++14 -Wall $filename_cpp -o $filename_out

echo
echo done