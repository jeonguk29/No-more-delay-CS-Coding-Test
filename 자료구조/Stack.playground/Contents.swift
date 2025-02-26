
import Foundation

struct Stack<T> {
    private var stack: [T] = []
    
    public var count: Int {
        return stack.count
    }
    
    public var isEmpty: Bool {
        return stack.isEmpty
    }
    
    public mutating func push(_ element: T) {
        stack.append(element)
    }
    
    public mutating func pop() -> T? {
        return isEmpty ? nil : stack.popLast()
    }
}

var myStack = Stack<Int>()
myStack.push(10)
myStack.pop()

/*
 popLast란 함수 자체를
 Swift 배열에서 지원해주고 있음
 그말이 뭐냐면

 걍 배열을 Stack처럼 쓰라.....!!!!!!
 이름도 pop으로 해서 지원하지 않느냐!!!!!!!1

 따라서, Swift에서 굳이 Stack을 만들어 사용하지 않아도,
 배열 append, popLast 만으로도 충분히 배열을 Stack처럼 사용 가능하다 :)
 */
