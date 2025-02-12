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


