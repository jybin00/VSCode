#include<bits/stdc++.h>
using namespace std;

int fee[3];
int t1[2];
int t2[2];
int t3[2];
int sum = 0;

int main(){
    cin >> fee[0] >> fee[1] >> fee[2];
    cin >> t1[0] >> t1[1];
    cin >> t2[0] >> t2[1];
    cin >> t3[0] >> t3[1];
    
    int tmp = min(t1[0], t2[0]);
    int first_min = min(tmp, t3[0]);
    int tmp2 = max(t1[1], t2[1]);
    int last_max = max(tmp2, t3[1]);

    for(int i = first_min; i <= last_max; i++){
        int cnt = 0;
        if(i > t1[0] && i <= t1[1]) cnt++;
        if(i > t2[0] && i <= t2[1]) cnt++;
        if(i > t3[0] && i <= t3[1]) cnt++;
        if(cnt == 1) sum += fee[0];
        else if(cnt == 2) sum += 2*fee[1];
        else if(cnt == 3) sum += 3*fee[2];
    }

    cout << sum;
    return 0;
}