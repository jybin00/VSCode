from collections import Counter  # 원소 카운트를 위한 라이브러리
import heapq
from heapq import heappush, heappop  # 최소값을 뽑기 위해서 힙 사용
import numpy as np  # 배열 쉽게 다루기 위해 numpy사용
import math
import tree_class

source_a = np.random.binomial(1, 1/4, size=1000)  # 소스 바이너리 분포로 만들기
count_prob = np.unique(source_a, return_counts = True)
print(count_prob ) # 소스 안에 0과 1의 갯수 출력
One_prob = count_prob[1][1]/1000
Zero_prob = count_prob[1][0]/1000

source_entropy = Zero_prob*math.log(1/Zero_prob,2) + One_prob*math.log(1/One_prob,2)
print("Original source entropy bits:", source_entropy*1000)

# calculate empirical probabilities
# 4개씩 끊어서 총 몇 번 나오는지 카운트
counts = Counter([tuple(source_a[i:i+4]) for i in range(0, len(source_a), 4)])
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
    min0 = heappop(heap); min1 = heappop(heap)  # 힙에 있는 가장 작은 노드 빼서 min0과 min1에 각각 넣기. 
    min0.code = '0'; min1.code = '1' # 각각에 코드 추가해주기.
    total_prob = min0.freq + min1.freq # 각각의 확률 합쳐서
    heappush(heap, tree_class.Node(None, total_prob, None, min0, min1))  # 힙에 다시 넣어주기

# generate codebook
a = []
def gen_codebook(node):  # 루트 노드에서 시작해서 리프노드까지 순회하며 코드북 만들기.
    if node.flag == False:  
        if node.code != None:
            if node.left: # 자신의 노드의 왼쪽 노드에는 자신의 코드 더하기 0
                node.left.code =  node.code + "0"
                gen_codebook(node.left)
            if node.right: # 자신의 오른쪽 노드에는 자신의 코드 더하기 1
                node.right.code = node.code + "1"
                gen_codebook(node.right)
            else: # 만약 이 노드가 리프 노드이면 자신의 심볼과 코드를 코드북에 어펜드
                node.flag = True
                a.append((node.symbol, node.code))
        else: # 첫 시작에는 (=루트 노드에는) 코드가 없어서 따로 시작해야함.
            if node.left:
                node.left.code = "0" 
                gen_codebook(node.left)
            if node.right:
                node.right.code = "1" 
                gen_codebook(node.right)
    else:
        pass

gen_codebook(heap[0]) # 코드북 생성 함수에 힙을 넘겨주기
a.sort(key=lambda e:len(e[1])) # 코드북 원소 보기 좋게 정렬
codebook = dict(a) # 코드북을 사전 형으로 만들기
print("Codebook")
for key, value in codebook.items():
    print(key, value)
print('\n')

# encode sequence
binary_string = "".join([codebook[tuple(source_a[i:i+4])] for i in range(0, len(source_a), 4)])

decoded_bit = []
head = heap[0]
for i in range(0,len(binary_string)):
    b = binary_string[i]
    if b == '0': # 코드가 0이면? 왼쪽으로
        head = head.left
        if head.left is None and head.right is None: # leaf
            decoded_bit.extend(list(head.symbol))
            head = heap[0]
    else: # 코드가 1이면 오른쪽으로
        head = head.right
        if head.left is None and head.right is None: # leaf
            decoded_bit.extend(list(head.symbol))
            head = heap[0]
            
decoded_bit = [str(e) for e in decoded_bit]
decoded_bit = ''.join(decoded_bit)
source_a = ''.join([str(e)for e in source_a])
print("Encoded_bit", binary_string ,sep='\n')

print("Decoded_bit", decoded_bit, sep='\n')

print("Source bit:", source_a,  sep='\n')
print("\n")
print("Are both decoded bits and source bits same? ->", str(decoded_bit == source_a))
print("\n")

print("Original source entropy bits:", math.ceil(source_entropy*1000))
print("Source extention entropy bits:", math.ceil(s_extention_entropy * 250))
print("Compressed string length:", len(binary_string))

print("Compression ratio: ", round(len(binary_string)/len(source_a), 2)*100, "%")
print('\n')