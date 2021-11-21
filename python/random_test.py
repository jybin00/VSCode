print(min(18,17,15))

x = [1,2,3,3,3,4]
cur_x = 5
dir_x = 0
cur_y = 5
y = [3,3,3,4,5,5]
#x.reverse()
#y.reverse()
print(x)
print(x[-1])

for i in range(0, len(x)):
    past_x = x.pop()
    past_y = y.pop()
    dir_x = past_x - cur_x
    cur_x = past_x
    dir_y = past_y - cur_y
    cur_y = past_y
    print("dx :"+str(dir_x))
    print(cur_x)
    print("dy :"+str(dir_y))
    print(cur_y)
print(x)
print(y)

a = [[0 for i in range(17)]for j in range(17)]
a[1][1] = 1
print(a)
for i in range(17):
    print(a[i])
    a[0][i] = 1
print(a)
for i in range(17):
    a[0][i] = 1
    a[16][i] = 1
    a[i][0] = 1
    a[i][16] = 1
print(a)
for i in range(5):
    print("hi")
a = [[0 for i in range(10)]for j in range(2)]
a[0][0] = 1
print(a)
b = 1
for i in range(5):
    print(i)