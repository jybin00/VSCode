#include <bits/stdc++.h>
using namespace std;
int a[3] = {1,2,3};
int n = 3, r = 4; // r을 바꿔가며 연습하기.

void print(vector<int> b){
    cout << "{";
    for (int i = 0; i < r; i++){
        cout << b[i] << " ";
    }
    cout << "}";
    cout << '\n';
}

// void makePermutation(int n, int r, int depth){
//     if(r == depth){
//         print();
//         return;
//     }
//     for(int i = depth; i < n; i++){
//         swap(a[i], a[depth]);
//         makePermutation(n, r, depth + 1);
//         swap(a[i], a[depth]);
//     }
//     return;
// }

int main(){
  
    vector<int> vec;
    int idx_k = 0;

    for (int idx_i = 0; idx_i < 4; idx_i++){
        int k;
        cin >> k;
        vec.push_back(k);
    }
    sort(vec.begin(), vec.end());
    do{
        print(vec);
        idx_k ++;
    }while(next_permutation(vec.begin(), vec.end()));
    cout << "Total possible permutation : " << idx_k;
    return 0;
}