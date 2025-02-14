import Foundation

class Node {
    var value: Int
    var left: Node?
    var right: Node?

    init(value: Int) {
        self.value = value
        self.left = nil
        self.right = nil
    }
}

class BinaryTree {
    var head: Node?

    init(head: Node) {
        self.head = head
    }

    // ✅ 노드 삽입 (Insert)
    func insert(_ value: Int) {
        guard let head = self.head else {
            self.head = Node(value: value)
            return
        }
        
        var currentNode: Node? = head

        while let node = currentNode { // nil이 아닐 때만 루프를 실행
            if value < node.value {
                if let leftNode = node.left {
                    currentNode = leftNode
                } else {
                    node.left = Node(value: value)
                    break
                }
            } else {
                if let rightNode = node.right {
                    currentNode = rightNode
                } else {
                    node.right = Node(value: value)
                    break
                }
            }
        }
    }

    // ✅ 노드 탐색 (Search)
    func search(_ value: Int) -> Bool {
        var currentNode = self.head

        while let node = currentNode {
            if node.value == value {
                return true
            } else if value < node.value {
                currentNode = node.left
            } else {
                currentNode = node.right
            }
        }
        return false
    }

    // ✅ 노드 삭제 (Delete)
    func delete(_ value: Int) -> Bool {
        var currentNode = self.head
        var parentNode: Node? = nil
        var searched = false

        // 📌 삭제할 노드 찾기
        while let node = currentNode {
            if node.value == value {
                searched = true
                break
            } else if value < node.value {
                parentNode = node
                currentNode = node.left
            } else {
                parentNode = node
                currentNode = node.right
            }
        }

        // 📌 삭제할 노드가 없으면 false 반환
        if !searched { return false }

        guard let deleteNode = currentNode else { return false }

        // 📌 1. 삭제할 노드가 **자식이 없는 경우 (Leaf Node)**
        if deleteNode.left == nil && deleteNode.right == nil {
            if value < parentNode!.value {
                parentNode!.left = nil
            } else {
                parentNode!.right = nil
            }
        }

        // 📌 2. 삭제할 노드가 **자식이 하나 있는 경우**
        else if deleteNode.left != nil && deleteNode.right == nil {
            if value < parentNode!.value {
                parentNode!.left = deleteNode.left
            } else {
                parentNode!.right = deleteNode.left
            }
        } else if deleteNode.left == nil && deleteNode.right != nil {
            if value < parentNode!.value {
                parentNode!.left = deleteNode.right
            } else {
                parentNode!.right = deleteNode.right
            }
        }

        // 📌 3. 삭제할 노드가 자식이 두 개 있는 경우
        else {
            var changeNode = deleteNode.right  // 🔹 삭제할 노드의 오른쪽 서브트리
            var changeNodeParent = deleteNode.right  // 🔹 부모 노드도 미리 저장

            // 🔹 1️⃣ 오른쪽 서브트리에서 가장 작은 값 찾기 (왼쪽으로 이동)
            while let left = changeNode?.left {
                changeNodeParent = changeNode  // 🔹 부모를 변경
                changeNode = left  // 🔹 한 단계 아래 왼쪽으로 이동
            }

            // 🔹 2️⃣ 대체할 노드(changeNode)가 오른쪽 자식이 있다면, 부모와 연결 변경
            if let changeRight = changeNode?.right {
                changeNodeParent?.left = changeRight  // 🔹 부모의 왼쪽을 교체 노드의 오른쪽과 연결
            } else {
                changeNodeParent?.left = nil  // 🔹 없으면 부모의 왼쪽을 nil로 설정
            }

            // 🔹 3️⃣ 삭제할 노드의 부모와 변경된 노드 연결
            if value < parentNode!.value {
                parentNode!.left = changeNode
            } else {
                parentNode!.right = changeNode
            }

            // 🔹 4️⃣ 교체된 노드의 왼쪽, 오른쪽 자식을 삭제할 노드의 자식으로 변경
            changeNode?.left = deleteNode.left
            changeNode?.right = deleteNode.right
        }

        return true
    }
}

// ✅ 테스트 코드
let root = Node(value: 10)
let tree = BinaryTree(head: root)

// 노드 삽입
tree.insert(5)
tree.insert(15)
tree.insert(2)
tree.insert(7)
tree.insert(12)
tree.insert(18)

// ✅ 노드 탐색 테스트
print(tree.search(7))  // true
print(tree.search(20)) // false

// ✅ 노드 삭제 테스트
print(tree.delete(7))  // true
print(tree.search(7))  // false
