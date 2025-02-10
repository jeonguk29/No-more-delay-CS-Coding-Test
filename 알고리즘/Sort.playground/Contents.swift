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


// 동적 계획법

func fibo (num: Int) -> Int {
    if num <= 1 {
        return num
    }
    else {
        return fibo(num: num - 1) + fibo(num: num - 2)
    }
}

fibo(num: 4)

func fibo_dp (num: Int) -> Int {
    // Swift에서 동적 프로그래밍(DP) 배열을 초기화할 때 자주 사용되는 문법
    var dp: [Int] = Array(repeating: 0, count: num + 1)
    
    dp[0] = 0
    dp[1] = 1
    
    for i in 2...num {
        dp[i] = dp[i - 1] + dp[i - 2]
    }
    
    return dp[num]
}

fibo_dp(num: 10)

/*
 Array(repeating: 0, count: num + 1)의 의미
 repeating: 0 → 배열의 모든 요소를 0으로 초기화합니다.
 count: num + 1 → 배열의 크기를 num + 1로 지정합니다.
 +1을 하는 이유는 보통 인덱스 0부터 num까지 포함하기 위함
 */

/*
 
 풀이 전략
 - 점화식을 찾아보세요
 - 점화식이란, 이웃하는 두개의 항 사이에 성립하는 관계를 나타낸 관계식을 의미함
 - 예: dp[n] = dp[n-1] + dp[n-2]
 
 코드 작성 패턴
 1. 빈리스트 만들기 (입력값에 따른)
 2. 초기값을 설정 (1이면 1 등등)
 3. 점화식 기반으로 계산값 적용하기
 4. 특정 입력값에 따른 계산 값을 리스트에서 추출하기
 
 */

// https://www.acmicpc.net/problem/11726

func fibo_dp_11726(num: Int) {
    // ✅ 입력값 검증: 1 이상 1000 이하인지 확인
    guard num >= 1 && num <= 1000 else {
        print("❌ Error: num은 1 이상 1000 이하의 값이어야 합니다.")
        return
    }
    
    var dp: [Int] = Array(repeating: 0, count: 1001)
    dp[1] = 1
    dp[2] = 2
    
    for i in 3...1000 {
        dp[i] = (dp[i - 1] + dp[i - 2]) % 10007  // ✅ 나머지 연산을 여기에 적용 (오버플로 방지)
    }
    
    print(dp[num])  // ✅ 나머지 연산을 반복문 안에서 이미 처리했으므로 생략 가능
}

fibo_dp_11726(num: 9)     // ✅ 정상 출력: 55
//fibo_dp_11726(num: 1001)  // ❌ 오류 메시지 출력

// 동적 계획 코딩테스트에서 자주나오는 빈출 유형임

// https://www.acmicpc.net/problem/9461

func fibo_dp_9461(num: Int) {
    // ✅ 입력값 검증: 1 이상 100 이하인지 확인
    guard num >= 1 && num <= 100 else {
        print("❌ Error: num은 1 이상 100 이하의 값이어야 합니다.")
        return
    }
    
    var dp: [Int] = Array(repeating: 0, count: 101)
    dp[1] = 1
    dp[2] = 1
    dp[3] = 1
    
    for i in 0...97 {
        dp[i + 3] = (dp[i] + dp[i + 1])
    }
    
    print(dp[num])
}

fibo_dp_9461(num: 12)


//MARK: 퀵정렬

func quicksort(array : [Int]) -> [Int] {
    if array.count <= 1 {
        return array
    }
    var leftArray = [Int]()
    var rightArray = [Int]()
    var pivot = array[0]
    
    for index in 1..<array.count {
        if array[index] <= pivot {
            leftArray.append(array[index])
        }else {
            rightArray.append(array[index])
        }
    }
    
    return quicksort(array: leftArray) + [pivot] + quicksort(array: rightArray)
}

print(quicksort(array: [2, 5, 1, 1, 3, 4]))

//MARK: 병합 정렬
func mergeSplit(array : [Int]) -> [Int] {
    if array.count <= 1 {
        return array
    }
    
    var medium = Int(array.count / 2)
    var leftArray = mergeSplit(array: Array(array[0..<medium]))
    var rightArray = mergeSplit(array: Array(array[medium..<array.count]))
    
    return merge(left: leftArray, right: rightArray)
}

func merge(left : [Int], right : [Int]) -> [Int] {
    
    var merged = [Int]()
    var leftIndex = 0
    var rightIndex = 0
    
    // case1 - left/right 둘다 있을때
    while left.count > leftIndex && right.count > rightIndex {
        if left[leftIndex] > right[rightIndex]{
            merged.append(right[rightIndex])
            rightIndex += 1
        }else {
            merged.append(left[leftIndex])
            leftIndex += 1
        }
    }
    
    // case2 - left 데이터가 남아 있을때
    while left.count > leftIndex {
        merged.append(left[leftIndex])
        leftIndex += 1
    }
    
    // case2 - right 데이터가 남아 있을때
    while right.count > rightIndex {
        merged.append(right[rightIndex])
        rightIndex += 1
    }
    
    return merged
}

print(mergeSplit(array: [20, 30, 10, 50, 40, 70, 60, 80, 90, 100]))
