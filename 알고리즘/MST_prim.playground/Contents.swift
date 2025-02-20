import Foundation

// ✅ `Comparable`을 따르는 Edge 구조체
struct Edge: Comparable {
    let weight: Int  // 가중치
    let node1: String
    let node2: String

    // ✅ 가중치(weight) 기준으로 정렬되도록 Comparable 프로토콜 구현
    static func < (lhs: Edge, rhs: Edge) -> Bool {
        return lhs.weight < rhs.weight
    }
}

// ✅ 우선순위 큐 (Min-Heap) 구현
struct PriorityQueue<T: Comparable> {
    private var elements: [T] = []

    var isEmpty: Bool { elements.isEmpty }

    mutating func enqueue(_ element: T) {
        elements.append(element)
        elements.sort { $0 < $1 }  // ✅ 최소 힙 유지 (가중치 기준 정렬)
    }

    mutating func dequeue() -> T? {
        return isEmpty ? nil : elements.removeFirst()
    }
}

// ✅ Prim 알고리즘 실행 함수
func prim(startNode: String, edges: [Edge]) -> [Edge] {
    var mst: [Edge] = []  // ✅ 최소 신장 트리(MST) 저장
    var adjacentEdges: [String: [Edge]] = [:]  // ✅ 각 노드에 연결된 간선 저장

    // ✅ 그래프 초기화 (양방향 간선 저장)
    for edge in edges {
        adjacentEdges[edge.node1, default: []].append(edge)
        adjacentEdges[edge.node2, default: []].append(Edge(weight: edge.weight, node1: edge.node2, node2: edge.node1))
    }

    var connectedNodes: Set<String> = [startNode]  // ✅ 시작 노드 추가
    var candidateEdgeList = PriorityQueue<Edge>()  // ✅ 최소 힙 기반 우선순위 큐

    // ✅ 시작 노드에 연결된 간선 추가
    if let edgesFromStart = adjacentEdges[startNode] {
        for edge in edgesFromStart {
            candidateEdgeList.enqueue(edge)
        }
    }

    // ✅ Prim 알고리즘 실행
    while !candidateEdgeList.isEmpty {
        guard let edge = candidateEdgeList.dequeue() else { break }

        if !connectedNodes.contains(edge.node2) {  // ✅ 새로운 노드인지 확인
            connectedNodes.insert(edge.node2)
            mst.append(edge)  // ✅ 최소 신장 트리에 추가

            // ✅ 새롭게 추가된 노드(n2)에 연결된 간선 추가
            if let newEdges = adjacentEdges[edge.node2] {
                for newEdge in newEdges {
                    if !connectedNodes.contains(newEdge.node2) {
                        candidateEdgeList.enqueue(newEdge)
                    }
                }
            }
        }
    }

    return mst
}

// ✅ 테스트 그래프 데이터 (Python `myedges` 변환)
let myEdges: [Edge] = [
    Edge(weight: 7, node1: "A", node2: "B"), Edge(weight: 5, node1: "A", node2: "D"),
    Edge(weight: 8, node1: "B", node2: "C"), Edge(weight: 9, node1: "B", node2: "D"), Edge(weight: 7, node1: "B", node2: "E"),
    Edge(weight: 5, node1: "C", node2: "E"),
    Edge(weight: 7, node1: "D", node2: "E"), Edge(weight: 6, node1: "D", node2: "F"),
    Edge(weight: 8, node1: "E", node2: "F"), Edge(weight: 9, node1: "E", node2: "G"),
    Edge(weight: 11, node1: "F", node2: "G")
]

// ✅ Prim 알고리즘 실행
let mstResult = prim(startNode: "A", edges: myEdges)

// ✅ 출력 결과
print("🔹 최소 신장 트리 (MST) 간선 목록:")
for edge in mstResult {
    print(" \(edge.weight) : \(edge.node1) - \(edge.node2)")
}
