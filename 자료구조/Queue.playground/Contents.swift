
import Foundation

//MARK: 1. Swift로 Queue 구현하기

struct Queue<T> {
    private var queue: [T] = []
    
    public var count: Int {
        return queue.count
    }
    
    public var isEmpty: Bool {
        return queue.isEmpty
    }
    
    public mutating func enqueue(_ element: T) {
        queue.append(element)
    }
    
    public mutating func dequeue() -> T? {
        return isEmpty ? nil : queue.removeFirst()
    }
}


var myQueue = Queue<Int>()
myQueue.enqueue(10)
myQueue.dequeue()

/*
 ✅ 1️⃣ 제네릭(T)이란?
 
 제네릭(Generic)이란?
 자료형(Int, String, Double 등)에 의존하지 않는 재사용 가능한 코드를 작성할 수 있도록 도와줌.
 Queue<T>에서 T는 임의의 자료형을 의미하며, Int, String, CustomType 등 모든 타입을 사용할 수 있음.
 
 Swift에서 struct는 기본적으로 let 속성을 가지며, 내부 값을 변경할 수 없어.
 하지만 구조체(struct)는 값 타입(Value Type)이기 때문에 내부 변수를 수정하려면 mutating 키워드가 필요
 */

//MARK: 2. Dequeue에 효율적인 Queue
/*
 dequeue 시 배열을 앞당겨주는 작업을 최소화 하는 것임!!
 어떻게?
 실제 배열의 Head를 삭제하는 것이 아닌,
 현재 Head를 가리키고 있는 포인트를 변경시켜서
 dequeue가 호출될 때마다 하던 배열의 삭제 작업을 하지 않는 것임
 대신, 더 이상 필요없는 dequeue된 element는 nil로 만들어주는 것임
 
 dequeue 시 반환되어야하는 element의 index를 들고 있는 것임!
 그러면 dequeue가 불릴 때마다,
 element를 삭제하고, 나머지 element를 당겨오는 과정이 없기 때문에
 오버헤드가 발생하지 않음, 즉 O(1) 될 수 있음!
 
 
 대신!!
 만약 enqueue를 계속 할 수록, nil로 할당된 dequeue된 element를 언제까지 들고 있을 순 없으니까,
 적정한 때에 dequeue 된 element들을 remove하는 작업을 해주는 것임
 
 */

struct Queue2<T> {
    private var queue: [T?] = []
    private var head: Int = 0
    
    public var count: Int {
        return queue.count
    }
    
    public var isEmpty: Bool {
        return queue.isEmpty
    }
    
    public mutating func enqueue(_ element: T) {
        queue.append(element)
    }
    
    // ✅ 큐에서 데이터 제거 (FIFO)
    public mutating func dequeue() -> T? {
        guard head <= queue.count, let element = queue[head] else { return nil }  // ✅ 조건 검사 & 값 가져오기
        queue[head] = nil  // ✅ 사용한 요소를 nil로 변경
        head += 1  // ✅ head 증가
        
        if head > 50 {  // ✅ 최적화 (배열 이동 최소화)
            queue.removeFirst(head)  // ✅ `removeFirst()`는 최소한으로 사용
            head = 0  // ✅ `head` 초기화
        }
        return element
    }
}
// queue.removeFirst(head)가 실행되면 head(현재 51)의 개수만큼 요소가 제거돼!
// 즉, removeFirst(51)를 호출하면 앞에서 51개의 요소가 한 번에 삭제돼.

var myQueue2 = Queue2<Int>()
myQueue2.enqueue(10)
myQueue2.dequeue()

