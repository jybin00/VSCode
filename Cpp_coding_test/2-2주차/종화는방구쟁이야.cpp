#include<bits/stdc++.h>
using namespace std;
int map_w, map_h = 0; // 맵의 크기를 받는 변수
int Map[104][104]; // 맵 크기는 문제에서 정해져있지만 여유를 두고 설정.
// 방향 벡터
int dy[4] = {-1, 0, 1, 0};
int dx[4] = {0, 1, 0, -1};
int k, y, x, contam, ny, nx, t;

bool visited[104][104] = {0,}; // 방문 여부를 저장하는 배열

void dfs(int y, int x){
    visited[y][x] = true;
    for(int i = 0; i < 4; i++){
        ny = y + dy[i];
        nx = x + dx[i];
        // 오버플로우 언더플로우 방지
        if(ny < 0 || ny >= map_h || nx < 0 || nx >= map_w) continue;
        // 방문하지 않았고, 육지라면
        if(Map[ny][nx] == 1 && !visited[ny][nx]){
            dfs(ny, nx);
        }
    }
}

int main(){
    cin.tie(NULL); // 입출력 속도 향상을 위한 코드
    cout.tie(NULL);
    cin >> map_w >> map_h;
    for(int i = 0; i < map_h; i++){
        for(int j = 0; j < map_w; j++){
            cin >> Map[i][j];
        }
    }
    for(int i = 0; i < map_w; i++){
        for(int j = 0; j < map_h; j++){
            if(Map[i][j] == 1 && !visited[i][j]){
                contam++; dfs(i, j);
                cout << i << " : " << j << " dfs가 시작됩니다.\n";
            }
        }
    }
    cout << contam << '\n';
    return 0;
}