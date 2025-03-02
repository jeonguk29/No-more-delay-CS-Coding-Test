/*
 우리가 특정 Key - Value를 저장한다고 하면
 해당 Key를 해시함수를 통해 해시를 하고,
 결과 값인 해시 주소 값에 해당하는 해시 테이블 슬롯에 Value를 저장하는 것임!
 
 해시 함수는 보통 뭐 SHA256, SHA-1 같은 안전한 알고리즘을 사용
 어떤 데이터도 유일한 고정된 크기의 고정값을 리턴해줘야함 해쉬 함수는
 
 장점
 데이터 저장/읽기 속도가 빠르다. (검색 속도가 빠르다.)
 해쉬는 키에 대한 데이터가 있는지(중복) 확인이 쉬움 (배열 다 찾아야 하지만 해쉬는 해쉬 주소에 해당하는 슬럿에 값 있으면 끝임)
 단점
 일반적으로 저장공간이 좀더 많이 필요하다. (충돌을 방지하는 효과도 있음)
 여러 키에 해당하는 주소가 동일할 경우 충돌을 해결하기 위한 별도 자료구조가 필요함
 주요 용도
 검색이 많이 필요한 경우
 저장, 삭제, 읽기가 빈번한 경우
 캐쉬 구현시 (중복 확인이 쉽기 때문) ex 웹브라우저 이미지 등
 
 */

// 해시 테이블의 크기를 8로 설정
var hashTable = Array(repeating: "", count: 8)

// 해시 함수: 키 값을 8로 나누어 해시 주소를 생성
func hashFunction(_ key: Int) -> Int {
    return key % 8
}

// 키를 생성하는 함수: 문자에서 ASCII 값 추출
func getKey(from data: String) -> Int {
    return Int(data.first?.asciiValue ?? 0)
}

// 데이터를 저장하는 함수
func saveData(data: String, value: String) {
    let key = getKey(from: data)
    let hashAddress = hashFunction(key)
    hashTable[hashAddress] = value
}

// 데이터를 조회하는 함수
func readData(data: String) -> String? {
    let key = getKey(from: data)
    let hashAddress = hashFunction(key)
    return hashTable[hashAddress]
}

// 예시 데이터 저장
saveData(data: "Dave", value: "0102030200")
saveData(data: "Andy", value: "01033232200")

// 데이터 조회
if let result = readData(data: "Dave") {
    print("Dave의 전화번호: \(result)")  // 출력: Dave의 전화번호: 0102030200
} else {
    print("Dave의 데이터가 없습니다.")
}

if let result = readData(data: "Andy") {
    print("Andy의 전화번호: \(result)")  // 출력: Andy의 전화번호: 01033232200
} else {
    print("Andy의 데이터가 없습니다.")
}


/*
 충돌(Collision) 해결 알고리즘 (좋은 해쉬 함수 사용하기)
 해쉬 테이블의 가장 큰 문제는 충돌(Collision)의 경우입니다. 이 문제를 충돌(Collision) 또는 해쉬 충돌(Hash Collision)이라고 부릅니다.
 
 Chaining 기법
 개방 해슁 또는 Open Hashing 기법 중 하나: 해쉬 테이블 저장공간 외의 공간을 활용하는 기법
 충돌이 일어나면, 링크드 리스트라는 자료 구조를 사용해서, 링크드 리스트로 데이터를 추가로 뒤에 연결시켜서 저장하는 기법
 
 Linear Probing 기법
 폐쇄 해슁 또는 Close Hashing 기법 중 하나: 해쉬 테이블 저장공간 안에서 충돌 문제를 해결하는 기법
 충돌이 일어나면, 해당 hash address의 다음 address부터 맨 처음 나오는 빈공간에 저장하는 기법
 저장공간 활용도를 높이기 위한 기법
 */
