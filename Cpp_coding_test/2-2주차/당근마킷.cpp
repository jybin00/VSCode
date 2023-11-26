#include<bits/stdc++.h>
using namespace std;
int map_w, map_h = 0; // 맵의 크기를 받는 변수
int start_y, start_x = 0;
int end_y, end_x = 0;
int Map[104][104] = {0,}; // 맵 크기는 문제에서 정해져있지만 여유를 두고 설정.
int visited[104][104] = {0,}; // 방문 여부를 저장하는 배열

// 방향 벡터, 상우하좌
int dy[4] = {-1, 0, 1, 0};
int dx[4] = {0, 1, 0 , -1};

void bfs(int y, int x, int end_y, int end_x){
    visited[y][x] = true;

    // 2차원이니까 queue도 pair로 만들기.
    queue<pair<int,int>> q;
    q.push({y,x});
    while(q.size()){
        int y = q.front().first;
        int x = q.front().second;
        // tie(y,x) = q.front(); // 이렇게도 가능
        q.pop();
        for (int i = 0; i < 4; i ++){
            int ny = y + dy[i];
            int nx = x + dx[i];
            // 오버플로우 언더플로우 방지
            if(ny < 0 || ny >= map_h || nx < 0 || nx >= map_w) continue;
            // 방문하지 않았고, 육지라면
            if(Map[ny][nx] == 1 && !visited[ny][nx]){
                visited[ny][nx] = visited[y][x] + 1;
                q.push({ny, nx});
            }
        }
    }
    cout << visited[end_y][end_x] << '\n';
    for(int i = 0; i < map_h; i ++){
        for (int j = 0; j < map_w; j ++){
            cout << visited[i][j] << " ";
        }
        cout << '\n';
    }
}


int main(){
    cin >> map_h >> map_w;
    cin >> start_y >> start_x;
    cin >> end_y >> end_x;
    for (int i=0; i < map_h; i++){
        for (int j=0; j < map_w; j++){
            cin >> Map[i][j];
        }
    }
    bfs(start_y, start_x, end_y, end_x);

    return 0;
}