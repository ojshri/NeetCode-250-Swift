// 42. Trapping Rain Water
func trap(_ height: [Int]) -> Int {
    var result = 0
    
    
    return result
}

//  11. Container With Most Water
func maxArea(_ height: [Int]) -> Int {
    
    var result = 0
    var l = 0
    var r = height.count - 1
    
    while l < r {
        let area = min(height[l], height[r]) * (r - l)
        result = max(area, result)
        
        // move the pointer to the lower side & move any if equal
        if height[l] <= height[r] {
            l += 1
        } else {
            r -= 1
        }
    }
    
    return result
}

//  print(maxArea([1,8,6,2,5,4,8,3,7]))

// 15. 3Sum
func threeSum(_ nums: [Int]) -> [[Int]] {
    var result = [[Int]]()
    let sortedNums = nums.sorted()
    
    for (i, a) in sortedNums.enumerated() {
        if a > 0 { break }
        
        if i > 0, a == sortedNums[i-1] {
            continue
        }
        
        var l = i + 1
        var r = sortedNums.count - 1
        
        while l < r {
            let threeSum = a + sortedNums[l] + sortedNums[r]
            
            if threeSum < 0 {
                l += 1
            } else if threeSum > 0 {
                r -= 1
            } else {
                result.append([a, sortedNums[l], sortedNums[r]])
                
                l += 1
                r -= 1
                
                while sortedNums[l] == sortedNums[l - 1], l < r {
                    l += 1
                }
            }
        }
    }
    
    return result
}

//  print(threeSum([-1,0,1,2,-1,-4]))

//  167. Two Sum II - Input Array Is Sorted
func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
    var l = 0
    var r = numbers.count - 1
    
    while l < r {
        let curSum = numbers[l] + numbers[r]
        
        if curSum > target {
            r -= 1
        } else if curSum < target {
            l += 1
        } else {
            return [l + 1, r + 1]
        }
    }
    return []
}

// Using Hash
func twoSumHash(_ numbers: [Int], _ target: Int) -> [Int] {
    
    var dict = [Int: Int]()
    
    for (i,n) in numbers.enumerated() {
        let diff = target - n
        if let diffIndex = dict[diff] {
            return [diffIndex, i+1]
        } else {
            dict[n] = i+1
        }
    }
    return []
}

//  print(twoSum([2,7,11,15], 9))
//  print(twoSum([2,3,4], 6))
//  print(twoSum([-1,0], -1))

//  125. Valid Palindrome
func isPalindrome(_ s: String) -> Bool {
    if s.count < 2 { return true }
    
    // Convert the string to lowercase and filter out non-alphanumeric characters
    let filteredStr = s.lowercased().filter { $0.isNumber || $0.isLetter }
    
    // Convert the filtered string to an array for O(1) access
    let chars = Array(filteredStr)
    
    var l = 0
    var r = chars.count - 1
    
    // Check for palindrome
    while l < r {
        if chars[l] != chars[r] {
            return false
        }
        l += 1
        r -= 1
    }
    return true
}

//  print(isPalindrome("A man, a plan, a canal: Panama"))
//  print(isPalindrome("race a car"))
