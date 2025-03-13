import Foundation

// https://jeonyeohun.tistory.com/327

// 힙 자료구조 구현
struct Heap<T: Comparable> {
    var elements: [T] = [] // 힙을 저장할 배열
    let sortFunction: (T, T) -> Bool // 힙의 정렬 기준 함수 (최소 힙 또는 최대 힙)

    // 힙 생성자, 정렬 기준 함수와 초기 원소 배열을 받음
    init(elements: [T] = [], sortFunction: @escaping (T, T) -> Bool) {
        self.elements = elements
        self.sortFunction = sortFunction
        buildHeap() // 힙을 초기화할 때 전체 배열을 힙으로 변환
    }

    // 힙을 빌드하는 함수
    mutating func buildHeap() {
        // 배열의 중간부터 시작하여 힙을 아래로 정렬
        for i in (0..<elements.count / 2).reversed() {
            heapifyDown(from: i)
        }
    }

    // 힙의 맨 위 요소를 확인하는 함수 (peek)
    func peek() -> T? {
        return elements.first
    }

    // 새로운 원소를 삽입하는 함수
    mutating func insert(node: T) {
        elements.append(node) // 배열의 끝에 추가
        heapifyUp() // 추가한 원소를 적절한 위치로 올리기
    }

    // 맨 위 원소를 꺼내는 함수 (pop)
    mutating func remove() -> T? {
        guard !elements.isEmpty else { return nil }
        
        // 루트 노드를 꺼내고, 마지막 노드를 루트로 이동
        let removedValue = elements[0]
        if elements.count == 1 {
            elements.removeLast()
        } else {
            elements[0] = elements.removeLast()
            heapifyDown() // 힙 속성을 유지하기 위해 재정렬
        }
        
        return removedValue
    }

    // 힙 위로 올리기 (상향 힙 정렬)
    mutating func heapifyUp() {
        var index = elements.count - 1 // 마지막 원소부터 시작
        while index > 0 {
            let parentIndex = (index - 1) / 2
            if sortFunction(elements[index], elements[parentIndex]) {
                elements.swapAt(index, parentIndex) // 부모와 자식이 기준에 맞지 않으면 교환
                index = parentIndex
            } else {
                break
            }
        }
    }

    // 힙 아래로 내리기 (하향 힙 정렬)
    mutating func heapifyDown(from index: Int = 0) {
        var index = index
        let leftChildIndex = 2 * index + 1
        let rightChildIndex = 2 * index + 2
        var smallest = index
        
        // 왼쪽 자식이 존재하고, 더 작은 값을 가질 경우
        if leftChildIndex < elements.count && sortFunction(elements[leftChildIndex], elements[smallest]) {
            smallest = leftChildIndex
        }
        
        // 오른쪽 자식이 존재하고, 더 작은 값을 가질 경우
        if rightChildIndex < elements.count && sortFunction(elements[rightChildIndex], elements[smallest]) {
            smallest = rightChildIndex
        }
        
        // 만약 부모가 자식보다 크다면, 부모와 자식을 교환
        if smallest != index {
            elements.swapAt(index, smallest)
            heapifyDown(from: smallest)
        }
    }
}

// 우선 순위 큐 구현
struct PriorityQueue<T: Comparable> {
    var heap: Heap<T>  // 힙 자료구조를 사용하여 우선 순위 큐를 관리
    
    // 초기화 시 힙과 정렬 기준 함수를 설정
    init(_ elements: [T] = [], sort: @escaping (T, T) -> Bool) {
        heap = Heap(elements: elements, sortFunction: sort)
    }
    
    // 큐의 크기를 반환
    var count: Int {
        return heap.elements.count
    }
    
    // 큐가 비어있는지 확인
    var isEmpty: Bool {
        return heap.elements.isEmpty
    }
    
    // 큐에서 우선순위가 가장 높은 값을 확인
    func top() -> T? {
        return heap.peek()
    }
    
    // 큐를 비우는 메서드
    mutating func clear() {
        while !heap.elements.isEmpty {
            _ = heap.remove()
        }
    }
    
    // 큐에서 우선순위가 가장 높은 원소를 꺼내는 메서드
    mutating func pop() -> T? {
        return heap.remove()
    }
    
    // 큐에 새로운 원소를 삽입하는 메서드
    mutating func push(_ element: T) {
        heap.insert(node: element)
    }
}

// 우선 순위 큐 테스트
var pq = PriorityQueue([3, 5, 1, 2, 8]) { $0 < $1 }  // 오름차순으로 정렬 (최소 힙)

print(pq.top()!)  // 1 출력

pq.pop()  // 1을 제거
print(pq.top()!)  // 2 출력

pq.push(0)  // 0을 추가
print(pq.top()!)  // 0 출력
