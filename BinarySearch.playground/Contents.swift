import math_h


// MARK: 35. Search Insert Position
func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    
    var l = 0
    var r = nums.count - 1
    
    while l <= r {
        let m = l + (r - l) / 2
        if nums[m] == target {
            return m
        }
        else if nums[m] > target {
            r = m - 1
        } else {
            l = m + 1
        }
    }
    
    return l
}

//print(searchInsert([1,3,5,6], 1))
//print(searchInsert([1,3,5,6], 5))
//print(searchInsert([1,3,5,6], 2))
//print(searchInsert([1,3,5,6], 7))


// MARK: 981. Time Based Key-Value Store

class TimeMap {
    
    private var keyStore: [String: [Int: [String]]]
    
    init() {
        keyStore = [:]
    }
    
    func set(_ key: String, _ value: String, _ timestamp: Int) {
        if keyStore[key] == nil {
            keyStore[key] = [:]
        }
        
        if keyStore[key]![timestamp] == nil {
            keyStore[key]![timestamp] = []
        }
        
        keyStore[key]![timestamp]
    }
    
    func get(_ key: String, _ timestamp: Int) -> String {
        guard let timeMap = keyStore[key] else {
            return ""
        }
        
        var seen = 0
        for time in timeMap.keys {
            if time <= timestamp {
                seen = max(seen, time)
            }
        }
        return seen == 0 ? "" : timeMap[seen]!.last!
    }
}


// MARK: 33. Search in Rotated Sorted Array
func search(_ nums: [Int], _ target: Int) -> Int {
    
    guard !nums.isEmpty else { return -1 }
    
    var l = 0
    var r = nums.count - 1
    
    while l <= r {
        let m = (l + r) / 2
        
        if nums[m] == target {
            return m
        }
        
        // check if the left half is sorted
        if nums[l] <= nums[m] {
            // check if the target is in the left half
            if nums[l] <= target && target < nums[m] {
                r = m - 1
            } else {
                l = m + 1
            }
        }
        // check if the right half is sorted
        else {
            // check if the target is in the right half
            if nums[m] < target, target <= nums[r] {
                l = m + 1
            } else {
                r = m - 1
            }
        }
    }
    
    return -1
}

//  print(search([5,1,3], 3))


// MARK:  153. Find Minimum in Rotated Sorted Array
func findMin(_ nums: [Int]) -> Int {
    guard !nums.isEmpty else { return -1 }
    
    var l = 0
    var r = nums.count - 1
    
    while l < r {
        let m = (l + r ) / 2
        
        if nums[m] > nums[r] {
            l = m + 1
        } else {
            r = m
        }
    }
    
    return nums[l]
}

//  print(findMin([11,13,15,17]))
//  print(findMin([4,5,6,0,1,2,3]))
//  print(findMin([3,4,5,1,2]))

// MARK:  875. Koko Eating Bananas
func minEatingSpeed(_ piles: [Int], _ h: Int) -> Int {
    var l = 1, r = piles.max()!
    var res = r
    
    while l <= r {
        let mid = (l + r) / 2
        
        var totalTime = 0
        for p in piles {
            totalTime += Int(ceil(Double(p) / Double(mid)))
        }
        
        if totalTime <= h {
            res = mid
            r = mid - 1
        } else {
            l = mid + 1
        }
    }
    return res
}

//  minEatingSpeed([3,6,7,11], 8)

// MARK:  74. Search a 2D Matrix
func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
    guard !matrix.isEmpty, !matrix[0].isEmpty else { return false }
    
    for nums in matrix {
        // Skip if row is empty or target is out of range
        guard !nums.isEmpty else { continue }
        if nums.first! > target || nums.last! < target {
            continue
        }
        
        
        var left = 0
        var right = nums.count - 1
        
        while left <= right {
            let mid = (left + right) / 2
            
            if nums[mid] == target {
                return true
            } else if nums[mid] < target {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
    }
    return false
}

//  print(searchMatrix([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 3))
//  print(searchMatrix([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 13))

func searchMatrix2(_ matrix: [[Int]], _ target: Int) -> Bool {
    
    var result = false
    
    for nums in matrix {
        
        // Check for an empty input
        guard !nums.isEmpty else { return false }
        
        // Check for the corner cases
        if nums.first! > target || nums.last! < target { break }
        
        let count = nums.count
        
        func localBinaryTree(index: Int, left: Int = 0, right: Int = nums.count - 1) {
            // Base case: if left pointer exceeds right pointer
            if left > right {
                return
            }
            
            if nums[index] == target {
                result = true
                return
            } else if target > nums[index] {
                let newIndex = (index + 1 + right) / 2
                localBinaryTree(index: newIndex, left: index + 1, right: right)
            }  else {
                let newIndex = (index + left - 1) / 2
                localBinaryTree(index: newIndex, left:  left, right: right - 1)
            }
        }
        
        if !result { localBinaryTree(index: count / 2) }
    }
    
    return result
}

// MARK:  704. Binary Search
func searchB(_ nums: [Int], _ target: Int) -> Int {
    // Check for an empty input
    guard !nums.isEmpty else { return -1 }
    
    // Check for the corner cases
    if nums.first! > target || nums.last! < target { return -1 }
    
    let count = nums.count
    var result = -1
    
    func binarySearch(index: Int, left: Int = 0, right: Int = nums.count - 1) {
        // Base case: if left pointer exceeds right pointer
        if left > right {
            return
        }
        
        if target == nums[index] {
            result = index
        } else if target > nums[index] {
            // Search right half
            let newIndex = (index + 1 + right) / 2
            binarySearch(index: newIndex, left: index + 1, right: right)
        } else {
            // Search left half
            let newIndex = (left + index - 1) / 2
            binarySearch(index: newIndex, left: left, right: index - 1)
        }
    }
    
    binarySearch(index: count / 2)
    return result
}

//  print(search([-1,0,3,5,9,12], 9))
