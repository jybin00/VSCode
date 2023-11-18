#include<bits/stdc++.h>
using namespace std;
const int V = 10;
bool graph[V][V], visited[V];
void go(int from){
    visited[from] = 1;
    cout << from << '\n';
    for (int i = 0; i < V; i++){
        if(visited[i]) continue;
        if(graph[from][i]){
            go(i);
        }
    }
    return;
}
int main(){
    graph[1][2] = 1; graph[1][3] = 1; graph[3][4] = 1;
    graph[2][1] = 1; graph[3][1] = 1; graph[4][3] = 1;
    for(int i = 0; i < V; i++){
        for (int j = 0; j < V; j++){
            if (graph[i][j] && visited[i] == 0){
                go(i);
            }
        }
    }
}