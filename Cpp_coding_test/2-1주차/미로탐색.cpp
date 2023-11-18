#include <bits/stdc++.h>
#include <string>
using namespace std;

int N = 0;
int M = 0;
int Map[100][100] = {2,};
const int dy[] = {-1, 0, 1, 0};
const int dx[] = {0, 1, 0, -1}; // 상, 우, 하, 좌
int visited[100][100] = {0,};

int searching_map(){
    queue<pair<int,int>> q;
    q.push({0,0});
    visited[0][0] = 1;
    while(!q.empty()){
        int y = q.front().first;
        int x = q.front().second;
        q.pop();
        if(y == N-1 && x == M-1){
            cout << visited[y][x] << '\n';
            return 0;
        }
        for(int i = 0; i < 4; i++){
            int ny = y + dy[i];
            int nx = x + dx[i]; 
            if(ny < 0 || ny >= N || nx < 0 || nx >= M) continue;
            if(Map[ny][nx] == 0) continue;
            if(visited[ny][nx]) continue;
            visited[ny][nx] = visited[y][x] + 1;
            q.push({ny,nx}); 
            }  
        }
    return 0;
}

int main(){
    cin >> N >> M;
    for(int i = 0; i < N; i++){
        string row;
        cin >> row;
        for(int j = 0; j < M; j++){
            Map[i][j] = row[j] - '0';
        }
    }
    searching_map();
    return 0;
}