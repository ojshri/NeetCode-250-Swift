import Foundation

//  MARK: 41. First Missing Positive
func firstMissingPositive(_ nums: [Int]) -> Int {
    let twiceNum = nums + nums
    
    var result = Int.max
    var hasOne = false
    
    for (i, v) in twiceNum.enumerated() {
        if !hasOne { hasOne = v == 1 }
        
        if v > 0 {
            result = result == v ? v + 1 : min(result, v + 1)
        }
    }
    
    return hasOne ? result : 1
}
//print(firstMissingPositive([1,2,0]))
//print(firstMissingPositive([3,4,-1,1]))
//print(firstMissingPositive([7,8,9,11,12]))


//  MARK: 69. Sqrt(x)
func mySqrt(_ x: Int) -> Int {
    if x == 0 { return 0 }
    if x == 1 { return 1 }
    
    var l = 1
    var r = x
    
    while l <= r {
        let m = l + (r - l) / 2
        let v = m * m
        
        if v == x {
            return m
        } else if v < x {
            l = m + 1
        } else {
            r = m - 1
        }
    }
    
    return r
}


//  MARK: 169. Majority Element
func majorityElement(_ nums: [Int]) -> Int {
    let countedSet =  NSCountedSet(array: nums)
    let threshold = nums.count / 2
    
    for element in countedSet {
        if countedSet.count(for: element) > threshold {
            return element as! Int
        }
    }
    
    return 0
}

//  print(majorityElement([2,2,1,1,1,2,2]))

//  MARK: 27. Remove Element
func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
    var k = 0
    
    for num in nums {
        if num != val {
            k += 1
            nums[k] = num
        }
    }
    return k
}

//  MARK: 14. Longest Common Prefix
class Solution {
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard !strs.isEmpty else { return "" }
        
        let arr = strs.map { Array($0) }
        guard let minLen = arr.min(by: { $0.count < $1.count })?.count else { return "" }
        
        var res = ""
        
        for i in 0..<minLen {
            let char = arr[0][i]
            
            for str in arr {
                if str[i] != char {
                    return res
                }
            }
            res += String(char)
        }
        return res
    }
}

//  MARK: 128. Longest Consecutive Sequence
func longestConsecutiveSort(_ nums: [Int]) -> Int {
    guard !nums.isEmpty else { return 0 }
    var dict = [Int: Int]()
    
    for i in nums.sorted() {
        if dict.keys.contains(i - 1) {
            dict[i] = (dict[i - 1] ?? 0) + 1
        } else {
            dict[i] = 1
        }
    }
    
    return dict.values.max() ?? 1
}

func longestConsecutive(_ nums: [Int]) -> Int {
    let numSet = Set(nums) // Convert the array to a set for O(1) lookups
    var longest = 0 // Variable to store the length of the longest sequence
    
    for num in numSet {
        // Check if the current number is the start of a sequence
        if !numSet.contains(num - 1) {
            var length = 1 // Initialize the length of the current sequence
            // Increment the length while the next number in the sequence exists
            while numSet.contains(num + length) {
                length += 1
            }
            // Update the longest sequence length
            longest = max(longest, length)
        }
    }
    
    return longest
}

//  print(longestConsecutive([100,4,200,1,3,2]))
//  print(longestConsecutive([0,3,7,2,5,8,4,6,0,1]))
//  print(longestConsecutive([1,0,1,2]))

//  36. Valid Sudoku
func isValidSudoku(_ board: [[Character]]) -> Bool {
    
    // Initialize arrays of sets for rows and columns
    var rows = [Set<Character>](repeating: Set(), count: 9)
    var columns = [Set<Character>](repeating: Set(), count: 9)
    var subgrids = [String: Set<Character>]()
    
    for r in 0..<9 {
        for c in 0..<9 {
            let char = board[r][c]
            
            // Skip empty cells
            if char == "." {
                continue
            }
            
            // Check if the number is already in the current row
            if rows[r].contains(char) {
                return false
            }
            rows[r].insert(char)
            
            // Check if the number is already in the current column
            if columns[c].contains(char) {
                return false
            }
            columns[c].insert(char)
            
            // Check if the number is already in the current 3x3 subgrid
            let subgridKey = "\(r / 3),\(c / 3)"
            if subgrids[subgridKey]?.contains(char) == true {
                return false
            }
            subgrids[subgridKey, default: Set()].insert(char)
        }
    }
    
    return true
}

