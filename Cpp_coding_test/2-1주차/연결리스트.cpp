#include<bits/stdc++.h>
using namespace std; 
const int V = 10;
vector<int> adj[V];
int visited[V];

void search(int from){
    cout << from << '\n';
    visited[from] = 1;
    for(int there : adj[from]){
        if(visited[there]) continue;
        search(there);
    }
    return;

}

int main() {
    adj[1].push_back(2);
    adj[1].push_back(3);

    adj[2].push_back(1);

    adj[3].push_back(1);
    adj[3].push_back(4);

    adj[4].push_back(3);

    for (int i = 0; i < V; i ++){
        if(adj[i].size() && visited[i] == 0) search(i);
    }

    for (int i = 0; i < V; i ++){
        cout << i << " :: ";
        for(int there : adj[i]){
            cout << there << " ";
        }
        cout << "\n";
    }
        // 이렇게도 할 수 있다.
    for(int i = 0; i < V; i++){
        cout << i << " :: ";
        for(int j = 0; j < adj[i].size(); j++){
            cout << adj[i][j] << " ";
        } 
        cout << '\n'; 
    }
}