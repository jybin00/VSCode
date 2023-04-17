from collections import Counter  # 원소 카운트를 위한 라이브러리
from heapq import heappush, heappop  # 최소값을 뽑기 위해서 힙 사용
import numpy as np  # 배열 쉽게 다루기 위해 numpy사용

source_a = np.random.binomial(1, 1/4, size=1000)  # 소스 바이너리 분포로 만들기
# print("source_a: ", source_a)
print(np.unique(source_a, return_counts = True) ) # 소스 안에 0과 1의 갯수 출력

# calculate empirical probabilities
# 4개씩 끊어서 총 몇 번 나오는지 카운트
counts = Counter([tuple(source_a[i:i+4]) for i in range(0, len(source_a), 4)])
# 각각 나온 횟수 다 합해서 횟수 세기
total_counts = sum(counts.values())
# 각각 나온 횟수를 전체 횟수로 나눠서 확률 구하기.
probabilities = {symbol: count/total_counts for symbol, count in counts.items()}

print(probabilities,  sep='\n')
print('\n')

# build Huffman tree
# 이렇게 넣으면 알아서 최상위 노드에 가장 작은 확률 값을 갖는 심볼이 들어감.
heap = [[prob, [symbol, ""]] for symbol, prob in probabilities.items()]
# while문 돌려서 가장 작은 확률 값을 갖는 노드에 0 그 다음 노드에 1 부여하고 다시 힙에 넣어주기.
while len(heap) > 1:
    for i in range(len(heap)):
        print(heap[i], sep='\n')
    print('\n')
    left = heappop(heap)
    right = heappop(heap)
    for pair in left[1:]:
        pair[1] = '0' + pair[1]
    for pair in right[1:]:
        pair[1] = '1' + pair[1]
    heappush(heap, [left[0] + right[0]] + left[1:] + right[1:])

# generate codebook
codebook = dict(heap[0][1:])

print(codebook,  sep='\n')
print('\n')

# encode sequence
binary_string = "".join([codebook[tuple(source_a[i:i+4])] for i in range(0, len(source_a), 4)])

print(binary_string,  sep='\n')
print('\n')

print("Compression ratio: ", round(1- len(binary_string)/len(source_a), 3)*100, "%")
print('\n')