
// 첫 번째 줄: N
let N = Int(readLine()!)!

// 두 번째 줄: N개의 정수 A[1], A[2], ..., A[N]
let A = Set(readLine()!.split(separator: " ").compactMap { Int($0) })

// 세 번째 줄: M
let M = Int(readLine()!)!

// 네 번째 줄: M개의 수
let B = readLine()!.split(separator: " ").compactMap { Int($0) }

// B가 A 집합에 존재하는지 여부를 출력 더 빨리 찾을수 있음 집합은 중복을 없애주기 때문에
for i in B {
    if A.contains(i) {
        print(1)
    } else {
        print(0)
    }
}

