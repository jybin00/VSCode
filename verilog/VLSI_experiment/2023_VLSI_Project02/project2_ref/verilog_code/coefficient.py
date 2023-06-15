

vector = [12 ,12 ,12 ,12 ,10 ,10 ,10,9 ,9 ,9 ,8 ,8 ,8, 9 ,8 ,8]
total_num = 154
measure = 12
for i in range(0, len(vector)):
    diff_num = total_num - vector[i]
    if vector[i] <12:
        print("{0:03d}-0:{1:03d}".format(total_num, diff_num))
    else:
        print("{0:03d}-1:{1:03d}".format(total_num, diff_num))
    total_num = diff_num
        
        