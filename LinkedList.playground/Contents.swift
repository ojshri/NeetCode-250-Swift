import Foundation



//  19. Remove Nth Node From End of List
func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    
    let dummy = ListNode(0, head)
    var left: ListNode? = dummy
    var right: ListNode? = head
    var n = n
    
    while n > 0 {
        right = right?.next
        n -= 1
    }
    
    while right != nil {
        left = left?.next
        right = right?.next
    }
    
    left?.next = left?.next?.next
    return dummy.next
}

// 143. Reorder List
func reorderList(_ head: ListNode?) {
    if head == nil {
        return
    }
    
    var slow = head
    var fast = head?.next
    
    while slow != nil && fast != nil {
        slow = slow?.next
        fast = fast?.next?.next
    }
    
    
    var second = slow?.next // Second half
    var prev: ListNode? = nil
    slow?.next = nil // First Half
    
    // Reverse the second half
    while second != nil {
        //  1 -> 2 -> 3 focussing on 2
        let next = second?.next     // Store 3
        second!.next = prev         // Sets 1
        // For next operation
        prev = second               // Sets previous to Current
        second = next               // update the value of current to the next
    }
    
    var first = head
    second = prev
    
    while second != nil {
        let tmp1 = first?.next
        let tmp2 = second?.next
        first?.next = second
        second?.next = tmp1
        first = tmp1
        second = tmp2
    }
}


func reorderList2(_ head: ListNode?) {
    if head == nil {
        return
    }
    
    var nodes: [ListNode] = []
    var cur = head
    
    
    while cur != nil {
        nodes.append(cur!)
        cur = cur?.next
    }
    
    var i = 0, j = nodes.count - 1
    while i < j {
        nodes[i].next = nodes[j]
        i += 1
        
        if i >= j {
            break
        }
        nodes[j].next = nodes[i]
        j -= 1
    }
    nodes[i].next = nil
}

// 141. Linked List Cycle
func hasCycle(_ head: ListNode?) -> Bool {
    var seen = Set<ObjectIdentifier>()
    var cur = head
    
    while cur != nil {
        let nodeId = ObjectIdentifier(cur!)
        if seen.contains(nodeId) {
            return true
        }
        seen.insert(nodeId)
        cur = cur?.next
    }
    return false
}


//  21. Merge Two Sorted Lists
func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
    
    if list1 == nil {
        return list2
    }
    
    if list2 == nil {
        return list1
    }
    
    let dummy = ListNode(0)
    var current: ListNode? = dummy
    var n1: ListNode? = list1
    var n2: ListNode? = list2
    
    while n1 != nil && n2 != nil {
        if n1!.val <= n2!.val {
            current?.next = n1
            n1 = n1?.next
        } else {
            current?.next = n2
            n2 = n2?.next
        }
        current = current?.next
    }
    
    current?.next = n1 != nil ? n1 : n2
    
    return dummy.next
}


//  MARK: 206. Reverse Linked List
func reverseList(_ head: ListNode?) -> ListNode? {
    var prev: ListNode? = nil
    var curr = head
    
    while curr != nil {
        let next = curr?.next // Save next node
        curr?.next = prev     // Reverse the link
        prev = curr           // Move prev forward
        curr = next           // Move curr forward
    }
    
    return prev
}

// MARK: ListNode
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

