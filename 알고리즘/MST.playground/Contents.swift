
import Foundation

// ✅ 그래프 데이터 정의
struct Graph {
    let vertices: [String]
    var edges: [(Int, String, String)] // (weight, vertex1, vertex2)
}

// ✅ Kruskal 알고리즘을 위한 Union-Find 구조체
class UnionFind {
    var parent: [String: String] = [:]  // 부모 노드 저장 (자기 자신이 초기 부모)
    var rank: [String: Int] = [:]  // 트리 랭크(높이) 저장

    init(nodes: [String]) {
        for node in nodes {
            parent[node] = node // 처음엔 자기 자신이 부모
            rank[node] = 0  // 랭크 초기값은 0
        }
    }

    // ✅ find 함수: 경로 압축(Path Compression)
    func find(_ node: String) -> String {
        if parent[node]! != node {
            parent[node] = find(parent[node]!) // 재귀적으로 루트 노드 찾기
        }
        return parent[node]!
    }

    // ✅ union 함수: 랭크 기반 합집합(Union by Rank)
    func union(_ nodeV: String, _ nodeU: String) {
        let root1 = find(nodeV)
        let root2 = find(nodeU)

        if root1 != root2 {
            if rank[root1]! > rank[root2]! {
                parent[root2] = root1
            } else {
                parent[root1] = root2
                if rank[root1]! == rank[root2]! {
                    rank[root2]! += 1
                }
            }
        }
    }
}

// ✅ Kruskal 최소 신장 트리 알고리즘
func kruskal(graph: Graph) -> [(Int, String, String)] {
    var mst: [(Int, String, String)] = [] // 최소 신장 트리 저장
    let unionFind = UnionFind(nodes: graph.vertices)

    // 1️⃣ 간선 가중치(weight) 기준으로 정렬
    let sortedEdges = graph.edges.sorted { $0.0 < $1.0 }

    // 2️⃣ 간선 선택 (사이클 없는 경우)
    for edge in sortedEdges {
        let (weight, nodeV, nodeU) = edge
        if unionFind.find(nodeV) != unionFind.find(nodeU) { // 루트 노드가 다르면 사이클 X
            unionFind.union(nodeV, nodeU) // ✅ 집합 합치기
            mst.append(edge)  // ✅ 간선 선택
        }
    }

    return mst
}

// ✅ 테스트 그래프 생성
let myGraph = Graph(
    vertices: ["A", "B", "C", "D", "E", "F", "G"],
    edges: [
        (7, "A", "B"), (5, "A", "D"), (7, "B", "A"), (8, "B", "C"),
        (9, "B", "D"), (7, "B", "E"), (8, "C", "B"), (5, "C", "E"),
        (5, "D", "A"), (9, "D", "B"), (7, "D", "E"), (6, "D", "F"),
        (7, "E", "B"), (5, "E", "C"), (7, "E", "D"), (8, "E", "F"),
        (9, "E", "G"), (6, "F", "D"), (8, "F", "E"), (11, "F", "G"),
        (9, "G", "E"), (11, "G", "F")
    ]
)

// ✅ Kruskal 알고리즘 실행
let mstResult = kruskal(graph: myGraph)

// ✅ 출력 결과
print("최소 신장 트리(MST) 간선 목록:")
for edge in mstResult {
    print("\(edge.0) : \(edge.1) - \(edge.2)")
}


//MARK: 출력문 살펴보기
// ✅ Kruskal 알고리즘을 위한 Union-Find 구조체
class UnionFind2 {
    var parent: [String: String] = [:]  // 부모 노드 저장 (자기 자신이 초기 부모)
    var rank: [String: Int] = [:]  // 트리 랭크(높이) 저장

    init(nodes: [String]) {
        for node in nodes {
            parent[node] = node // 처음엔 자기 자신이 부모
            rank[node] = 0  // 랭크 초기값은 0
        }
    }

    // ✅ find 함수: 경로 압축(Path Compression) 과정 출력
    func find(_ node: String) -> String {
        print("find(\(node)) 호출됨")
        if parent[node]! != node {
            print("  \(node)의 부모는 \(parent[node]!) → 경로 압축 수행")
            parent[node] = find(parent[node]!) // 재귀적으로 루트 노드 찾기
        }
        return parent[node]!
    }

    // ✅ union 함수: 랭크 기반 합집합(Union by Rank)
    func union(_ nodeV: String, _ nodeU: String) {
        let root1 = find(nodeV)
        let root2 = find(nodeU)

        print("union(\(nodeV), \(nodeU)) 실행됨")
        print("  \(nodeV)의 루트: \(root1), \(nodeU)의 루트: \(root2)")

        if root1 != root2 {
            if rank[root1]! > rank[root2]! {
                print("  \(root2)가 \(root1)에 속하게 됨")
                parent[root2] = root1
            } else {
                print("  \(root1)가 \(root2)에 속하게 됨")
                parent[root1] = root2
                if rank[root1]! == rank[root2]! {
                    print("  랭크 증가: \(root2)의 랭크가 \(rank[root2]! + 1) 됨")
                    rank[root2]! += 1
                }
            }
        }
    }
}

// ✅ Kruskal 최소 신장 트리 알고리즘
func kruskal2(graph: Graph) -> [(Int, String, String)] {
    var mst: [(Int, String, String)] = [] // 최소 신장 트리 저장
    let unionFind = UnionFind2(nodes: graph.vertices)

    // 1️⃣ 간선 가중치(weight) 기준으로 정렬
    let sortedEdges = graph.edges.sorted { $0.0 < $1.0 }
    
    print("\n=== Kruskal 알고리즘 실행 ===")
    
    // 2️⃣ 간선 선택 (사이클 없는 경우)
    for edge in sortedEdges {
        let (weight, nodeV, nodeU) = edge
        print("\n📌 현재 간선 선택 시도: \(nodeV) - \(nodeU) (\(weight))")
        
        if unionFind.find(nodeV) != unionFind.find(nodeU) { // 루트 노드가 다르면 사이클 X
            print("✅ 간선 추가됨: \(nodeV) - \(nodeU) (\(weight))")
            unionFind.union(nodeV, nodeU) // ✅ 집합 합치기
            mst.append(edge)  // ✅ 간선 선택
        } else {
            print("❌ 간선 무시됨: \(nodeV) - \(nodeU) (\(weight)) (사이클 발생)")
        }
    }

    return mst
}

// ✅ 테스트 그래프 생성
let myGraph2 = Graph(
    vertices: ["A", "B", "C", "D", "E", "F", "G"],
    edges: [
        (7, "A", "B"), (5, "A", "D"), (7, "B", "A"), (8, "B", "C"),
        (9, "B", "D"), (7, "B", "E"), (8, "C", "B"), (5, "C", "E"),
        (5, "D", "A"), (9, "D", "B"), (7, "D", "E"), (6, "D", "F"),
        (7, "E", "B"), (5, "E", "C"), (7, "E", "D"), (8, "E", "F"),
        (9, "E", "G"), (6, "F", "D"), (8, "F", "E"), (11, "F", "G"),
        (9, "G", "E"), (11, "G", "F")
    ]
)

// ✅ Kruskal 알고리즘 실행
let mstResult2 = kruskal2(graph: myGraph2)

// ✅ 출력 결과
print("\n=== 최소 신장 트리(MST) 간선 목록 ===")
for edge in mstResult2 {
    print("🔹 \(edge.1) - \(edge.2) : \(edge.0)")
}
