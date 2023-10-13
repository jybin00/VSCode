#include <bits/stdc++.h>
using namespace std;


int  main(){
    int n;
    cin >> n;

    int array [100];

    array[0] = 1;
    array[1] = 1;
    for (int i = 2; i <= n; i++){
        array[i] = array[i - 1] + array[i - 2];
    }

    cout << array[n] << '\n';

    for (int idx_j = 0; idx_j <= n; idx_j++){
        cout << array[idx_j] << " ";
    }

    return 0;
}