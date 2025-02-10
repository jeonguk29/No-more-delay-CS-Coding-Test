import UIKit

// -------------------------------------
// 📌 정렬 알고리즘 (Sorting Algorithms)
// -------------------------------------
// - 정렬(Sorting): 데이터를 특정한 순서대로 재배열하는 과정
// - Swift에서 다양한 정렬 알고리즘을 구현하며 학습 가능
// -------------------------------------

// 📌 정렬(Sorting)이란?
// - 주어진 데이터들을 정해진 순서대로 나열하는 것
// - 프로그램 작성 시 자주 사용되는 핵심 알고리즘 중 하나
// - 다양한 정렬 알고리즘을 학습하면 성능 차이를 이해하고 최적의 알고리즘을 선택할 수 있음

// -------------------------------------
// 📌 버블 정렬 (Bubble Sort)
// -------------------------------------
// - 옆에 있는 요소와 비교하여 더 작은 값을 앞으로 이동하는 방식
// - 시간 복잡도: O(n²) (최악), O(n) (최선: 이미 정렬된 경우)
// - 특징:
//   - 한 번 반복할 때마다 가장 큰 요소가 맨 뒤에 위치하게 됨
//   - 정렬이 완료되면 더 이상 비교가 필요 없으므로 조기 종료 가능
// -------------------------------------

// 📌 버블 정렬 동작 예시
// 예제 데이터: [1, 9, 3, 2]
// 1차 반복:
//   - (1,9) 비교 → 자리 바꿈 없음 → [1, 9, 3, 2]
//   - (9,3) 비교 → 자리 바꿈 → [1, 3, 9, 2]
//   - (9,2) 비교 → 자리 바꿈 → [1, 3, 2, 9] (가장 큰 값 9가 맨 뒤로 이동)
// 2차 반복:
//   - (1,3) 비교 → 자리 바꿈 없음 → [1, 3, 2, 9]
//   - (3,2) 비교 → 자리 바꿈 → [1, 2, 3, 9]
// 3차 반복:
//   - (1,2) 비교 → 자리 바꿈 없음 → 정렬 완료 ✅
// -------------------------------------

/// 📌 버블 정렬 구현 (Bubble Sort)
/// - 입력: 정렬되지 않은 정수 배열
/// - 출력: 오름차순으로 정렬된 배열
///
func bubbleSort(array: [Int]) -> [Int] {
    var arr = array
    var swapped: Bool  // 데이터 교환 여부를 확인하는 변수
    
    for i in 0..<arr.count - 1 {
        swapped = false
        for j in 0..<arr.count - i - 1 {
            if arr[j] > arr[j + 1] {
                arr.swapAt(j, j + 1)  // 인접한 요소를 비교 후 교환
                swapped = true
            }
        }
        if !swapped { break }  // 더 이상 교환이 없으면 조기 종료
    }
    return arr
}

// ✅ 테스트 실행
var testArray = bubbleSort(array: [1, 9, 3, 2])
print(testArray) // [1, 2, 3, 9]


// 삽입 정렬

// 📌 삽입 정렬 (Insertion Sort)
func insertionSort(array: [Int]) -> [Int] {
    var arr = array
    
    for index in 1..<arr.count {  // 0번째 요소는 이미 정렬된 상태이므로 1부터 시작
        for index2 in stride(from: index, through: 1, by: -1) {  // 역순으로 비교
            if arr[index2] < arr[index2 - 1] {  // 바로 앞의 값과 비교
                arr.swapAt(index2, index2 - 1)
            } else {
                break  // 현재 위치보다 작은 값이 나오면 정렬 완료
            }
        }
    }
    
    return arr
}

// ✅ 테스트 실행
var testArray2 = insertionSort(array: [9, 3, 2, 5])
print(testArray2)  // [2, 3, 5, 9]


// 선택 정렬

func selection_sort(array: [Int]) -> [Int] {
    var arr = array
    
    for stand in 0..<arr.count - 1 {
        var lowest = stand
        
        for index in stand + 1 ..< arr.count {
            if arr[lowest] > arr[index] {
                lowest = index // 가장 작은 값이 담기도록
            }
        }
        arr.swapAt(lowest, stand) // 한 사이클이 끝나면 기준점과 가장 작은 값을 체인지
    }
    
    return arr
}

var testArray3 = selection_sort(array: [9, 3, 2, 5])
print(testArray3)  // [2, 3, 5, 9]



// 재귀 용법
// 재귀 함수를 이용해서 1부터 n까지의 곱이 출력 되도록 만드시오

func multiple(num: Int) -> Int {
    if num <= 1 {
        return 1
    }
    else {
        return num * multiple(num: num - 1)
    }
}

var number = multiple(num: 5)
print(number)

func multipleArray(array: [Int]) -> Int {
    if array.count <= 1 {
        return array[0]
    }
    else {
        return array[0] * multipleArray(array: Array(array[1..<array.count]))
        // ArraySlice를 Array로 변환해줘야함
    }
}

let array = [2, 3, 4]
print(multipleArray(array: array))  // 결과: 24 (2 * 3 * 4)

/*
 회문(palindrome)은 순서를 거꾸로 읽어도 제대로 읽은 것과 같은 단어와 문장을 의미함
 회문을 판별할 수 있는 함수를 재귀함수를 활용해서 만들어봅니다.
 */

func palindrome(string: String) -> Bool {
    if string.count <= 1 {
        return true
    }
    
    let firstChar = string.first
    let lastChar = string.last
    
    if firstChar == lastChar {
        let start = string.index(after: string.startIndex)  // 두 번째 문자
        let end = string.index(before: string.endIndex)     // 마지막 이전 문자
        let substring = String(string[start..<end])         // 양 끝 제거 후 부분 문자열
        
        return palindrome(string: substring)
    } else {
        return false
    }
}

print(palindrome(string: "racecar"))  // true
print(palindrome(string: "apple"))    // false



// 경우의 수를 나눠 재귀 호출 하기
//1, 정수 n에 대해
//2. n이 홀수이면 3 X n + 1 을 하고,
//3. n이 짝수이면 n 을 2로 나눕니다.
//4. 이렇게 계속 진행해서 n 이 결국 1이 될 때까지 2와 3의 과정을 반복합니다.
func caseCalculation(n :Int) -> Int {
    print(n)
    
    if n  ==  1 {
        return 1
    }
    
    if n % 2 == 0 {
        var n = n / 2
        return caseCalculation(n: n)
    } else{
        var n = 3 * n + 1
        return caseCalculation(n: n)
    }
    
}
caseCalculation(n: 3)


func numberOfCases(number: Int) -> Int {
    if number == 1 {
        return 1
    } else if number == 2{
        return 2
    } else if number == 3{
        return 4
    } else {
        return numberOfCases(number: number - 1) + numberOfCases(number: number - 2) + numberOfCases(number: number - 3)
    }
}
numberOfCases(number: 5)

