import Foundation

func solution(_ A:[Int], _ B:[Int]) -> Int {
    let sortedA = A.sorted()
    let sortedB = B.sorted(by: >)
    
    return zip(sortedA, sortedB).map(*).reduce(0, +)
}
