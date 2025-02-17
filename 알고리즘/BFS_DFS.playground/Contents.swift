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


//MARK: 그리디 알고리즘


var coin_list = [1, 100, 50, 500]
coin_list.sort(by: >) // tip sorted(by: >)  // ✅ 내림차순 정렬된 새 배열 반환, 동사 원형은 자체적인 변환을 함

func min_coin_count(_ value: Int, _ coin_list: [Int]) -> (Int, [[Int]]) {
    var value = value
    var totalCount = 0
    var details = [[Int]]()  // ✅ 2차원 배열로 변경

    for coin in coin_list {
        let coin_Count = value / coin  // ✅ 나누어서 해당 코인 개수 계산
        totalCount += coin_Count
        value = value % coin  // ✅ 나머지 금액 계산
        details.append([coin, coin_Count])  // ✅ 올바르게 배열 추가
    }

    return (totalCount, details)  // ✅ 튜플 반환
}

// ✅ 테스트 실행
let result = min_coin_count(4720, coin_list)

print(result.0)  // ✅ 총 동전 개수
print(result.1)  // ✅ [[500, 9], [100, 2], [50, 0], [1, 20]]


// 문제 2 : 부분 배낭 문제
var dataList: [(Int, Int)] = [(10, 10), (15, 12), (20, 10), (25, 8), (30, 5)]

func get_max_value(_ dataList: [(Int, Int)], _ capacity: Int) -> (Double, [[Double]]) {
    // ✅ 1️⃣ 내림차순 정렬 (가치/무게 비율 기준)
    let sortedDataList = dataList.sorted { (a, b) in
        return Double(a.1) / Double(a.0) > Double(b.1) / Double(b.0)
    }

    var remainingCapacity = Double(capacity)  // ✅ 남은 배낭 용량 (Double 타입으로 변환)
    var totalValue: Double = 0  // ✅ 총 가치
    var details: [[Double]] = []  // ✅ [무게, 가치, 넣은 비율] 리스트

    // ✅ 2️⃣ 반복문을 돌면서 배낭에 아이템 추가
    for data in sortedDataList {
        let weight = Double(data.0)
        let value = Double(data.1)

        if remainingCapacity >= weight {
            // ✅ 3️⃣ 배낭에 아이템 전체를 넣을 수 있는 경우 (100%)
            remainingCapacity -= weight
            totalValue += value
            details.append([weight, value, 1.0])  // ✅ 100% 넣음
        } else {
            // ✅ 4️⃣ 배낭에 일부만 넣어야 하는 경우
            let fraction = remainingCapacity / weight  // ✅ 넣을 수 있는 비율 계산
            totalValue += value * fraction  // ✅ 가치도 해당 비율만큼 증가
            details.append([weight, value, fraction])  // ✅ 일부만 넣음
            break  // ✅ 배낭이 꽉 찼으므로 종료
        }
    }

    return (totalValue, details)  // ✅ 최종 결과 반환
}

print(get_max_value(dataList, 30))
