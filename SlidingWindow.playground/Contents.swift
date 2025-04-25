// 76. Minimum Window Substring
func minWindow(_ s: String, _ t: String) -> String {
    // Edge case: if s is shorter than t, no solution
    guard s.count >= t.count else { return "" }
    
    let sChars = Array(s)
    let tChars = Array(t)
    
    // Frequency map for t
    var tFreq = [Character: Int]()
    for char in tChars {
        tFreq[char, default: 0] += 1
    }
    
    // Frequency map for current window
    var windowFreq = [Character: Int]()
    
    // Two pointers and variables to track minimum window
    var start = 0
    var minLen = Int.max
    var minStart = 0
    var required = tFreq.count  // Unique chars in t to match
    var formed = 0             // Chars with sufficient frequency
    
    // Slide the window
    for end in 0..<sChars.count {
        // Add character to window
        let currChar = sChars[end]
        windowFreq[currChar, default: 0] += 1
        
        // Check if this char helps form the window
        if let tCount = tFreq[currChar], windowFreq[currChar] == tCount {
            formed += 1
        }
        
        // Shrink window while valid
        while formed == required && start <= end {
            let windowSize = end - start + 1
            if windowSize < minLen {
                minLen = windowSize
                minStart = start
            }
            
            // Remove char from start
            let startChar = sChars[start]
            windowFreq[startChar]! -= 1
            if let tCount = tFreq[startChar], windowFreq[startChar]! < tCount {
                formed -= 1
            }
            start += 1
        }
    }
    
    // Return minimum window or empty string if none found
    return minLen == Int.max ? "" : String(sChars[minStart..<minStart + minLen])
}

//  print(minWindow("ADOBECODEBANC", "ABC"))

//  567. Permutation in String
func checkInclusion(_ s1: String, _ s2: String) -> Bool {
    
    let char1 = Array(s1)
    let char2 = Array(s2)
    
    var char1Dict = [Character: Int]()  // smaller one
    var char2Dict = [Character: Int]()  // the bigger one
    
    //  Create the map of the searchable string
    for char in char1 {
        char1Dict[char, default: 0] += 1
    }
    
    //  Traverse to the first window
    for i in 0..<char1.count {
        char2Dict[char2[i], default: 0] += 1
    }
    
    //  Return if the two are equal in value
    if char1Dict == char2Dict {
        return true
    }
    
    //  Traverse window thru rest of the string
    for end in char1.count..<char2.count {
        
        // update the window by increasing the count of value
        char2Dict[char2[end], default: 0] += 1
        
        // Drop the first item from the array to slide window
        let oldChar = char2[end - char1.count]
        char2Dict[oldChar]! -= 1
        
        if char2Dict[oldChar] == 0 {
            char2Dict[oldChar] = nil  // Zero ho gaya toh remove
        }
        
        //  filer all the non-zero values in the char2Dict
        if char1Dict == char2Dict {
            return true
        }
    }
    return false
}

//  print(checkInclusion("ab", "eidbaooo"))
//  print(checkInclusion("ab", "eidboaoo"))
//  print(checkInclusion("hello", "ooolleoooleh"))

// 1456. Maximum Number of Vowels in a Substring of Given Length
func maxVowels(_ s: String, _ k: Int) -> Int {
    let vowels: Set<Character> = ["a", "e", "i", "o", "u"]
    var curCount = 0
    var maxCount = 0
    let chars = Array(s)
    
    // Handle case when s is shorter than k
    if chars.count < k {
        return 0
    }
    
    // Initialize the first window
    for i in 0..<k {
        if vowels.contains(chars[i]) {
            curCount += 1
        }
    }
    maxCount = curCount
    
    // Slide the window
    for i in k..<chars.count {
        if vowels.contains(chars[i]) {
            curCount += 1
        }
        if vowels.contains(chars[i - k]) {
            curCount -= 1
        }
        
        maxCount = max(maxCount, curCount)
    }
    
    return maxCount
}

//  print(maxVowels("abciiidef", 3))

//  424. Longest Repeating Character Replacement
func characterReplacement(_ s: String, _ k: Int) -> Int {
    let chars = Array(s)
    var dict = [Character: Int]()
    var maxCount = 0
    var maxFreq = 0
    var start = 0
    
    for end in 0..<chars.count {
        dict[chars[end], default: 0] += 1
        maxFreq = max(maxFreq, dict[chars[end]]!)
        
        while end - start + 1 - maxFreq > k {
            dict[chars[start]]! -= 1
            start += 1
            // Recalculate maxFreq only if needed (optional optimization)
            maxFreq = dict.values.max()!
        }
        
        maxCount = max(maxCount, end - start + 1)
    }
    
    return maxCount
}

//  print(characterReplacement("AABABBA", 1))

//  643. Maximum Average Subarray I
func findMaxAverage(_ nums: [Int], _ k: Int) -> Double {
    
    var windowSum = 0
    
    for i in 0..<k {
        windowSum += nums[i]
    }
    
    var maxSum = windowSum
    for i in k..<nums.count {
        windowSum = windowSum + nums[i] - nums[i-k]
        maxSum = max(maxSum, windowSum)
    }
    
    return Double(maxSum) / Double(k)
}

// (n * k)
func findMaxAverageBrute(_ nums: [Int], _ k: Int) -> Double {
    var maxSum = Int.min
    
    for i in 0...nums.count - k {
        var curSum = 0
        for j in i..<i + k {
            curSum += nums[j]
        }
        maxSum = max(maxSum, curSum)
    }
    
    return Double(maxSum) / Double(k)
}

//  print(findMaxAverage([1,12,-5,-6,50,3], 4))

//  3. Longest Substring Without Repeating Characters
func lengthOfLongestSubstring(_ s: String) -> Int {
    
    let chars = Array(s)
    var charMap = [Character: Int]() // Last seen index
    var maxLength = 0
    var start = 0
    
    for end in 0..<chars.count {
        
        if let prevIndex = charMap[chars[end]], prevIndex >= start {
            start = prevIndex + 1
        }
        
        charMap[chars[end]] = end
        maxLength = max(maxLength, end - start + 1)
    }
    
    return maxLength
}

//  print(lengthOfLongestSubstring("abcabcbb"))

//  121. Best Time to Buy And Sell Stock
func maxProfit(_ prices: [Int]) -> Int {
    
    var maxProfit = 0
    var minPrice = Int.max
    
    for price in prices {
        minPrice = min(price, minPrice)
        let curProfit = price - minPrice
        maxProfit = max(maxProfit, curProfit)
    }
    return maxProfit
}

//  print(maxProfit([7,1,5,3,6,4]))
//  print(maxProfit([7,6,4,3,1]))
