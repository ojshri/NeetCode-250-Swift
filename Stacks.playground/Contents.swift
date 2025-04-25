//  682. Baseball Game
class Solution {
    func calPoints(_ operations: [String]) -> Int {
        var scores = [Int]()
        
        for op in operations {
            if op == "D" {
                if let last = scores.last {
                    scores.append(last * 2)
                }
            } else if op == "C" {
                scores.removeLast()
            } else if op == "+" {
                if scores.count >= 2 {
                    scores.append(scores[scores.count - 1] + scores[scores.count - 2])
                }
            } else if let score = Int(op) {
                scores.append(score)
            }
        }
        
        return scores.reduce(0, +)
    }
}

//  853. Car Fleet
//  Input: target = 12, position = [10,8,0,5,3], speed = [2,4,1,1,3]

func carFleet(_ target: Int, _ position: [Int], _ speed: [Int]) -> Int {
    var pair = zip(position, speed).map { ($0, $1) }
    pair.sort { $0.0 > $1.0 } // Sort in descending order by position

    var stack = [Double]()

    for (p, s) in pair {
        stack.append(Double(target - p) / Double(s))
        if stack.count > 1, stack.last! <= stack[stack.count - 2] {
            stack.removeLast()
        }
    }

    return stack.count
}


//  739. Daily Temperatures
func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
    var result = Array(repeating: 0, count: temperatures.count)
    var stack = [(Int, Int)]()
    
    for (i,t) in temperatures.enumerated() {
        while !stack.isEmpty, t > stack.last!.0 {
            let (temp, index) = stack.removeLast()
            result[index] = i - index
        }
        stack.append((t, i))
    }
    
    return result
}



//  150. Evaluate Reverse Polish Notation
func evalRPN(_ tokens: [String]) -> Int {
    var stack: [Int] = []  // Stack to hold numbers
    
    for token in tokens {
        // Check if token is an operator
        if token == "+" || token == "-" || token == "*" || token == "/" {
            // Pop the last two numbers from stack
            let b = stack.removeLast()  // Second operand
            let a = stack.removeLast()  // First operand
            
            // Perform the operation and push result back to stack
            switch token {
            case "+":
                stack.append(a + b)
            case "-":
                stack.append(a - b)
            case "*":
                stack.append(a * b)
            case "/":
                // Handle division (Swift Int division rounds towards zero)
                stack.append(a / b)
            default:
                break  // Shouldn't happen with valid input
            }
        } else {
            // If token is a number, convert to Int and push to stack
            if let num = Int(token) {
                stack.append(num)
            }
        }
    }
    
    // Final result will be the only number left in stack
    return stack.last ?? 0
}

//  evalRPN(["10","6","9","3","+","-11","*","/","*","17","+","5","+"])

//  155. Min Stack
class MinStack {
    
    private var stack: [Int]
    private var minStack: [Int]
    
    init() {
        stack = [Int]()
        minStack = [Int]()
    }
    
    func push(_ val: Int) {
        stack.append(val)
        
        // If minStack is empty or new value is less than or equal to current min,
        // add it to minStack
        if minStack.isEmpty || minStack.last! >= val {
            minStack.append(val)
        } else {
            minStack.append(minStack.last!)
        }
    }
    
    func pop() {
        if !stack.isEmpty {
            stack.removeLast()
            minStack.removeLast()
        }
    }
    
    func top() -> Int {
        stack.last ?? 0
    }
    
    func getMin() -> Int {
        minStack.last ?? 0
    }
}

//  20. Valid Parentheses
func isValid(_ s: String) -> Bool {
    var stack = [Character]()
    let bracketsMapping: [Character: Character] = [")": "(", "}": "{", "]": "["]
    
    for character in s {
        if bracketsMapping.values.contains(character) {
            stack.append(character)
        } else if let matchingOpening = bracketsMapping[character] {
            if stack.isEmpty || stack.last != matchingOpening {
                return false
            }
            stack.removeLast()
        } else {
            return false // For invalid characters
        }
    }
    
    return stack.isEmpty
}

func isValidOptimized(_ s: String) -> Bool {
    var stack = [Character]()
    let brackets: [Character: Character] = [")": "(", "}": "{", "]": "["]
    
    for char in s {
        switch char {
        case "(", "{", "[":
            stack.append(char)
        case ")", "}", "]":
            if stack.isEmpty || stack.removeLast() != brackets[char] {
                return false
            }
        default:
            return false
        }
    }
    
    return stack.isEmpty
}
