
import Foundation

/// ✅ 최소 힙(Min-Heap) 기반의 우선순위 큐
struct PriorityQueue<Element: Comparable> {
    private var elements: [Element] = []  // ✅ 내부 배열 (힙 역할)
    
    var isEmpty: Bool { return elements.isEmpty }  // ✅ 큐가 비어 있는지 확인
    
    mutating func enqueue(_ element: Element) {
        elements.append(element)  // ✅ 새 요소 추가
        elements.sort(by: { $0 < $1 })  // ✅ 작은 값이 먼저 오도록 정렬 (최소 힙 유지)
    }
    
    mutating func dequeue() -> Element? {
        return isEmpty ? nil : elements.removeFirst()  // ✅ 가장 작은 값 제거 후 반환
    }
}


/// ✅ (거리, 노드) 정보를 담을 구조체 정의
struct Node: Comparable {
    let distance: Int
    let name: String

    // ✅ 최소 힙을 유지하기 위해 `distance` 기준으로 비교
    static func < (lhs: Node, rhs: Node) -> Bool {
        return lhs.distance < rhs.distance
    }
}


/// ✅ 다익스트라 알고리즘 수정
func dijkstra(graph: [String: [String: Int]], start: String) -> [(String, Int)] {
    
    var distances = [String: Int]()  // ✅ 최단 거리 저장
    
    // ✅ 모든 노드를 무한대로 초기화
    for node in graph.keys {
        distances[node] = Int.max
    }
    distances[start] = 0  // ✅ 시작 노드는 0
    var priorityQueue = PriorityQueue<Node>()  // ✅ 우선순위 큐

    // ✅ 시작 노드 추가
    priorityQueue.enqueue(Node(distance: 0, name: start))

    while !priorityQueue.isEmpty {
        guard let currentNode = priorityQueue.dequeue() else { break }

        let currentDistance = currentNode.distance
        let currentName = currentNode.name

        // ✅ 이미 처리된 거리보다 크면 무시
        if currentDistance > distances[currentName]! {
            continue
        }

        // ✅ 현재 방문한 노드 출력 (디버깅)
        print("현재 방문 노드: \(currentName), 거리: \(currentDistance)")

        // ✅ 인접 노드 탐색
        for (adjacent, weight) in graph[currentName] ?? [:] {
            let distance = currentDistance + weight

            // ✅ 더 짧은 경로 발견 시 업데이트
            if distance < distances[adjacent]! {
                distances[adjacent] = distance
                priorityQueue.enqueue(Node(distance: distance, name: adjacent))

                // ✅ 우선순위 큐에 추가된 값 확인
                print("  추가된 노드: \(adjacent), 거리: \(distance)")
            }
        }
    }

    // ✅ Python과 동일한 순서 보장 (A, B, C, D, E, F)
    let desiredOrder: [String] = ["A", "B", "C", "D", "E", "F"]
    let sortedDistances = desiredOrder.compactMap { key -> (String, Int)? in
        if let value = distances[key] {
            return (key, value)
        }
        return nil
    }

    return sortedDistances  // ✅ 튜플 리스트를 그대로 반환 (순서 유지)
}

// ✅ 그래프 정의
let myGraph: [String: [String: Int]] = [
    "A": ["B": 8, "C": 1, "D": 2],
    "B": [:],
    "C": ["B": 5, "D": 2],
    "D": ["E": 3, "F": 5],
    "E": ["F": 1],
    "F": ["A": 5]
]

// ✅ 다익스트라 실행
let shortestPaths = dijkstra(graph: myGraph, start: "A")

// ✅ Python과 동일한 형식으로 출력
print(shortestPaths)


//MARK: 참고 코드 typealias 예시
///  그래프 타입 정의
//typealias Graph = [String: [String: Int]]

//// 다익스트라 알고리즘 구현
//func dijkstra(graph: Graph, start: String) -> [String: Int] {
//    var distances: [String: Int] = [:]
//    // 모든 거리를 무한대로 초기화
//    for node in graph.keys {
//        distances[node] = Int.max
//    }
//    distances[start] = 0
//
//    var queue = PriorityQueue()
//    queue.push(Node(vertex: start, distance: 0))
//
//    while !queue.isEmpty {
//        guard let current = queue.pop() else { break }
//        let currentNode = current.vertex
//        let currentDistance = current.distance
//
//        if distances[currentNode]! < currentDistance {
//            continue
//        }
//
//        for (adjacent, weight) in graph[currentNode]! {
//            let distance = currentDistance + weight
//
//            if distance < distances[adjacent]! {
//                distances[adjacent] = distance
//                queue.push(Node(vertex: adjacent, distance: distance))
//            }
//        }
//    }
//
//    return distances
//}
//
//// 테스트
//let mygraph: Graph = [
//    "A": ["B": 8, "C": 1, "D": 2],
//    "B": [:],
//    "C": ["B": 5, "D": 2],
//    "D": ["E": 3, "F": 5],
//    "E": ["F": 1],
//    "F": ["A": 5]
//]


