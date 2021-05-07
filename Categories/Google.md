## Interview Process

Skip.

## Arrays and Strings

### Longest Substring Without Repeating Characters

```ts
function lengthOfLongestSubstring(s: string): number {
    const cache = new Map<string, number>(); // char -> last index

    let max = 0;
    let currentStartIndex = 0;
    for (let i = 0; i < s.length; i++) {
        if (cache.has(s[i])) {
            const lastUsedIndex = cache.get(s[i]);
            if (lastUsedIndex >= currentStartIndex) {
                currentStartIndex = lastUsedIndex + 1;
            }
        }
        cache.set(s[i], i);
        max = Math.max(max, i - currentStartIndex + 1);
    }
    return max;
};
```

### Container With Most Water

```ts
function maxArea(height: number[]): number {
    let max = 0;
    let l = 0;
    let r = height.length - 1;

    while (l < r) {
        max = Math.max(max, Math.min(height[l], height[r]) * (r - l));
        if (height[l] < height[r]) {
            l++;
        } else {
            r--;
        }
    }
    return max;
};
```

### 3Sum

Skip. Sort, pick two, binary search for the third number or use hashmap instead.

### Next Permutation

Skip. Starting from the end and iterate to left, find the first non ascending number, replace this number with the smallest larger number on its right, sort remaining numbers ascending from left to right.

### Multiply Strings

Skip. Primary school math.

### Rotate Image

Skip. Did it before. 

### Jump Game

```ts
function canJump(nums: number[]): boolean {
    let lastIndex = nums.length - 1;
    for (let i = lastIndex - 1; i >= 0; i--) {
        if (nums[i] + i >= lastIndex) {
            lastIndex = i;
        }
    }
    return lastIndex === 0;
};
```

### Plus One

Skip. Primary school math.


### Minimum Window Substring

Skip.

'ADOBECODEBANC' -> A[0,10],B[3,9],C[5,12] -> [0,3,5],[3,5,10],[5,9,10],[9,10,12] -> [9,10,12] O(S * T).
Or use sliding window.

### Read N Characters Given Read4 II - Call multiple times

TODO, Description too long.

### Longest Substring with At Most Two Distinct Characters

Skip. Sliding window. Use hash map to store latest index for each character.

### Missing Ranges

Skip. Too easy.

### Next Closest Time

Skip. Boring.

### Expressive Words

Skip. Do RLE.

### Others

Too much. Do these later

## Linked Lists

### Add Two Numbers

```ts
function addTwoNumbers(l1: ListNode | null, l2: ListNode | null, addOne: boolean = false): ListNode | null {
    if (l1 === null && l2 === null) return addOne ? new ListNode(1) : null
    if (l1 === null && !addOne) return l2;
    if (l2 === null && !addOne) return l1;
    const sum = (l1 ? l1.val : 0) + (l2 ? l2.val : 0) + (addOne ? 1 : 0);
    const next = addTwoNumbers(l1 ? l1.next : null, l2 ? l2.next : null, sum >= 10)
    return new ListNode(sum % 10, next);
};
```

### Remove Nth Node From End of List

Skip. Two pointers, gap is n + 1, when faster reaches end, remove the slower's next.

### Merge Two Sorted Lists

Skip. Easy.

### Copy List With Random Pointer

Skip. Resolved before.

## Trees and Graphs

### Binary Tree Maximum Path Sum

```ts
function maxPathSum(root: TreeNode | null): number {
    let max = -Number.MAX_VALUE;
    const findMaxPathSumAndReturnMaxPartialSum = (root: TreeNode | null): number => {
        if (root === null) return 0;
        const leftPartialMaxSum = findMaxPathSumAndReturnMaxPartialSum(root.left);
        const rightPartialMaxSum = findMaxPathSumAndReturnMaxPartialSum(root.right);
        max = Math.max(max, leftPartialMaxSum + rightPartialMaxSum + root.val);
        return Math.max(0, Math.max(leftPartialMaxSum, rightPartialMaxSum) + root.val);
    }
    findMaxPathSumAndReturnMaxPartialSum(root);
    return max;
};
```

### Word Ladder

Skip. BFS.

### Number of Islands

Skip. DFS.

### Course Schedule II

Skip. BFS, if there is a loop, throw.

### Count Complete Tree Nodes

## Dynamic Programming

### Split Array Largest Sum

