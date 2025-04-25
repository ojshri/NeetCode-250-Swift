/// Backtracking is nothing but DFS.

// 22. Generate Parentheses
class Solution {
    func generateParenthesis(_ n: Int) -> [String] {
        var stack = [Character]()
        var res = [String]()
        
        func backtrack(_ open: Int, _ closed: Int) {
            // Meet the condition
            if open == n, closed == n   {
                res.append(String(stack))
                return
            }
            
            // Left tracking
            if open < n {
                stack.append("(")
                backtrack(open + 1, closed)
                stack.removeLast()
            }
            
            // Right tracking
            if closed < open {
                stack.append(")")
                backtrack(open, closed + 1)
                stack.removeLast()
            }
        }
        
        backtrack(0, 0)
        return res
    }
}

//  78. Subsets
func subsets(_ nums: [Int]) -> [[Int]] {
    
    var result = [[Int]]()
    var subset = [Int] ()
    
    func backtrack(_ index: Int) {
        
        // It will return the result in individual level
        if index == nums.count {
            return result.append(subset)
        }
        
        // Append to the subset
        subset.append(nums[index])
        backtrack(index + 1)
        
        // Remove the last and backtrack again
        subset.removeLast()
        backtrack(index + 1)
        
    }
    
    backtrack(0)
    return result
}
