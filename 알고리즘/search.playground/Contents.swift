import UIKit

//MARK: 순차탐색 - Sequential search
/*
 * 탐색은 여러 데이터 중에서 원하는 데이터를 찾아내는 것을 의미 (순차탐색(가장 쉬운 방법), 해쉬, 트리, 이진탐색 총 4가지)
 * 데이터가 담겨있는 리스트를 앞에서부터 하나씩 비교해서 원하는 데이터를 찾는 방법
 */

import Foundation

// ✅ 무작위 정수 저장할 배열 초기화
var randDataList = [Int]()

// ✅ 1부터 100 사이의 무작위 정수 10개 생성
for _ in 0..<10 {
    let randomNumber = Int.random(in: 1...100)
    randDataList.append(randomNumber)
}

// ✅ 결과 출력
print(randDataList)


func sequencial(data_list: [Int], search_data : Int) -> Int {
    for index in 0..<data_list.count {
        if data_list[index] == search_data {
            return data_list[index]
        }
    }
    return -1
}

print(sequencial(data_list: [10,20,30,40,50], search_data: 10))


// MARK: 이진 탐색 (Binary Search) 이란?
// 탐색할 자료를 둘로 나누어 해당 데이터가 있을만한 곳을 탐색하는 방법

/*
 ### 3. 어떻게 코드로 만들까?
 * 이진 탐색은 데이터가 정렬되있는 상태에서 진행
 * 데이터가 [2, 3, 8, 12, 20] 일 때,
 - binary_search(data_list, find_data) 함수를 만들고
 - find_data는 찾는 숫자
 - data_list는 데이터 리스트
 - data_list의 중간값을 find_data와 비교해서
 - find_data < data_list의 중간값 이라면
 - 맨 앞부터 data_list의 중간까지 에서 다시 find_data 찾기
 - data_list의 중간값 < find_data 이라면
 - data_list의 중간부터 맨 끝까지에서 다시 find_data 찾기
 - 그렇지 않다면, data_list의 중간값은 find_data 인 경우로, return data_list 중간위치
 */
func binary_search(data_list: [Int], search_data: Int) -> Bool {
    print(data_list)
    
    if data_list.isEmpty {
        return false
    }
    
    if data_list.count == 1 {
        return data_list[0] == search_data // true 반환
    }
    
    let medium = Int(data_list.count / 2)
    
    if data_list[medium] == search_data {
        return true
    } else if search_data > data_list[medium] {
        return binary_search(data_list: Array(data_list[medium + 1..<data_list.count]), search_data: search_data)
    } else {
        return binary_search(data_list: Array(data_list[0..<medium]), search_data: search_data)
    }
}

// ✅ 테스트
print(binary_search(data_list: [10, 20, 30, 33, 35, 36, 37, 38, 39, 40], search_data: 39))  // ✅ true
print(binary_search(data_list: [10, 20, 30, 33, 35, 36, 37, 38, 39, 40], search_data: 50))  // ✅ false

// 문제 풀기
// 탐색 문제는 시간 제한이 있음
// https://www.acmicpc.net/problem/1920

var N_list = [4, 1, 5, 2, 3]
var M_list = [1, 3, 7, 9, 5]

for item in M_list {
    if N_list.contains(item) {
        print(1)
    } else {
        print(0)
    }
}

// 개선 코드 이진 탐샘

N_list.sort()

@MainActor
func binary_search_1920(value: Int, start: Int, end: Int) -> Bool {
    //print(value, start, end)
    
    if start > end {
        return false
    }
    
    var medium = (start + end) / 2
    
    if value < N_list[medium] {
        return binary_search_1920(value: value, start: start, end: medium - 1)
    } else if value > N_list[medium]{
        return binary_search_1920(value: value, start: medium + 1, end: end)
    } else {
        return true // 찾는 값이 중간이다
    }
}

for item in M_list {
    if binary_search_1920(value: item, start: 0, end: N_list.count - 1) {
        print(1)
    } else {
        print(0)
    }
}

