import Foundation

func solution(_ n:Int) -> Int
{
    var nConvertBin = String(n, radix: 2)
    var nextNumber = n
    var answer = 0
    while true {
        // 이진수 문자열에서 '1'의 개수를 셈
        var oneCount = nConvertBin.filter { $0 == "1" }.count
        nextNumber += 1
        var nextNumberConvertBin = String(nextNumber, radix: 2)
        var nextNumberBinOneCount = nextNumberConvertBin.filter { $0 == "1" }.count
        if oneCount == nextNumberBinOneCount {
            break
        }
    }
    
    answer = nextNumber
    return answer
}