import Foundation

// ✅ 특정 위치에 퀸을 놓을 수 있는지 확인하는 함수
func isAvailable(candidate: [Int], currentCol: Int) -> Bool {
    let currentRow = candidate.count  // 현재까지 배치된 행 수

    for queenRow in 0..<currentRow {
        // 같은 열에 퀸이 있는지 || 대각선에 퀸이 있는지 확인
        if candidate[queenRow] == currentCol || abs(candidate[queenRow] - currentCol) == currentRow - queenRow {
            return false
        }
    }
    return true
}

// ✅ 백트래킹을 수행하는 DFS 함수
func dfs(n: Int, currentRow: Int, currentCandidate: inout [Int], finalResult: inout [[Int]]) {
    // 모든 퀸을 배치한 경우 (종료 조건)
    if currentRow == n {
        finalResult.append(currentCandidate)
        return
    }
    
    // 가능한 모든 열을 탐색 (0 ~ N-1)
    for candidateCol in 0..<n {
        if isAvailable(candidate: currentCandidate, currentCol: candidateCol) {
            currentCandidate.append(candidateCol)  // 퀸 배치
            dfs(n: n, currentRow: currentRow + 1, currentCandidate: &currentCandidate, finalResult: &finalResult)  // 다음 행으로 이동
            currentCandidate.removeLast()  // 백트래킹 (이전 상태로 되돌리기)
        }
    }
}

// ✅ N-Queens 문제를 해결하는 함수
func solveNQueens(_ n: Int) -> [[Int]] {
    var finalResult: [[Int]] = []  // 결과를 저장할 배열
    var currentCandidate: [Int] = []  // 현재 배치된 퀸의 열 위치를 저장
    
    dfs(n: n, currentRow: 0, currentCandidate: &currentCandidate, finalResult: &finalResult)  // 백트래킹 시작
    return finalResult
}

// ✅ 테스트 실행
let solutions = solveNQueens(4)

// ✅ 결과 출력
print("🔹 N-Queens 문제 해결 결과:")
for solution in solutions {
    print(solution)
}
