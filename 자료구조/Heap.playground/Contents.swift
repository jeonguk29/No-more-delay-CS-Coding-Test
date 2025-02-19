import Foundation

class Heap {
    var heapArray: [Int?]  // ✅ Python의 `list` 대신 Swift 배열 사용
    
    init(data: Int) {
        heapArray = [nil, data]  // ✅ Python의 `None`을 `nil`로 대체
    }
    
    // ✅ moveUp: 부모보다 크면 true 반환 (교환 필요)
    func moveUp(_ insertedIdx: Int) -> Bool {
        if insertedIdx <= 1 {
            return false
        }
        let parentIdx = insertedIdx / 2
        if let insertedValue = heapArray[insertedIdx],
           let parentValue = heapArray[parentIdx] {
            return insertedValue > parentValue
        }
        return false
    }
    
    // ✅ insert: 힙에 데이터 삽입 후 정렬
    func insert(_ data: Int) -> Bool {
        if heapArray.count == 1 {
            heapArray.append(data)
            return true
        }
        
        heapArray.append(data)
        var insertedIdx = heapArray.count - 1
        
        while moveUp(insertedIdx) {
            let parentIdx = insertedIdx / 2
            heapArray.swapAt(insertedIdx, parentIdx)
            insertedIdx = parentIdx
        }
        return true
    }
    
    // ✅ moveDown: 부모 노드가 자식보다 작을 경우 true 반환 (교환 필요)
    func moveDown(_ poppedIdx: Int) -> Bool {
        let leftChildIdx = poppedIdx * 2
        let rightChildIdx = poppedIdx * 2 + 1
        
        // Case 1: 왼쪽 자식이 없을 때 - left_child_popped_idx 크다는 건 없는데를 가르키고 있다는 것임
        if leftChildIdx >= heapArray.count {
            return false
        }
        
        // Case 2: 오른쪽 자식만 없을 때
        if rightChildIdx >= heapArray.count {
            if let poppedValue = heapArray[poppedIdx],
               let leftChildValue = heapArray[leftChildIdx] {
                return poppedValue < leftChildValue // 추출된 인덱스와 왼쪽 자식을 비교
            }
            return false
        }
        
        // Case 3: 왼쪽 & 오른쪽 자식 모두 있을 때
        if let leftChildValue = heapArray[leftChildIdx],
           let rightChildValue = heapArray[rightChildIdx],
           let poppedValue = heapArray[poppedIdx] {
            // 자식 노드끼리 비교 이후 부모 노드 즉 지금 자기와 다시 비교
            if leftChildValue > rightChildValue {
                return poppedValue < leftChildValue // 왼쪽이 더 클때 자기와 비교
            } else {
                return poppedValue < rightChildValue
            }
        }
        return false
    }
    
    // ✅ pop: 루트 노드 제거 후, 힙 재정렬
    func pop() -> Int? {
        if heapArray.count <= 1 {
            return nil  // ✅ Python의 `None`을 `nil`로 변환
        }
        
        let returnedData = heapArray[1]  // ✅ 루트 노드 저장
        
        if let lastElement = heapArray.last {
            heapArray[1] = lastElement  // ✅ 마지막 요소를 루트로 이동
        } else {
            return nil  // ✅ 배열이 비었으면 nil 반환
        }
        
        heapArray.removeLast()  // ✅ 마지막 요소 제거
        var poppedIdx = 1  // ✅ 루트에서 시작
        
        while moveDown(poppedIdx) { // moveDown(poppedIdx) 참 거짓으로 판단만 했으니 반환 값에 따라서 값 변경 까지 해줘야함
            let leftChildIdx = poppedIdx * 2
            let rightChildIdx = poppedIdx * 2 + 1
            
            // Case 2: 오른쪽 자식이 없는 경우 -  왼쪽은 없으면 그냥 끝내면 됨 그자리에 넣으면 끝이라
            if rightChildIdx >= heapArray.count {
                if let poppedValue = heapArray[poppedIdx],
                   let leftChildValue = heapArray[leftChildIdx],
                   poppedValue < leftChildValue {
                    heapArray.swapAt(poppedIdx, leftChildIdx)
                    poppedIdx = leftChildIdx
                }
            }
            // Case 3: 왼쪽 & 오른쪽 자식이 있는 경우
            else {
                if let leftChildValue = heapArray[leftChildIdx],
                   let rightChildValue = heapArray[rightChildIdx],
                   let poppedValue = heapArray[poppedIdx] {
                    
                    if leftChildValue > rightChildValue {
                        if poppedValue < leftChildValue {
                            heapArray.swapAt(poppedIdx, leftChildIdx)
                            poppedIdx = leftChildIdx
                        }
                    } else {
                        if poppedValue < rightChildValue {
                            heapArray.swapAt(poppedIdx, rightChildIdx)
                            poppedIdx = rightChildIdx
                        }
                    }
                }
            }
        }
        return returnedData
    }
}

var heap = Heap(data: 15)
heap.insert(10)
heap.insert(8)
heap.insert(5)
heap.insert(4)
heap.insert(20)
print(heap.heapArray)
heap.pop()
print(heap.heapArray)