/*
 ### 🚀 **Swift에서 `PriorityQueue<Element: Comparable>`와 `Node: Comparable`의 문법적 이해**

 지금 네가 궁금한 핵심은 **PriorityQueue가 정렬할 때, Node의 distance 기준으로 정렬되는 이유**야.
 이걸 이해하려면 **제네릭(Generics)과 `Comparable` 프로토콜이 어떻게 작동하는지** 살펴보면 돼!

 ---

 ## ✅ **1️⃣ `struct PriorityQueue<Element: Comparable>` 문법 이해**
 ```swift
 struct PriorityQueue<Element: Comparable>
 ```
 👉 **`PriorityQueue`는 `Comparable`을 따르는 타입만 저장할 수 있다**는 뜻이야.

 즉, `Element`가 `Comparable`을 준수해야 `sort(by: { $0 < $1 })` 같은 비교 연산이 가능해.
 (`Comparable`을 따르는 타입은 `<=`, `<`, `>=`, `>` 등의 비교 연산을 할 수 있어.)

 ---

 ### 🔹 **📌 `PriorityQueue`에서 `enqueue()` 정렬 동작**
 ```swift
 mutating func enqueue(_ element: Element) {
     elements.append(element)  // ✅ 새로운 요소 추가
     elements.sort(by: { $0 < $1 })  // ✅ 작은 값이 먼저 오도록 정렬 (최소 힙 유지)
 }
 ```
 - `sort(by: { $0 < $1 })` 는 **Element가 `Comparable`을 따르기 때문에 작동 가능**.
 - 즉, **PriorityQueue에 넣은 `Element`가 `Node`라면, `Node`의 `<` 연산자 정의에 따라 정렬됨**.

 ---

 ## ✅ **2️⃣ `struct Node: Comparable` 문법 이해**
 ```swift
 struct Node: Comparable {
     let distance: Int  // ✅ 정렬 기준이 되는 값
     let name: String   // ✅ 정렬 기준과 상관없는 값
     
     // ✅ Node 간 비교를 정의
     static func < (lhs: Node, rhs: Node) -> Bool {
         return lhs.distance < rhs.distance  // ✅ 거리(distance)가 작은 순서로 정렬
     }
 }
 ```
 ### 🔥 **여기서 중요한 점**
 1. `Node`는 `Comparable`을 따르도록 선언되었기 때문에, **PriorityQueue에서 비교 연산(`sort`)이 가능해짐**.
 2. `static func <` 연산자를 `distance` 기준으로 오버로딩했으므로, **`Node`의 정렬은 항상 `distance` 기준으로 작동**.

 ---

 ## ✅ **3️⃣ `PriorityQueue<Node>`에서 정렬되는 원리**
 ### 🔹 **📌 정렬 과정**
 ```swift
 var pq = PriorityQueue<Node>()
 pq.enqueue(Node(distance: 5, name: "A"))
 pq.enqueue(Node(distance: 2, name: "B"))
 pq.enqueue(Node(distance: 8, name: "C"))
 ```
 1. **첫 번째 `enqueue(Node(distance: 5, name: "A"))`**
    - `elements = [Node(distance: 5, name: "A")]`
 2. **두 번째 `enqueue(Node(distance: 2, name: "B"))`**
    - `elements = [Node(distance: 5, name: "A"), Node(distance: 2, name: "B")]`
    - `sort(by: { $0 < $1 })` 실행 → `distance` 기준으로 정렬
    - `elements = [Node(distance: 2, name: "B"), Node(distance: 5, name: "A")]`
 3. **세 번째 `enqueue(Node(distance: 8, name: "C"))`**
    - `elements = [Node(distance: 2, name: "B"), Node(distance: 5, name: "A"), Node(distance: 8, name: "C")]`
    - 정렬 필요 없음 (이미 정렬됨)

 ### 🔥 **출력 결과**
 ```swift
 print(pq.dequeue()!)  // ✅ Node(distance: 2, name: "B")
 print(pq.dequeue()!)  // ✅ Node(distance: 5, name: "A")
 print(pq.dequeue()!)  // ✅ Node(distance: 8, name: "C")
 ```
 👉 **항상 `distance` 값이 작은 순서대로 나옴!** ✅

 ---

 ## ✅ **4️⃣ 최종 정리**
 | 🚀 문법 개념 | ✅ 설명 |
 |-------------|-------------|
 | **`struct PriorityQueue<Element: Comparable>`** | 제네릭을 사용하여, `Comparable`을 따르는 타입만 저장 가능 |
 | **`enqueue()`에서 `sort(by: { $0 < $1 })`** | `Comparable`을 따르는 `Element` 기준으로 정렬 |
 | **`struct Node: Comparable`** | `distance` 값을 기준으로 `<` 연산자 정의 |
 | **`PriorityQueue<Node>` 사용 시** | `distance` 기준으로 최소 힙이 유지됨 |

 ---

 ### 🔥 **한 줄 요약**
 📌 **PriorityQueue에서 `sort(by: { $0 < $1 })`를 실행하면, `Node`의 `<` 연산자 오버로딩을 따라가면서 `distance` 기준으로 정렬됨!** 🚀✅
 */
