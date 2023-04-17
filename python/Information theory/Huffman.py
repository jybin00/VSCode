from collections import Counter  # 원소 카운트를 위한 라이브러리
from heapq import heappush, heappop  # 최소값을 뽑기 위해서 힙 사용
import numpy as np  # 배열 쉽게 다루기 위해 numpy사용
import math

source_a = np.random.binomial(1, 1/4, size=1000)  # 소스 바이너리 분포로 만들기
# print("source_a: ", source_a)
count_prob = np.unique(source_a, return_counts = True)
print(count_prob ) # 소스 안에 0과 1의 갯수 출력
One_prob = count_prob[1][1]/1000
Zero_prob = count_prob[1][0]/1000

source_entropy = Zero_prob*math.log(1/Zero_prob,2) + One_prob*math.log(1/One_prob,2)
print("entropy bits:", source_entropy*1000)

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
heap = [[prob, [symbol, ""]] for symbol, prob in probabilities.items()]
heap = sorted(heap)
print(heap)
# while문 돌려서 가장 작은 확률 값을 갖는 노드에 0 그 다음 노드에 1 부여하고 다시 힙에 넣어주기.
print("build Huffman tree", "\n")
while len(heap) > 1:
    for i in range(len(heap)):
        print(heap[i], sep='\n')
    print('\n')
    left = heappop(heap)
    right = heappop(heap)
    for pair in left[1:]:
        # 비어 있는 칸에 코드워드를 넣어줌.
        pair[1] = '0' + pair[1]
    for pair in right[1:]:
        pair[1] = '1' + pair[1]
    heappush(heap, [left[0] + right[0]] + left[1:] + right[1:])
    # 힙 정렬하기.
    heap = sorted(heap)

# generate codebook
codebook = dict(heap[0][1:])

print("Codebook")
for key, value in codebook.items():
    print(key, value)
print('\n')

# encode sequence
binary_string = "".join([codebook[tuple(source_a[i:i+4])] for i in range(0, len(source_a), 4)])

print(binary_string,  sep='\n')
print('\n')

print("Original source entropy bits:", math.ceil(source_entropy*1000))
print("Source extention entropy bits:", math.ceil(s_extention_entropy * 250))
print("Compressed string length:", len(binary_string))

print("Compression ratio: ", round(1- len(binary_string)/len(source_a), 2)*100, "%")
print('\n')