let board: [[Character]] = [
    ["5","3",".",".","7",".",".",".","."],
    ["6",".",".","1","9","5",".",".","."],
    [".","9","8",".",".",".",".","6","."],
    ["8",".",".",".","6",".",".",".","3"],
    ["4",".",".","8",".","3",".",".","1"],
    ["7",".",".",".","2",".",".",".","6"],
    [".","6",".",".",".",".","2","8","."],
    [".",".",".","4","1","9",".",".","5"],
    [".",".",".",".","8",".",".","7","9"]
]

//  print(isValidSudoku(board)) // Output: true

//  238. Product of Array Except Self
// n2 and failed with Zeros are introduced
//func productExceptSelf(_ nums: [Int]) -> [Int] {
//    guard nums.count > 0 else { return [] }
//    let product = nums.filter{ $0 != 0 }.reduce(1, *)
//    return nums.map { product / $0 }
//}

func productExceptSelf(_ nums: [Int]) -> [Int] {
    let n = nums.count
    var res = [Int](repeating: 1, count: n)
    
    // Calculate prefix products
    var prefix = 1
    for i in 0..<n {
        res[i] = prefix
        prefix *= nums[i]
    }
    
    // Calculate postfix products and combine with prefix
    var postfix = 1
    for i in stride(from: n - 1, through: 0, by: -1) {
        res[i] *= postfix
        postfix *= nums[i]
    }
    
    return res
}

//  print(productExceptSelf([1, 2, 3, 4])) // Output: [24, 12, 8, 6]
//  print(productExceptSelf([-1, 1, 0, -3, 3])) // Output: [0, 0, 9, 0, 0]

//  659. Encode and Decode Strings
//  https://www.lintcode.com/problem/659/
//  Design an algorithm to encode a list of strings to a single string. The encoded string is then decoded back to the original list of strings.

func encode(_ strs: [String]) -> String {
    var result = ""
    for s in strs {
        result.append("\(s.count)" + "#" + s)
    }
    return result
}

func decode(_ s: String) -> [String] {
    if s.isEmpty {
        return []
    }
    
    var result = [String]()
    var i = s.startIndex
    
    while i < s.endIndex {
        // Find the position of the '#' delimiter
        let delimiterIndex = s[i...].firstIndex(of: "#")!
        
        // Extract the length of the string
        let lengthString = String(s[i..<delimiterIndex])
        guard let length = Int(lengthString) else {
            return []
        }
        
        // Move the index to the character after the '#'
        i = s.index(delimiterIndex, offsetBy: 1)
        
        // Extract the string of the given length
        let endIndex = s.index(i, offsetBy: length)
        let str = String(s[i..<endIndex])
        result.append(str)
        
        // Move the index to the end of the current string
        i = endIndex
    }
    
    return result
}
//  print(encode(["neet","code","love","you"])) // Output: "4#neet4#code4#love3#you"
//  print(decode("4#neet4#code4#love3#you"))    // Output: ["neet", "code", "love", "you"]


//  347. Top K Frequent Elements
//  Given an integer array nums and an integer k, return the k most frequent elements. You may return the answer in any order.
//  Input: nums = [1,1,1,2,2,3], k = 2
//  Output: [1,2]

func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    // Create a dictionary to store the frequency of each number
    var dict = [Int: Int]()
    
    // Count the frequency of each number in the input array
    for i in nums {
        // Use the default value of 0 if the key (number) doesn't exist
        dict[i, default: 0] += 1
    }
    
    // Sort the dictionary by frequency in descending order and take the first k elements
    let sortedDict = dict.sorted { $0.value > $1.value }.prefix(k)
    
    // Extract the keys (numbers) from the top k frequent elements and return as an array
    return sortedDict.map { $0.key }
}
//  print(topKFrequent([1,1,1,2,2,3], 2))


//  49. Group Anagrams
//  Given an array of strings strs, group the anagrams together. You can return the answer in any order.

