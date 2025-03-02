// ✅ 제네릭 `Node<T>` 클래스 정의 (양방향 연결 리스트)
class Node<T> {
    var data: T
    var prev: Node<T>?
    var next: Node<T>?

    init(data: T) {
        self.data = data
        self.prev = nil
        self.next = nil
    }
}

// ✅ 제네릭 `DoublyLinkedList<T>` 클래스 정의 (양방향 연결 리스트)
class DoublyLinkedList<T> {
    private var head: Node<T>?
    private var tail: Node<T>?

    // ✅ 노드 추가 (맨 끝에 추가)
    func append(_ data: T) {
        let newNode = Node(data: data)
        
        if head == nil {
            head = newNode
            tail = newNode
        } else {
            tail?.next = newNode
            newNode.prev = tail
            tail = newNode
        }
    }

    // ✅ 노드 삭제 (특정 데이터 값 삭제)
    func delete(_ data: T) where T: Equatable {
        // 리스트가 비어있으면 삭제할 수 없음
        if head == nil {
            print("삭제할 노드가 없습니다.")
            return
        }

        // 첫 번째 노드가 삭제하려는 데이터인 경우
        if head?.data == data {
            head = head?.next
            head?.prev = nil
            return
        }

        var node = head
        while node != nil {
            if node?.data == data {
                node?.prev?.next = node?.next  // 앞 노드와 뒷 노드 연결
                node?.next?.prev = node?.prev
                return
            }
            node = node?.next
        }

        print("해당 값을 가진 노드가 없습니다.")  // 삭제할 값이 없을 경우
    }

    // ✅ 앞에서부터 검색 (특정 데이터 값을 가진 노드 찾기)
    func searchFromHead(_ data: T) -> Node<T>? where T: Equatable {
        var node = head
        while node != nil {
            if node?.data == data {
                return node  // 찾은 노드를 반환
            }
            node = node?.next
        }
        return nil  // 찾을 수 없으면 nil 반환
    }

    // ✅ 뒤에서부터 검색 (특정 데이터 값을 가진 노드 찾기)
    func searchFromTail(_ data: T) -> Node<T>? where T: Equatable {
        var node = tail
        while node != nil {
            if node?.data == data {
                return node  // 찾은 노드를 반환
            }
            node = node?.prev
        }
        return nil  // 찾을 수 없으면 nil 반환
    }

    // ✅ 모든 노드 출력 (앞에서 뒤로)
    func printListForward() {
        var node = head
        while node != nil {
            print(node!.data, terminator: " <-> ")  // 앞에서 뒤로 연결
            node = node?.next
        }
        print("nil")
    }

    // ✅ 모든 노드 출력 (뒤에서 앞으로)
    func printListBackward() {
        var node = tail
        while node != nil {
            print(node!.data, terminator: " <-> ")  // 뒤에서 앞으로 연결
            node = node?.prev
        }
        print("nil")
    }
}


let doublyLinkedList = DoublyLinkedList<Int>()
doublyLinkedList.append(1)
doublyLinkedList.append(2)
doublyLinkedList.append(3)
doublyLinkedList.append(4)

print("앞에서 뒤로 출력:")
doublyLinkedList.printListForward()

print("뒤에서 앞으로 출력:")
doublyLinkedList.printListBackward()

// 앞에서부터 검색
if let foundNode = doublyLinkedList.searchFromHead(3) {
    print("앞에서 찾은 노드의 데이터: \(foundNode.data)")  // 결과: 3
} else {
    print("찾은 노드가 없습니다. (앞에서부터)")
}

// 뒤에서부터 검색
if let foundNode = doublyLinkedList.searchFromTail(3) {
    print("뒤에서 찾은 노드의 데이터: \(foundNode.data)")  // 결과: 3
} else {
    print("찾은 노드가 없습니다. (뒤에서부터)")
}

doublyLinkedList.delete(3)

print("삭제 후 앞에서 뒤로 출력:")
doublyLinkedList.printListForward()

// 삭제 후 다시 검색
if let foundNode = doublyLinkedList.searchFromHead(3) {
    print("앞에서 찾은 노드의 데이터: \(foundNode.data)")  // 해당 노드가 삭제되었으므로 검색되지 않습니다.
} else {
    print("찾은 노드가 없습니다. (앞에서부터)")  // 결과: 해당 노드가 없습니다.
}
