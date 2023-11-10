#include<bits/stdc++.h>
using namespace std;
string dopa = "abcde";


int main(){
    // 3ro cnffur
    cout << dopa.substr(0,3) << '\n';
    // 거꾸로 출력
    reverse(dopa.begin(), dopa.end());
    cout << dopa << '\n';

    cout << dopa + " umzunsik" << '\n';
    return 0;

}