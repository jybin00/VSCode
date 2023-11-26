#include <bits/stdc++.h>
using namespace std;

const int dy[] = {-1, 0, 1, 0};
const int dx[] = {0, 1, 0, -1}; 
int ny, nx = 0;
int ret = 1;

int Map[101][101] = {0,};
int visited[101][101] = {0,};
int N = 1;

void dfs(int y, int x, int d){
    visited[y][x] = 1;
    for(int i = 0; i < 4; i++){
        ny = y + dy[i];
        nx = x + dx[i];
        // 오버플로우 언더플로우 방지
        if(ny < 0 || ny >= N || nx < 0 || nx >= N) continue;
        // 방문하지 않았고, 육지인데 d보다 높다면
        if(!visited[ny][nx] && Map[ny][nx] > d){
            dfs(ny, nx, d);
        }
    }
}

int main(){
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    cout.tie(NULL); 
    cin >> N;
    for(int i = 0; i < N; i++){
        for(int j = 0; j < N; j++){
            cin >> Map[i][j];
        }
    }
    int tmp_ret = 1;
    for(int d = 1; d < 101; d++){
        fill(&visited[0][0], &visited[0][0] + 101 * 101, 0);
        tmp_ret = 0;
        for(int i = 0; i < N; i++){
            for(int j = 0; j < N; j++){
                // 방문하지 않았고, 육지가 d보다 높다면,
                if(!visited[i][j] && Map[i][j] > d){
                    dfs(i, j, d);
                    tmp_ret++; }
            }
        }
        //cout << "d: " << d << " tmp_ret: " << tmp_ret << '\n';
        ret = max(ret, tmp_ret);
    }
    cout << ret << '\n';
    return 0;
}
