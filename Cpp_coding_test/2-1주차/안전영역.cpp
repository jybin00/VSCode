#include <bits/stdc++.h>
using namespace std;

const int dy[] = {-1, 0, 1, 0};
const int dx[] = {0, 1, 0, -1}; 

int Map[100][100] = {0,};
int visited[100][100] = {0,};
int N = 0;
int new_Map[100][100] = {0,};

int searching_map(int y, int x, int height){
    queue<pair<int,int>> q;
    q.push({0,0});
    visited[0][0] = 1;
    while(!q.empty()){
        int y = q.front().first;
        int x = q.front().second;
        q.pop();
        if(y == N-1 && x == N-1){
            return 0;
        }
        for(int i = 0; i < 4; i++){
            int ny = y + dy[i];
            int nx = x + dx[i]; 
            if(ny < 0 || ny >= N || nx < 0 || nx >= N) continue;
            if(visited[ny][nx]) continue;
            
            else
                visited[ny][nx] = 1;
                if(Map[ny][nx] >= N)
                    new_Map[ny][nx] = 1;
            q.push({ny,nx}); 
            }  
        }
    return 0;
}

int safety_zone(){

    for(int i = 0; i < N; i++){
        for(int j = 0; j < N; j++){
            if(new_Map[i][j] == 1){
                Map[i][j] = 0;
            }
        }
    }
    return 0;
}

int main(){
    cin >> N;
    int maxheight;
    for(int i = 0; i < N; i++){
        for(int j = 0; j < N; j++){
            cin >> Map[i][j];

            if (Map[i][j] > maxheight)
                maxheight = Map[i][j];
        }
    }
    searching_map();
    safety_zone();
    return 0;
}
