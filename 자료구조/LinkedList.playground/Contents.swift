
import Foundation

/*
 ✅ 오버헤드(Overhead)란?
 "오버헤드(Overhead)"란 프로그램을 실행하거나 특정 연산을 수행할 때 추가로 발생하는 비용(리소스, 시간, 메모리 등)을 의미해.
 즉, 실제 작업과는 직접적인 관련이 없지만, 필수적으로 발생하는 부가적인 비용
 */


//MARK: 연결 리스트는 연속되지 않은 메모리에 저장된 데이터들을 연결시켜 놓은 것


import Foundation

// ✅ 노드 클래스 정의
class Node {
    var data: Int
    var next: Node?

    init(_ data: Int) {
        self.data = data
        self.next = nil
    }
}

// ✅ 단방향 링크드 리스트 클래스
class LinkedList {
    var head: Node?  // ✅ 첫 번째 노드(헤드)

    // ✅ 생성자 (초기값 설정)
    init(_ data: Int) {
        self.head = Node(data)
    }

    // ✅ 노드 추가 함수 (맨 끝에 추가)
    func add(_ data: Int) {
        if head == nil {  // 리스트가 비어 있으면 새로운 헤드를 설정
            head = Node(data)
            return
        }
        var node = head
        while node?.next != nil {
            node = node?.next  // 마지막 노드까지 이동
        }
        node?.next = Node(data)  // 새 노드 추가
    }

    // ✅ 노드 삭제 함수
    func delete(_ data: Int) {
        if head == nil {  // 리스트가 비어있다면 삭제 불가
            print("삭제할 노드가 없습니다.")
            return
        }

        if head?.data == data {  // 헤드를 삭제하는 경우
            head = head?.next  // 다음 노드를 헤드로 변경
            return
        }

        var node = head
        while node?.next != nil {
            if node?.next?.data == data {  // 삭제할 노드를 찾음
                node?.next = node?.next?.next  // 노드 연결을 건너뛰어 삭제
                return
            }
            node = node?.next  // 다음 노드로 이동
        }

        print("해당 값을 가진 노드가 없습니다.")  // 삭제할 값이 없는 경우
    }

    // ✅ 모든 노드 출력 함수
    func printList() {
        var node = head
        while node != nil {
            print(node!.data, terminator: " -> ")  // 줄바꿈 없이 출력
            node = node?.next
        }
        print("nil")  // 마지막에 nil 표시
    }
}

// ✅ 사용 예제
let linkedList = LinkedList(10)
linkedList.add(20)
linkedList.add(30)
linkedList.add(40)

print("🚀 리스트 출력:")
linkedList.printList()  // ✅ 출력: 10 -> 20 -> 30 -> 40 -> nil

print("\n🗑️ 노드 삭제 (30)")
linkedList.delete(30)
linkedList.printList()  // ✅ 출력: 10 -> 20 -> 40 -> nil

print("\n🗑️ 노드 삭제 (10) - 헤드 삭제")
linkedList.delete(10)
linkedList.printList()  // ✅ 출력: 20 -> 40 -> nil


// ✅ 제네릭 `Node<T>` 클래스 정의
class Node2<T> {
    var data: T
    var next: Node2<T>?

    init(_ data: T) {
        self.data = data
        self.next = nil
    }
}

// ✅ 제네릭 `LinkedList<T>` 클래스 정의
class LinkedList2<T> {
    var head: Node2<T>?  // ✅ 첫 번째 노드(헤드)

    // ✅ 노드 추가 (맨 끝에 추가)
    func add(_ data: T) {
        let newNode = Node2(data)
        if head == nil {  // 리스트가 비어 있으면 새로운 헤드 설정
            head = newNode
            return
        }

        var node = head
        while node?.next != nil {
            node = node?.next  // 마지막 노드까지 이동
        }
        node?.next = newNode  // 새 노드 추가
    }

    // ✅ 특정 데이터를 가진 노드 삭제
    func delete(_ data: T) where T: Equatable { // ✅ `T`가 `Equatable` 해야 비교 가능
        if head == nil {  // 리스트가 비어있으면 삭제 불가
            print("삭제할 노드가 없습니다.")
            return
        }

        if head?.data == data {  // 헤드를 삭제하는 경우
            head = head?.next  // 다음 노드를 헤드로 변경
            return
        }

        var node = head
        while node?.next != nil {
            if node?.next?.data == data {  // 삭제할 노드를 찾음
                node?.next = node?.next?.next  // 노드 연결 변경 (삭제)
                return
            }
            node = node?.next  // 다음 노드로 이동
        }

        print("해당 값을 가진 노드가 없습니다.")  // 삭제할 값이 없는 경우
    }

    // ✅ 모든 노드 출력 함수
    func printList() {
        var node = head
        while node != nil {
            print(node!.data, terminator: " -> ")  // 줄바꿈 없이 출력
            node = node?.next
        }
        print("nil")  // 마지막에 nil 표시
    }
}
/*
 delete(_ data: T)에서 Equatable을 사용한 이유
 제네릭(T)은 기본적으로 == 비교 연산을 사용할 수 없음.
 where T: Equatable을 추가하면 T가 == 비교 가능하도록 제한됨.
 즉, delete()에서 값을 비교하려면 T가 Equatable을 준수해야 함! 🚀
 */


//MARK: node?.next = node?.next?.next ARC(Automatic Reference Counting)가 자동으로 메모리를 해제하는지?
/*

 ✅ 정답: 네! ARC가 자동으로 메모리를 해제한다.
 Swift는 강한 참조(Strong Reference) 기반의 ARC를 사용하여 더 이상 참조되지 않는 객체를 자동으로 메모리에서 해제해.
 즉, 어떤 노드도 참조하지 않는 객체가 되면 ARC가 자동으로 메모리에서 제거해. 🚀

 ✅ 1️⃣ node?.next = node?.next?.next 로 삭제가 되는 원리
 if node?.next?.data == data {  // 삭제할 노드를 찾았을 때
     node?.next = node?.next?.next  // ✅ 기존 노드를 건너뛰고 연결 변경
 }
 🔹 삭제 전 (예제)
 10 -> 20 -> 30 -> 40 -> nil
 
 🔹 삭제 과정 (delete(30))
 node?.next = node?.next?.next 실행
 20 -> 30 -> 40 구조에서 30이 사라지고 20 -> 40으로 연결됨
 기존 30 노드는 더 이상 참조되지 않음 → ARC가 자동으로 메모리에서 해제

 10 -> 20 -> 40 -> nil
 🔹 삭제 후
 30을 참조하는 노드가 없음 → ARC가 자동으로 메모리에서 해제! ✅
 
 ✅ 2️⃣ ARC(Automatic Reference Counting)가 메모리를 정리하는 원리
 📌 Swift는 강한 참조(Strong Reference)를 기반으로 자동 메모리 관리를 수행

 객체(노드)가 변수 또는 다른 객체에 의해 참조될 때만 유지됨
 모든 참조가 사라지면 ARC가 자동으로 해제
 node?.next = node?.next?.next로 기존 노드가 끊어지면 ARC가 자동으로 정리!
 */
