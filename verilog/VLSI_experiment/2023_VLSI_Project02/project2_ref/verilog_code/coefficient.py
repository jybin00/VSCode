

vector = [8 ,8 ,8 ,8 ,7 ,7 ,7, 7 ,7 ,7 ,7 ,7 ,7, 7 ,7 ,7]
total_num = 116
measure = 12
for i in range(0, len(vector)):
    diff_num = total_num - vector[i]
    if vector[i] < 12:
        iter = measure - vector[i]
        print("{{{{{0:01d}{{a15[{1:03d}-1]}}}},a15[{2:03d}-1:{3:03d}]}}".format(iter,total_num, total_num, diff_num))
    else:
        print("{{a15[{0:03d}-1:{1:03d}]}}".format(total_num, diff_num))
    total_num = diff_num
        
        