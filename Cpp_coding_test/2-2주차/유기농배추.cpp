#include<bits/stdc++.h>
using namespace std;
int map_w, map_h = 0; // 맵의 크기를 받는 변수
int Map[104][104] ={0, }; // 맵 크기는 문제에서 정해져있지만 여유를 두고 설정.
// 방향 벡터
int dy[4] = {-1, 0, 1, 0};
int dx[4] = {0, 1, 0, -1};
int y, x, ret, ny, nx, num_test, num_baechu = 0;

vector<int> v;

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
    cin >> num_test;
    for (int i = 0; i < num_test; i++){
        ret = 0;
        // 맵 크기, 배추 개수 입력
        cin >> map_w >> map_h >> num_baechu;
        // 배추 위치 입력
        for (int j = 0; j < num_baechu; j++){
            cin >> x >> y;
            Map[y][x] = 1;
        }
        // dfs 시작
        for(int i = 0; i < map_h; i++){
            for(int j = 0; j < map_w; j++){
                if(Map[i][j] == 1 && !visited[i][j]){
                    ret++; dfs(i, j);
                    //cout << i << " : " << j << " dfs가 시작됩니다.\n";
                }
            }
        }
        v.push_back(ret);
        // 배열 초기화
        fill(&Map[0][0], &Map[0][0] + 104 * 104, 0);
        fill(&visited[0][0], &visited[0][0] + 104 * 104, 0);
    }   
    for(int i = 0; i < v.size(); i++){
        cout << v[i] << '\n';
        }
    return 0;
}