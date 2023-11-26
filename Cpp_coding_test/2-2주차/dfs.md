connected component

연결된 하위 그래프 = 연결된 하나의 덩어리
하나의 덩어리 그 잡채
flood fill - 덩어리끼리 나누기.
맵 = 덩어리 = 섬. 
모든 정점을 연결하는 경로가 있다.


DFS (Depth First Search)
어떤 노드부터 시작해서 인접한 노드들을 재귀적으로 방문하며 방문한 정점은 다시 방문하지 않으며 각 분기마다 가능한 가장 멀리 있는 노드까지 탐색하는 알고리즘.

DFS(u, adj)
    u.visited = true;
    for each v in adj[u]
        if v.visited == false
            DFS(v,adj)

// 돌 다리도 두두려보고 건너기

void dfs(int here){
    visitied[here] = 1;
    for(int there : adj[here]){
        if(visited[there]) continue;
        dfs(there);
        if(visited[there] == 0){
            dfs(there);
        }
    }
}

// 무조건 호출하기

void dfs(int here){
    if(visited[here]) return;
    visited[here] = 1;
    for(int there : adj[here]){
        dfs(there);
    }
}

정의 그래프를 탐색하는 알고리즘. 재귀적으로 방문하고 방문한 노드는 다시 방문하지 않고,
각 분기마다 가장 멀리 있는 노드까지 탐색하는 알고리즘.