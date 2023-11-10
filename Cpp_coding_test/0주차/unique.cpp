#include <bits/stdc++.h>
using namespace std;

vector<int> v {1,4,2,3,3,2,5,1,5,4,1};
int main(){
    sort(v.begin(), v.end());
    auto it = unique(v.begin(), v.end());
    for(int i : v) cout << i << " ";
    cout << '\n';
    return 0;
}