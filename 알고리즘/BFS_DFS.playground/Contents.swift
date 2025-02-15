import Foundation

// ✅ 그래프 정의 (Python 딕셔너리를 Swift Dictionary로 변환)
let graph: [String: [String]] = [
    "A": ["B", "C"],
    "B": ["A", "D"],
    "C": ["A", "G", "H", "I"],
    "D": ["B", "E", "F"],
    "E": ["D"],
    "F": ["D"],
    "G": ["C"],
    "H": ["C"],
    "I": ["C", "J"],
    "J": ["I"]
]


func bfs(graph: [String: [String]], startNode: String) -> [String] {
    var visited: [String] = []  // 방문한 노드 저장
    var needVisit: [String] = []  // 방문해야 할 노드 저장 (큐 역할)
    
    needVisit.append(startNode)  // 시작 노드 추가
    
    while !needVisit.isEmpty {  // 큐가 빌 때까지 반복
        let node = needVisit.removeFirst()  // 큐의 맨 앞에서 꺼냄
        if !visited.contains(node) {
            visited.append(node)  // 방문한 노드 기록
            needVisit.append(contentsOf: graph[node] ?? [])  // 인접 노드 추가
        }
    }
    
    return visited
}

func dfs(graph: [String: [String]], startNode: String) -> [String] {
    var visited: [String] = []  // 방문한 노드 저장
    var needVisit: [String] = []  // 스택 역할 (LIFO)

    needVisit.append(startNode)  // 시작 노드를 스택에 추가

    while let node = needVisit.popLast() {  // 스택의 맨 위 요소 꺼내기
        if !visited.contains(node) {  // 방문하지 않았다면 추가
            visited.append(node)
            needVisit.append(contentsOf: graph[node] ?? [])  // 인접 노드 추가
        }
    }

    return visited
}

// ✅ BFS 실행
print(bfs(graph: graph, startNode: "A"))  // ["A", "B", "C", "D", "G", "H", "I", "E", "F", "J"]

// ✅ DFS 실행
print(dfs(graph: graph, startNode: "A"))  // ["A", "C", "I", "J", "H", "G", "B", "D", "F", "E"]



//MARK: 정욱 구현 최대한 비슷한 구조로 구현
// visited, needVisit 라는 이름의 BFS 면 두개의 큐 DFS라면 큐와 스택이 필요함

func bfs_test(graph:[String: [String]] , startNode: String) -> [String] {
    var visited = [String]()
    var needVisit = [String]()
    
    needVisit.append(startNode)
    
    while needVisit.isEmpty == false {
        let node = needVisit.removeFirst()
        if !visited.contains(node) {
            visited.append(node)  // 방문한 노드 기록
            needVisit.append(contentsOf: graph[node] ?? [])  // 인접 노드 추가
        }
    }
    
    return visited
}

func dfs_test(graph:[String: [String]] , startNode: String) -> [String] {
    var visited = [String]()
    var needVisit = [String]()
    
    needVisit.append(startNode)
    
    while needVisit.isEmpty == false {
        guard let node = needVisit.popLast() else { break }
        if !visited.contains(node) {
            visited.append(node)  // 방문한 노드 기록
            needVisit.append(contentsOf: graph[node] ?? [])  // 인접 노드 추가
        }
    }
    
    return visited
}


/* 참고
 ✅ 1️⃣ append()
 var array = [1, 2, 3]
 array.append(4)
 print(array)  // [1, 2, 3, 4]
 
 append(_ newElement: Element)
 배열에 하나의 요소(Element)만 추가할 때 사용.
 O(1) 연산 (일반적으로 매우 빠름).
 
 
 ✅ 2️⃣ append(contentsOf:)
 var array = [1, 2, 3]
 array.append(contentsOf: [4, 5, 6])
 print(array)  // [1, 2, 3, 4, 5, 6]
 
 append(contentsOf newElements: S)
 배열에 여러 개의 요소(Sequence)를 한 번에 추가할 때 사용.
 
 Sequence(배열, 리스트, Set 등)를 통째로 추가할 수 있음.
 += 연산과 동일한 역할을 함 (array += [4, 5, 6]).
 O(n) 연산 (배열 크기가 커질수록 성능 저하 가능).*/
