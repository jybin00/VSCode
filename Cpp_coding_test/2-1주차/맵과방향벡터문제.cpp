#include <bits/stdc++.h>
using namespace std;

const int dy[] = {-1, 0, 1, 0};
const int dx[] = {0, 1, 0, -1}; // 상, 우상, 우, 우하, 하, 하좌, 좌, 좌상
const int n = 3;
int visited[n][n];
int m[n][n];

void search(int y, int x){
    cout << y << " : " << x << '\n';
    visited[y][x] = 1;
    for(int i = 0; i < 4; i ++){
        int ny = y + dy[i];
        int nx = x + dx[i];
        if(ny < 0 || ny >= n || nx < 0 || nx >= n) continue;
        if(m[ny][nx] == 0) continue;
        if(visited[ny][nx]) continue;
        search(ny,nx);
    }

}

int main(){
    int y = 0, x = 0;
    for (int i = 0; i < 3; i++){
        for (int j = 0; j < 3; j++){
            cin >> m[i][j];
        }
    }
    search(y,x);
    for(int i = 0; i < 4; i ++){
        int ny = y + dy[i];
        int nx = x + dx[i];
        cout << ny << " : " << nx << '\n';
    }
    return 0;
}