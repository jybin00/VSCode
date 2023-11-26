Breadth First Search (너비우선탐색)

BFS는 그래프르르 탐색하는 알고리즘이며 어떤 정점에서 시작해서 다음 깊이의 정점으로 이동하기 전 현재 깊이의 모든 정점을 탐색하며 방문한 정점은 다시 방문하지 않는 알고리즘.
같은 가중치를 가진 그래프에서 최단거리알고리즘으로 쓰입니다.

Queue 


BFS(G, u)
    u.visited = true;
    q.push(u);
    while(q.size())
        u = q.front()
        q.pop()
        for each v in G.adj[u]
            if v.visited == false
                v.visited = u.visited + 1;
                q.push(v);



DFS vs BFS 비교
둘 다 시간복잡도는 인접리스트로 이루어졌다면 O(V+E)이고 인접행렬의 경우 O(V^2)가 되는 것은 동일하다.
DFS : 메모리를 덜 씀. 절단점 등을 구할 수 있음. 코드가 좀 더 짧으며 완전탐색의 경우 많이 씀.
BFS : 메모리를 더 씀. 가중치가 같은 그래프 내에서 최단거리를 구할 수 있음. 코드가 더 김.

퍼져나간다. 탐색한다. = DFS, BFS를 생각해야함. 

dfs(int here){
    if(visited[here] = 1) return;
    visited[here] = 1;
    for(int there : adj[here]){
        dfs(there);
    }
}

bfs(int here){
    queue<int> q;
    visited[here] = 1;
    q.push(here);
    while(q.size()){
        int here = q.front(); q.pop;
        for (int there : adj[here]){
            visited[there] = visited[here] + 1;
            q.push(there);
        }
    }
}