#include <bits/stdc++.h>
using namespace std;

int keys[9];
int main(){
    for(int idx_i = 0; idx_i < 9; idx_i++){
        cin >> keys[idx_i];
    }
    sort(keys, keys + 9); // 주소를 넘겨주면 오름차순으로 정렬해줌.
    do{
        int sum = 0; 
        for(int idx_j = 0; idx_j < 7; idx_j++) sum += keys[idx_j];
        if(sum == 100) break;
    }while(next_permutation(keys, keys + 9));
    for(int idx_k = 0; idx_k < 7; idx_k++) cout << keys[idx_k] << '\n';
    return 0;
}