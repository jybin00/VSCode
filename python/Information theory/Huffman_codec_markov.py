from collections import Counter  # 원소 카운트를 위한 라이브러리
import heapq
from heapq import heappush, heappop  # 최소값을 뽑기 위해서 힙 사용
import numpy as np  # 배열 쉽게 다루기 위해 numpy사용
import math
import tree_class

source_b = np.random.binomial(1, 1/2, size=1)  # Markov chain으로
source_b = source_b.tolist()


for i in range(1,1000):
    new_b = np.random.binomial(1, 3/4, size=1)
    if new_b == 1: # 같은 값으로 트랜지션
        source_b.append(1&source_b[i-1])
    else: # 다른 값으로 트랜지션
        source_b.append(1^source_b[i-1]) 

# print("source_b: ", source_b)
count_prob = np.unique(source_b, return_counts = True)
print(count_prob ) # 소스 안에 0과 1의 갯수 출력
One_prob = count_prob[1][1]/1000
Zero_prob = count_prob[1][0]/1000

source_entropy = Zero_prob*math.log(1/Zero_prob,2) + One_prob*math.log(1/One_prob,2)
print("Origianl source entropy bits:", source_entropy*1000)

# calculate empirical probabilities
# 4개씩 끊어서 총 몇 번 나오는지 카운트
counts = Counter([tuple(source_b[i:i+4]) for i in range(0, len(source_b), 4)])
# 각각 나온 횟수 다 합해서 횟수 세기
total_counts = sum(counts.values())
# 각각 나온 횟수를 전체 횟수로 나눠서 확률 구하기.
probabilities = {symbol: count/total_counts for symbol, count in counts.items()}
s_extention_entropy = 0

for key, value in probabilities.items():
    print("Symbol:", key, "Prob:", value)
    s_extention_entropy += value*math.log(1/value,2)
print('\n')
print("source extention entropy:", s_extention_entropy * 250)

# build Huffman tree
# 이렇게 넣으면 알아서 최상위 노드에 가장 작은 확률 값을 갖는 심볼이 들어감.
# ""은 코드워드 넣을 공간
heap = [tree_class.Node(symbol, prob) for symbol, prob in probabilities.items()]

heapq.heapify(heap)
# while문 돌려서 가장 작은 확률 값을 갖는 노드에 0 그 다음 노드에 1 부여하고 다시 힙에 넣어주기.
print("build Huffman tree", "\n")
while len(heap) > 1:
    #for i in range(len(heap)):
    #    print(heap[i], sep='\n')
    #print('\n')
    min0 = heappop(heap); min1 = heappop(heap)
    min0.code = '0'; min1.code = '1'
    total_prob = min0.freq + min1.freq
    heappush(heap, tree_class.Node(None, total_prob, None, min0, min1))

# generate codebook
a = []
def gen_codebook(node):
    if node.flag == False:
        if node.code != None:
            if node.left:
                node.left.code =  node.code + "0"
                gen_codebook(node.left)
            if node.right:
                node.right.code = node.code + "1"
                gen_codebook(node.right)
            else:
                node.flag = True
                a.append((node.symbol, node.code))
        else:
            if node.left:
                node.left.code = "0" 
                gen_codebook(node.left)
            if node.right:
                node.right.code = "1" 
                gen_codebook(node.right)
    else:
        pass

gen_codebook(heap[0])
a.sort(key=lambda e:len(e[1]))
codebook = dict(a)
print("Codebook")
for key, value in codebook.items():
    print(key, value)
print('\n')

# encode sequence
binary_string = "".join([codebook[tuple(source_b[i:i+4])] for i in range(0, len(source_b), 4)])

decoded_bit = []
head = heap[0]
for i in range(0,len(binary_string)):
    b = binary_string[i]
    if b == '0':
        head = head.left
        if head.left is None and head.right is None: # leaf
            decoded_bit.extend(list(head.symbol))
            head = heap[0]
    else:
        head = head.right
        if head.left is None and head.right is None: # leaf
            decoded_bit.extend(list(head.symbol))
            head = heap[0]
            
decoded_bit = [str(e) for e in decoded_bit]
decoded_bit = ''.join(decoded_bit)
source_b = ''.join([str(e)for e in source_b])
print("Encoded_bit", binary_string ,sep='\n')
print("\n")
print("Decoded_bit", decoded_bit, sep='\n')
print("\n")
print("Source bit:", source_b,  sep='\n')
print('\n')
print("Are decoded bits and source bits same? ->", str(decoded_bit == source_b))
print(" \n")

print("Original source entropy bits:", math.ceil(source_entropy*1000))
print("Source extention entropy bits:", math.ceil(s_extention_entropy * 250))
print("Compressed string length:", len(binary_string))

print("Compression ratio: ", round(len(binary_string)/len(source_b), 2)*100, "%")
print('\n')