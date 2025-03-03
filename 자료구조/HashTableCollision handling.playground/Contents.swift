import Foundation

/*
 Chaining 기법
 개방 해싱 또는 Open Hashing 기법 중 하나: 해쉬 테이블 저장공간 외의 공간을 활용하는 기법
 충돌이 일어나면, 링크드 리스트라는 자료 구조를 사용해서, 링크드 리스트로 데이터를 추가로 뒤에 연결시켜서 저장하는 기법
 */

// 8개의 빈 슬롯을 가진 해시 테이블 초기화
var hashTable: [[[Int: Any]]] = Array(repeating: [], count: 8)
print("hashTable \(hashTable)")

// 데이터에서 해시 키를 가져오는 함수
func getKey(_ data: String) -> Int {
    return data.hashValue // 문자열을 해시값으로 변환하여 리턴
}

// 해시 함수: 해시 키를 8로 나눈 나머지를 사용하여 해시 테이블의 주소를 결정
func hashFunction(_ key: Int) -> Int {
    return abs(key % 8) // 절대값을 사용해 음수 인덱스 문제 방지
}

// 데이터 저장 함수
func saveData(_ data: String, value: Any) {
    let indexKey = getKey(data) // 데이터로부터 해시 키를 생성
    let hashAddress = hashFunction(indexKey) // 해시 주소 계산
    
    // 해당 주소가 비어있으면, 새로운 key-value 쌍 추가
    if hashTable[hashAddress].isEmpty {
        hashTable[hashAddress].append([indexKey: value])
    } else {
        // 해당 주소에 이미 데이터가 있으면, 기존 데이터가 있는지 확인
        for (index, dict) in hashTable[hashAddress].enumerated() {
            if dict.keys.first == indexKey {
                // 동일한 키가 있으면 값을 업데이트
                hashTable[hashAddress][index] = [indexKey: value]
                return
            }
        }
        // 동일한 키가 없으면, 새로운 데이터를 추가
        hashTable[hashAddress].append([indexKey: value])
    }
}

// 데이터 조회 함수
func readData(_ data: String) -> Any? {
    let indexKey = getKey(data) // 데이터로부터 해시 키를 생성
    let hashAddress = hashFunction(indexKey) // 해시 주소 계산
    
    // 해당 주소에 데이터가 있는지 확인
    if hashTable[hashAddress].isEmpty {
        return nil // 데이터가 없으면 nil 리턴
    } else {
        // 해당 주소에 있는 연결 리스트에서 키를 찾아 값 리턴
        for dict in hashTable[hashAddress] {
            if dict.keys.first == indexKey {
                return dict[indexKey] // 해당 키를 찾으면 값을 반환
            }
        }
        return nil // 데이터가 없으면 nil 리턴
    }
}

// 예시 사용
saveData("apple", value: "사과")
saveData("banana", value: "바나나")
print(readData("apple") as Any) // 출력: Optional("사과")
print(readData("banana") as Any) // 출력: Optional("바나나")
print(readData("orange") as Any) // 출력: nil


/*
Linear Probing 기법
폐쇄 해슁 또는 Close Hashing 기법 중 하나: 해쉬 테이블 저장공간 안에서 충돌 문제를 해결하는 기법
충돌이 일어나면, 해당 hash address의 다음 address부터 맨 처음 나오는 빈공간에 저장하는 기법
저장공간 활용도를 높이기 위한 기법
*/

// 8개의 빈 슬롯을 가진 선형 탐색 해시 테이블 초기화
var linearHashTable: [Any] = Array(repeating: 0, count: 8)

// 데이터에서 해시 키를 가져오는 함수
func linearGetKey(_ data: String) -> Int {
    return data.hashValue // 문자열을 해시값으로 변환하여 리턴
}

// 선형 탐색용 해시 함수
func linearHashFunction(_ key: Int) -> Int {
    return abs(key % 8) // 해시 주소 계산
}

// 데이터 저장 함수 (선형 탐색 방식)
func linearSaveData(_ data: String, value: Any) {
    let indexKey = linearGetKey(data) // 데이터로부터 해시 키를 생성
    var hashAddress = linearHashFunction(indexKey) // 해시 주소 계산
    
    // 해당 주소에 이미 데이터가 있으면 선형 탐색으로 빈 슬롯을 찾음
    if (linearHashTable[hashAddress] as? Int) != 0 {
        // 빈 슬롯을 찾을 때까지 탐색
        for index in hashAddress..<linearHashTable.count {
            // 빈 슬롯을 찾으면 삽입
            if (linearHashTable[index] as? Int) == 0 {
                linearHashTable[index] = [indexKey, value]
                return
            }
            // 기존 키가 있는 경우 값을 업데이트
            else if let currentValue = linearHashTable[index] as? [Any],
                    let currentKey = currentValue[0] as? Int,
                    currentKey == indexKey {
                linearHashTable[index] = [indexKey, value]
                return
            }
        }
    } else {
        // 빈 슬롯에 새로운 데이터 삽입
        linearHashTable[hashAddress] = [indexKey, value]
    }
}

// 데이터 조회 함수 (선형 탐색 방식)
func linearReadData(_ data: String) -> Any? {
    let indexKey = linearGetKey(data) // 데이터로부터 해시 키를 생성
    var hashAddress = linearHashFunction(indexKey) // 해시 주소 계산
    
    // 해당 주소가 비어 있지 않으면 탐색 시작
    if (linearHashTable[hashAddress] as? Int) != 0 {
        // 선형 탐색으로 데이터를 찾음
        for index in hashAddress..<linearHashTable.count {
            // 빈 슬롯을 만나면 탐색 중지
            if (linearHashTable[index] as? Int) == 0 {
                return nil
            }
            // 해당 키를 찾으면 값 리턴
            else if let currentValue = linearHashTable[index] as? [Any],
                    let currentKey = currentValue[0] as? Int,
                    currentKey == indexKey {
                return currentValue[1]
            }
        }
    }
    
    return nil // 데이터가 없으면 nil 반환
}

// 예시 사용
linearSaveData("apple", value: "사과")
linearSaveData("banana", value: "바나나")
print(linearReadData("apple") as Any) // 출력: Optional("사과")
print(linearReadData("banana") as Any) // 출력: Optional("바나나")
print(linearReadData("orange") as Any) // 출력: nil