func groupAnagrams(_ strs: [String]) -> [[String]] {
    var dict = [Int: [String]]()
    
    let aAsciiValue = Int(Character("a").asciiValue!)
    
    for str in strs {
        var sum = 0
        for char in str {
            sum += asciiDiff(char: char)
        }
        
        //        if dict[sum] != nil {
        //            dict[sum]?.append(str)
        //        } else {
        //            dict[sum] = [str]
        //        }
        
        dict[sum, default: []].append(str)
    }
    
    func asciiDiff(char: Character) -> Int {
        return Int(Character(extendedGraphemeClusterLiteral: char).asciiValue!) - aAsciiValue
    }
    
    return Array(dict.values)
}

func groupAnagramsOptimized(_ strs: [String]) -> [[String]] {
    var dict = [String: [String]]()
    
    // Iterate through each string in the input array
    for str in strs {
        // Sort the string to use as a key
        let sortedStr = String(str.sorted())
        
        // Add the original string to the correct group
        dict[sortedStr, default: []].append(str)
    }
    
    // Collect all groups from the dictionary
    return Array(dict.values)
}

//  print(groupAnagrams(["eat","tea","tan","ate","nat","bat"]))

//  1. Two Sum
//  Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
//  You may assume that each input would have exactly one solution, and you may not use the same element twice.
//  You can return the answer in any order.

func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var numDict = [Int: Int]()  // Dictionary to store numbers and their indices
    
    for (index, num) in nums.enumerated() {
        let complement = target - num
        
        if let complementIndex = numDict[complement] {
            return [index, complementIndex]
        } else {
            numDict[num] = index
        }
    }
    return [0, 0]
}

func twoSumBrute(_ nums: [Int], _ target: Int) -> [Int] {
    
    for i in 0..<nums.count-1 {
        for j in i+1..<nums.count {
            if nums[i] + nums[j] == target {
                return [i,j]
            }
        }
    }
    
    return [0, 0]
}

//  print(twoSum([3,2,4], 6))

//  242. Valid Anagram
//  Given two strings s and t, return true if t is an anagram of s, and false otherwise.

func isAnagram(_ s: String, _ t: String) -> Bool {
    // If the lengths are not equal, the strings cannot be anagrams
    guard s.count == t.count else { return false }
    
    // Create an array to store character counts for both strings
    var charCount = [Int](repeating: 0, count: 26)
    
    // 'a' has a unicode value of 97, so subtract 97 to map to 0-25 for 'a' to 'z'
    let aAsciiValue = Int(Character("a").asciiValue!)
    
    // Iterate over both strings simultaneously and update the character counts
    for (charS, charT) in zip(s, t) {
        charCount[Int(charS.asciiValue!) - aAsciiValue] += 1
        charCount[Int(charT.asciiValue!) - aAsciiValue] -= 1
    }
    
    // If all counts are zero, the strings are anagrams
    return charCount.allSatisfy { $0 == 0 }
}

func isAnagramBrute(_ s: String, _ t: String) -> Bool {
    
    // Compare if the strings are of equal length
    guard s.count == t.count else { return false }
    
    // Sort the strings and check if they are identical
    guard s.sorted() == t.sorted() else { return false }
    
    // If both the above conditions are true, the string are anagram
    return true
}

//  print(isAnagram("anagram", "nagaram"))


//  217. Contains Duplicate
//  Given an integer array nums, return true if any value appears at least twice in the array, and return false if every element is distinct.
func containsDuplicate(_ nums: [Int]) -> Bool {
    let set = Set(nums)
    return set.count != nums.count
}
//  print(containsDuplicate([1,2,3,4,5,6,7,8,9,10]))

func containsDuplicateBrute(_ nums: [Int]) -> Bool {
    
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            if nums[i] == nums[j] {
                return true
            }
        }
    }
    
    return false
}
//  print(containsDuplicateBrute([1,2,3,4,5,6,7,8,9,1]))


//  3487. Maximum Unique Subarray Sum After Deletion
func maxSum(_ nums: [Int]) -> Int {
    
    if nums.count == 1 {
        return nums[0]
    }
    
    if let max = nums.max(), max < 0 {
        return max
    }
    
    let set = Set(nums).filter { $0 > 0 }
    return set.reduce(0, +)
}

//print(maxSum([1,2,3,4,5]))
//print(maxSum([1,1,0,1,1]))
//print(maxSum([1,2,-1,-2,1,0,-1]))
//print(maxSum([-10, 20]))
//print(maxSum([-10]))
//print(maxSum([]))
