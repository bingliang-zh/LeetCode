<https://leetcode.com/explore/interview/card/top-interview-questions-medium/>

- [Array and Strings](#array-and-strings)
  - [3Sum](#3sum)
  - [Set Matrix Zeroes](#set-matrix-zeroes)
  - [Group Anagrams](#group-anagrams)
  - [Longest Substring Without Repeating Characters](#longest-substring-without-repeating-characters)
  - [Longest Palindromic Substring](#longest-palindromic-substring)
  - [Increasing Triplet Subsequence](#increasing-triplet-subsequence)
- [Linked List](#linked-list)
  - [Add Two Numbers](#add-two-numbers)
  - [Odd Even Linked List](#odd-even-linked-list)
  - [Intersection of Two Linked Lists](#intersection-of-two-linked-lists)
- [Trees and Graphs](#trees-and-graphs)
  - [Binary Tree Inorder Traversal](#binary-tree-inorder-traversal)
  - [Binary Tree Zigzag Level Order Traversal](#binary-tree-zigzag-level-order-traversal)
  - [Construct Binary Tree from Preorder and Inorder Traversal](#construct-binary-tree-from-preorder-and-inorder-traversal)
  - [Populating Next Right Pointers in Each Node](#populating-next-right-pointers-in-each-node)
  - [Kth Smallest Element in a BST](#kth-smallest-element-in-a-bst)
  - [Number of Islands](#number-of-islands)
- [Backtracking](#backtracking)
  - [Letter Combinations of a Phone Number](#letter-combinations-of-a-phone-number)
  - [Generate Parentheses](#generate-parentheses)
  - [Permutations](#permutations)
  - [Subsets](#subsets)
  - [Word Search](#word-search)
- [Sorting and Searching](#sorting-and-searching)
  - [Sort Colors](#sort-colors)
  - [Top K Frequent Elements](#top-k-frequent-elements)
  - [Kth Largest Element in an Array](#kth-largest-element-in-an-array)
  - [Find Peak Element](#find-peak-element)
  - [Search for a Range](#search-for-a-range)
  - [Merge Intervals](#merge-intervals)
  - [Search in Rotated Sorted Array](#search-in-rotated-sorted-array)
  - [Search a 2D Matrix II](#search-a-2d-matrix-ii)
- [Dynamic Programming](#dynamic-programming)
  - [Jump Game](#jump-game)
  - [Unique Paths](#unique-paths)
  - [Coin Change](#coin-change)
  - [Longest Increasing Subsequence](#longest-increasing-subsequence)

## Array and Strings

### 3Sum

> Given an array nums of n integers, are there elements a, b, c in nums such that a + b + c = 0? Find all unique triplets in the array which gives the sum of zero.  
Notice that the solution set must not contain duplicate triplets.  

Solution 1: Sort and binary search. n * log(n) + n * n * log(n) => n * n * log(n).
Solution 2: Sort and two pointers. n * log(n) + n * n => n * n. Better.


```typescript
// typescript
function threeSum(nums: number[]): number[][] {
    const result: number[][] = [];
    nums.sort((a, b) => a - b);
    for (let i = 0; i < nums.length; i++) {
        if (i > 0) {
            if (nums[i] === nums[i - 1]) {
                continue;
            }
        }
        const a = nums[i];
        for (let j = i + 1, k = nums.length - 1; j < k;) {
            const b = nums[j];
            const c = nums[k];
            const sum = a + b + c;
            if (sum === 0) {
                result.push([a, b, c]);
                while (j < k && nums[j] === nums[j + 1]) {
                    j++;
                }
                while (j < k && nums[k - 1] === nums[k]) {
                    k--;
                }
                
                j++;
                k--;
            } else if (sum < 0) {
                j++;
            } else {
                k--;
            }
        }
    }
    return result;
};
```

### Set Matrix Zeroes

> Given an m x n matrix. If an element is 0, set its entire row and column to 0. Do it in-place.  
Follow up:  
A straight forward solution using O(mn) space is probably a bad idea.  
A simple improvement uses O(m + n) space, but still not the best solution.  
Could you devise a constant space solution?  

Solution: use NaN as marker during first iteration. But NaN is a js' feature which not every language support.

Solution with hint: mark the first row/column during first iteration.

```typescript
// typescript
function setZeroes(matrix: number[][]): void {
    let firstRow = false;
    let firstColumn = false;

    // [
    //     [a, b, c],
    //     [d, e, f],
    // ]

    const columns = matrix[0].length;
    const rows = matrix.length;

    for (let i = 0; i < columns; i++) {
        for (let j = 0; j < rows; j++) {
            const current = matrix[j][i];
            if (current === 0) {
                if (i !== 0 && j !== 0) {
                    matrix[j][0] = matrix[0][i] = 0;
                } else {
                    if (i === 0) {
                        firstColumn = true;
                    }
                    if (j === 0) {
                        firstRow = true;
                    }
                }
            }
        }
    }

    for (let i = 1; i < columns; i++) {
        if (matrix[0][i] === 0) {
            for (let j = 1; j < rows; j++) {
                matrix[j][i] = 0;
            }
        }
    }

    for (let j = 1; j < rows; j++) {
        if (matrix[j][0] === 0) {
            for (let i = 1; i < columns; i++) {
                matrix[j][i] = 0;
            }
        }
    }

    if (firstColumn) {
        for (let j = 0; j < rows; j++) {
            matrix[j][0] = 0;
        }
    }

    if (firstRow) {
        for (let i = 0; i < columns; i++) {
            matrix[0][i] = 0;
        }
    }
};
```

### Group Anagrams

> Given an array of strings strs, group the anagrams together. You can return the answer in any order.  
An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

```typescript
// typescript
function genId(str: string): string {
    const hash = new Map<string, number>();
    for (let i = 0; i < str.length; i++) {
        const currentChar = str[i];
        if (hash.has(currentChar)) {
            hash.set(currentChar, hash.get(currentChar) + 1);
        } else {
            hash.set(currentChar, 1);
        }
    }
    let result = '';
    for (let i = 0; i < 26; i++) {
        const currentChar = String.fromCharCode('a'.charCodeAt(0) + i);
        if (hash.has(currentChar)) {
            result += currentChar + hash.get(currentChar);
        }
    }
    return result;
}

function groupAnagrams(strs: string[]): string[][] {
    const map = new Map<string, string[]>();

    for (let i = 0; i < strs.length; i++) {
        const current = strs[i];
        const id = genId(current);
        if (map.has(id)){
            map.get(id).push(current);
        } else {
            map.set(id, [current]);
        }
    }
    const arr = []
    for (let i of map.values()) {
        arr.push(i);
    }
    return arr;
};
```

### Longest Substring Without Repeating Characters

> Given a string s, find the length of the longest substring without repeating characters.

```typescript
// typescript
function lengthOfLongestSubstring(s: string): number {
    const set = new Set<string>();

    let leftIndex = 0;
    let rightIndex = 0;
    let setMax = 0;

    for (; rightIndex < s.length; rightIndex ++) {
        while (set.has(s[rightIndex])) {
            set.delete(s[leftIndex]);
            leftIndex++;
        }
        if (!set.has(s[rightIndex])) {
            set.add(s[rightIndex]);
            if (set.size > setMax) {
                setMax = set.size;
            }
        }
    }
    return setMax;
};
```

### Longest Palindromic Substring

> Given a string s, return the longest palindromic substring in s.

```typescript
// typescript
function longestPalindrome(s: string): string {
    function getLongestPalindromeAroundCenter(i: number): number[] {
        let leftIndex: number;
        let rightIndex: number;
        if (i % 2 === 0) {
            leftIndex = i / 2;
            rightIndex = i / 2;
        } else {
            leftIndex = Math.floor(i / 2);
            rightIndex = Math.ceil(i / 2);
        }

        while (leftIndex >= 0 && rightIndex < s.length && s[leftIndex] === s[rightIndex]) {
            leftIndex--;
            rightIndex++;
        }

        return [leftIndex + 1, rightIndex - 1];
    }

    let max: number[] = [0, 0];

    for (let i = 0; i < 2 * s.length - 1; i++) {
        const result = getLongestPalindromeAroundCenter(i);
        if ((result[1] - result[0]) > (max[1] - max[0])) {
            max = result;
        }
    }

    return s.substring(max[0], max[1] + 1);
};
```

### Increasing Triplet Subsequence

> Given an integer array nums, return true if there exists a triple of indices (i, j, k) such that i < j < k and nums[i] < nums[j] < nums[k]. If no such indices exists, return false.

Comments: failed. Get the solution and explanation from web. <https://leetcode.com/problems/increasing-triplet-subsequence/discuss/79004/Concise-Java-solution-with-comments.>

`I would like to point out that for [1, 3, 0, 5] we will eventually arrive at big = 3 and small = 0 so big may come after small. However, the solution still works, because big only gets updated when there exists a small that comes before it. -leetcode_deleted_user`

This is genius. Stuck on this kind of sequence too.

```typescript
// typescript
function increasingTriplet(nums: number[]): boolean {
    let first = Number.MAX_VALUE;
    let second = Number.MAX_VALUE;
    for (let i = 0; i < nums.length; i++) {
        const current = nums[i];
        if (current <= first) {
            first = current;
        } else if (current <= second) {
            second = current;
        } else {
            return true;
        }
    }
    return false;
};
```

## Linked List

```typescript
// typescript
class ListNode {
    val: number
    next: ListNode | null
    constructor(val?: number, next?: ListNode | null) {
        this.val = (val===undefined ? 0 : val)
        this.next = (next===undefined ? null : next)
    }
}

const arrToList = (arr: number[]): ListNode | null => {
    let result: ListNode | null;
    let last: ListNode | null;

    for (let i = 0; i < arr.length; i++) {
        const next = new ListNode(arr[i]);
        if (!result) {
            result = next;
            last = next;
        } else {
            last.next = next;
            last = next;
        }
    }
    return result;
}

const printList = (list: ListNode | null): void => {
    const arr = [];
    while (list) {
        arr.push(list.val);
        list = list.next;
    }
    console.log(arr);
}
```

### Add Two Numbers

> You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.  
You may assume the two numbers do not contain any leading zero, except the number 0 itself.  

```typescript
// typescript
function addTwoNumbers(l1: ListNode | null, l2: ListNode | null): ListNode | null {
    let result: ListNode | null;
    let currentNode: ListNode | null;
    let addOneFlag = false;
    while (l1 && l2) {
        const sum = l1.val + l2.val + (addOneFlag ? 1 : 0);
        const next = new ListNode(sum % 10);
        if (!currentNode) {
            currentNode = result = next;
        } else {
            currentNode = currentNode.next = next;
        }
        addOneFlag = sum > 9;
        l1 = l1.next;
        l2 = l2.next;
    }

    while (l1) {
        const sum = l1.val + (addOneFlag ? 1 : 0);
        const next = new ListNode(sum % 10);
        if (!currentNode) {
            currentNode = result = next;
        } else {
            currentNode = currentNode.next = next;
        }
        addOneFlag = sum > 9;
        l1 = l1.next;
    }

    while (l2) {
        const sum = l2.val + (addOneFlag ? 1 : 0);
        const next = new ListNode(sum % 10);
        if (!currentNode) {
            currentNode = result = next;
        } else {
            currentNode = currentNode.next = next;
        }
        addOneFlag = sum > 9;
        l2 = l2.next;
    }
    if (addOneFlag) {
        currentNode.next = new ListNode(1);
    }
    return result;
};
```

### Odd Even Linked List

> Given the head of a singly linked list, group all the nodes with odd indices together followed by the nodes with even indices, and return the reordered list.  
The first node is considered odd, and the second node is even, and so on.  
Note that the relative order inside both the even and odd groups should remain as it was in the input.

```typescript
// typescript
function oddEvenList(head: ListNode | null): ListNode | null {
    if (head === null || head.next === null) {
        return head;
    }
    let odd = head;
    let even = head.next;
    let initialEven = even;
    let next = even.next;
    let nextOdd = true;

    while (next) {
        if (nextOdd) {
            odd = odd.next = next;
        } else {
            even = even.next = next;
        }
        next = next.next;
        nextOdd = !nextOdd;
    }

    even.next = null;
    odd.next = initialEven;
    return head;
};
```

### Intersection of Two Linked Lists

> Given the heads of two singly linked-lists headA and headB, return the node at which the two lists intersect. If the two linked lists have no intersection at all, return null.  
It is guaranteed that there are no cycles anywhere in the entire linked structure.  
Note that the linked lists must retain their original structure after the function returns.

Solution: Assume A list's length is i, B list's length is j, reverse A list, assume A list's reverse's head is C, now B list's length is k. i = a + 1 + c, j = b + 1 + c, k = b + 1 + a. Then we can resolve a, b and c. Reverse C list, and return intersection when reversing using value c (c equals (i + j - k - 1) / 2). Now the lists remain original.

Comments: Looks like the official best solution is more understandable with O(2a + 2b + 4c + 4). But mine is more interesting with O(3a + 2b + 3c + 4). Both have no additional data structures.

```typescript
// typescript
// a bit mess but it works ^_^
function reverseList(head: ListNode | null, nth?: number): {head: ListNode | null, length: number, nthNode: ListNode | null} {
    if (!head || !head.next) {
        return {
            head,
            length: !head ? 0 : 1,
            nthNode: !head ? null : nth === 1 ? head : head.next && nth === 2 ? head.next : null
        };
    }
    let pA: ListNode | null = null;
    let pB: ListNode | null = head;
    let pC: ListNode | null = head.next;

    let nthNode: ListNode | null = null;
    let length = 1;
    while (pC) {
        if (length === nth) {
            nthNode = pB;
        }

        pB.next = pA;
        pA = pB;
        pB = pC;
        pC = pC.next;
        length++;
    }
    if (length === nth) {
        nthNode = pB;
    }
    pB.next = pA;

    return {
        head: pB,
        length,
        nthNode,
    };
};

function getIntersectionNode(headA: ListNode | null, headB: ListNode | null): ListNode | null {
    let j = 0;
    let iterator = headB;
    let headBEnd = headB;
    // get headB's length
    while (iterator) {
        headBEnd = iterator;
        iterator = iterator.next;
        j++;
    }
    // reverse headA and get headA's length at the same time
    iterator = headA;
    const { length: i, head: headC } = reverseList(iterator);
    if (headBEnd !== headC) {
        reverseList(headC);
        return null;
    }
    // get headB's length
    let k = 0;
    iterator = headB;
    while (iterator) {
        iterator = iterator.next;
        k++;
    }
    // intersection is the (c + 1)th node start from headC
    const c = (i + j - k - 1) / 2;
    // reverse headC
    const { nthNode } = reverseList(headC, c + 1);
    return nthNode;
};
```

## Trees and Graphs

```typescript
// typescript
class TreeNode {
    val: number
    left: TreeNode | null
    right: TreeNode | null
    constructor(val?: number, left?: TreeNode | null, right?: TreeNode | null) {
        this.val = (val===undefined ? 0 : val)
        this.left = (left===undefined ? null : left)
        this.right = (right===undefined ? null : right)
    }
}
```

### Binary Tree Inorder Traversal

> Given the root of a binary tree, return the inorder traversal of its nodes' values.

```typescript
// typescript
function inorderTraversal(root: TreeNode | null): number[] {
    if (!root) { return []; }
    return [...inorderTraversal(root.left), root.val, ...inorderTraversal(root.right)];
};
```

### Binary Tree Zigzag Level Order Traversal

> Given the root of a binary tree, return the zigzag level order traversal of its nodes' values. (i.e., from left to right, then right to left for the next level and alternate between).

```typescript
// typescript
function zigzagLevelOrder(root: TreeNode | null): number[][] {
    const levels = new Map<number, number[]>();
    const f = (node: TreeNode | null, level: number) => {
        if (!node) return;
        if (!levels.has(level)) {
            levels.set(level, []);
        }
        levels.get(level).push(node.val);
        f(node.left, level + 1);
        f(node.right, level + 1);
    }
    f(root, 0);
    const result: number[][] = [];
    for (let i = 0; i < levels.size; i++) {
        const arr = levels.get(i);
        if (i % 2 === 1) {
            arr.reverse();
        }
        result.push(arr);
    }
    return result;
};
```

### Construct Binary Tree from Preorder and Inorder Traversal

> Given two integer arrays preorder and inorder where preorder is the preorder traversal of a binary tree and inorder is the inorder traversal of the same tree, construct and return the binary tree.

```typescript
// typescript
// solution with O(NlogN) time and O(N) space
function buildTree(preorder: number[], inorder: number[]): TreeNode | null {
    if (preorder.length === 0) {
        return null;
    }
    const inorderMap = new Map<number, number>();
    for (let i = 0; i < inorder.length; i++) {
        inorderMap.set(inorder[i], i);
    }
    const root = new TreeNode(preorder[0]);

    const insertNode = (currentIndexInInorder: number, currentValue: number, root: TreeNode) => {
        const rootIndexInInorder = inorderMap.get(root.val);
        if (rootIndexInInorder > currentIndexInInorder) {
            // to left
            if (root.left === null) {
                root.left = new TreeNode(currentValue);
            } else {
                insertNode(currentIndexInInorder, currentValue, root.left);
            }
        } else {
            // to right. The index is different guaranteed. No exceptions here.
            if (root.right === null) {
                root.right = new TreeNode(currentValue);
            } else {
                insertNode(currentIndexInInorder, currentValue, root.right);
            }
        }
    }

    for (let i = 1; i < preorder.length; i++) {
        const currentValue = preorder[i];
        const currentIndexInInorder = inorderMap.get(currentValue);
        insertNode(currentIndexInInorder, currentValue, root);
    }
    return root;
};

// better solution with O(N) time & space
function buildTree(preorder: number[], inorder: number[]): TreeNode | null {
    if (preorder.length === 0) {
        return null;
    }
    const inorderMap = new Map<number, number>();
    for (let i = 0; i < inorder.length; i++) {
        inorderMap.set(inorder[i], i);
    }

    let preorderCurrentIndex = 0;

    const arrToTree = (left: number, right: number): TreeNode | null => {
        if (left > right) return null;
        const currentValue = preorder[preorderCurrentIndex];
        preorderCurrentIndex++;
        const root = new TreeNode(currentValue);
        const rootIndex = inorderMap.get(currentValue);
        root.left = arrToTree(left, rootIndex - 1);
        root.right = arrToTree(rootIndex + 1, right);
        return root;
    }

    return arrToTree(0, preorder.length - 1);
};
```

### Populating Next Right Pointers in Each Node

> You are given a perfect binary tree where all leaves are on the same level, and every parent has two children. The binary tree has the following definition:  
struct Node {  
  int val;  
  Node *left;  
  Node *right;  
  Node *next;  
}  
Populate each next pointer to point to its next right node. If there is no next right node, the next pointer should be set to NULL.  
Initially, all next pointers are set to NULL.  
Follow up:  
You may only use constant extra space.  
Recursive approach is fine, you may assume implicit stack space does not count as extra space for this problem.

Comments: This question's typescript template is a bit confusing with 'Node' class declared. Using javascript to verify my code.

```typescript
// typescript
// class TreeNode {
//     val: number
//     left: TreeNode | null
//     right: TreeNode | null
//     next: TreeNode | null
//     constructor(val?: number, left?: TreeNode, right?: TreeNode, next?: TreeNode) {
//         this.val = (val===undefined ? 0 : val)
//         this.left = (left===undefined ? null : left)
//         this.right = (right===undefined ? null : right)
//         this.next = (next===undefined ? null : next)
//     }
// }

function connect(root: TreeNode | null): TreeNode | null {
    if (root === null) return null;
    if (root.left === null) return root;

    for (let node = root; node !== null; node = node.next) {
        node.left.next = node.right;
        const next = node.next;
        if (next) {
            node.right.next = next.left;
        }
    }
    
    connect(root.left);

    return root;
};
```

### Kth Smallest Element in a BST

> Given the root of a binary search tree, and an integer k, return the kth (1-indexed) smallest element in the tree.

Solution: Inorder traversal solution is easy, skip that. The solution using a stack is better.

```typescript
// typescript
function kthSmallest(root: TreeNode | null, k: number): number {
    const stack: Array<TreeNode> = [];

    let current = root;

    while (true) {
        while (current) {
            stack.push(current);
            current = current.left;
        }
        const focus = stack.pop();
        k--;
        if (k === 0) {
            return focus.val;
        }
        current = focus.right;
    }
};
```

### Number of Islands

> Given an m x n 2D binary grid grid which represents a map of '1's (land) and '0's (water), return the number of islands.  
An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.  

```typescript
// typescript
function numIslands(grid: string[][]): number {
    let identifier = 0;
    const identifierGroups: Map<string, string> = new Map();

    const m = grid.length;
    const n = grid[0].length;

    for (let j = 0; j < m; j++) {
        for (let i = 0; i < n; i++) {
            if (grid[j][i] === '0') {
                continue;
            }
            const left = i === 0 ? '0' : grid[j][i - 1];
            const top = j === 0 ? '0' : grid[j - 1][i];
            if (left === '0' && top === '0') {
                // new identifier
                identifier++;
                const identifierStr = identifier.toString();
                identifierGroups.set(identifierStr, identifierStr);
                grid[j][i] = identifierStr;
            } else if (left !== '0' && top === '0') {
                grid[j][i] = grid[j][i - 1];
            } else if (top !== '0' && left === '0') {
                grid[j][i] = grid[j - 1][i];
            } else {
                const leftStr = grid[j][i - 1];
                const topStr = grid[j - 1][i];
                const getRootGroup = (group: string) => {
                    while (group !== identifierGroups.get(group)) {
                        group = identifierGroups.get(group);
                    }
                    return group;
                }
                let leftGroup = getRootGroup(leftStr);
                let topGroup = getRootGroup(topStr);
                

                if (leftGroup === topGroup) {
                    grid[j][i] = leftGroup;
                } else {
                    const smallerGroupStr = Math.min(Number(leftGroup), Number(topGroup)).toString();
                    identifierGroups.set(leftGroup, smallerGroupStr);
                    identifierGroups.set(topGroup, smallerGroupStr);
                    grid[j][i] = smallerGroupStr;
                }
            }
        }
    }
    let groupsCount = 0;
    for (let [a, b] of identifierGroups) {
        if (a === b) {
            groupsCount++
        }
    }
    return groupsCount;
};
```

## Backtracking

### Letter Combinations of a Phone Number

> Given a string containing digits from 2-9 inclusive, return all possible letter combinations that the number could represent. Return the answer in any order.  
A mapping of digit to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.

```typescript
// typescript
function letterCombinations(digits: string): string[] {
    if (digits === '') {
        return [];
    }
    const cur = digits[0];
    const others = digits.substr(1);
    let curLetters: string;
    switch (cur) {
        case '2': curLetters = 'abc'; break;
        case '3': curLetters = 'def'; break;
        case '4': curLetters = 'ghi'; break;
        case '5': curLetters = 'jkl'; break;
        case '6': curLetters = 'mno'; break;
        case '7': curLetters = 'pqrs'; break;
        case '8': curLetters = 'tuv'; break;
        case '9': curLetters = 'wxyz'; break;
    }
    const otherCombinations = letterCombinations(others);
    const result = [];
    for (let i of curLetters) {
        if (otherCombinations.length === 0) {
            result.push(i);
        } else {
            for (let j of otherCombinations) {
                result.push(i + j);
            }
        }
    }
    return result;
};
```

### Generate Parentheses

> Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.

Comments: generate all possible combinations, then filter.

```typescript
// typescript

// first try, poor-performance
function isWellFormed(str: string): boolean {
    const stack = [];
    for (let i = 0; i < str.length; i++) {
        if (str[i] === '(') {
            stack.push(1);
        } else {
            if (stack.length === 0) {
                return false;
            } else {
                stack.pop();
            }
        }
    }
    return stack.length === 0;
}

function generateParenthesis(n: number): string[] {
    const generateCombinations = (remains: number, available: number): string[] => {
        if (available === 0 || remains > available) {
            return [];
        }
        if (remains === 0) {
            let temp = '';
            while (available > 0) {
                temp += ')';
                available--;
            }
            return [temp];
        }
        if (available === 1) {
            if (remains === 1) {
                return ['('];
            } else {
                return [')'];
            }
        } else {
            const subCombinationsA = generateCombinations(remains - 1, available - 1).map(str => '(' + str);
            const subCombinationsB = generateCombinations(remains, available - 1).map(str => ')' + str);
            return subCombinationsA.concat(subCombinationsB);
        }
    }
    const possibleCombinations = generateCombinations(n, 2 * n);
    return possibleCombinations.filter(str => isWellFormed(str));
};

// backtrack method
function generateParenthesis(n: number): string[] {
    const result = [];

    const backtrack = (currentStr: string, left: number, right: number) => {
        if (currentStr.length === n * 2) {
            result.push(currentStr);
            return;
        }
        if (left < n) {
            backtrack(currentStr + '(', left + 1, right);
        }
        if (right < left) {
            backtrack(currentStr + ')', left, right + 1);
        }
    }

    backtrack('', 0, 0);
    return result;
};
```

### Permutations

> Given an array nums of distinct integers, return all the possible permutations. You can return the answer in any order.

```typescript
// typescript
function permute(nums: number[]): number[][] {
    const result: number[][] = [];

    const backtrack = (cur: number[], available: number[]) => {
        if (cur.length === nums.length) {
            result.push(cur);
            return;
        }
        for (let newNumber of available) {
            backtrack(cur.concat([newNumber]), available.filter(p => p !== newNumber));
        };
    }

    backtrack([], nums);

    return result;
};
```

### Subsets

> Given an integer array nums of unique elements, return all possible subsets (the power set).  
The solution set must not contain duplicate subsets. Return the solution in any order.  

```typescript
// typescript
function subsets(nums: number[]): number[][] {
  const result: number[][] = [];

  const backtrack = (current: number[], nextIndex: number): void => {
    if (nextIndex === nums.length) {
      result.push(current);
      return;
    }

    const nextNumber = nums[nextIndex];

    backtrack([...current, nextNumber], nextIndex + 1);
    backtrack(current, nextIndex + 1);
  }

  backtrack([], 0);

  return result;
};
```

### Word Search

> Given an m x n grid of characters board and a string word, return true if word exists in the grid.  
The word can be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once.  
Note: There will be some test cases with a board or a word larger than constraints to test if your solution is using pruning.

```typescript
// typescript
// first try
function exist(board: string[][], word: string): boolean {
  const m = board.length;
  const n = board[0].length;

  const backtrack = (visited: Array<string>, nextCharacterIndex: number, x: number, y: number) => {
    if (nextCharacterIndex === word.length) {
      return true;
    }
    if (x < 0 || y < 0 || x >= n || y >= m) {
      return false;
    }
    if (board[y][x] !== word[nextCharacterIndex]) {
      return false;
    }
    const key = [x, y].toString();
    if (visited.indexOf(key) >= 0) {
      return false;
    }

    visited = [...visited, key]
    nextCharacterIndex++;

    return backtrack(visited, nextCharacterIndex, x, y - 1)
    || backtrack(visited, nextCharacterIndex, x, y + 1)
    || backtrack(visited, nextCharacterIndex, x - 1, y)
    || backtrack(visited, nextCharacterIndex, x + 1, y);
  }

  for (let i = 0; i < n; i++) {
    for (let j = 0; j < m; j++) {
      const exists = backtrack([], 0, i, j);
      if (exists) {
        return true;
      }
    }
  }

  return false;
};

// second version, mutating the original matrix
function exist(board: string[][], word: string): boolean {
  const m = board.length;
  const n = board[0].length;

  const backtrack = (board: string[][], nextCharacterIndex: number, x: number, y: number) => {
    if (nextCharacterIndex === word.length) {
      return true;
    }
    if (x < 0 || y < 0 || x >= n || y >= m) {
      return false;
    }
    if (board[y][x] !== word[nextCharacterIndex]) {
      return false;
    }
    board[y][x] = '';
    const exists = backtrack(board, nextCharacterIndex + 1, x, y - 1)
    || backtrack(board, nextCharacterIndex + 1, x, y + 1)
    || backtrack(board, nextCharacterIndex + 1, x - 1, y)
    || backtrack(board, nextCharacterIndex + 1, x + 1, y);

    board[y][x] = word[nextCharacterIndex];
    return exists;
  }

  for (let i = 0; i < n; i++) {
    for (let j = 0; j < m; j++) {
      const exists = backtrack(board, 0, i, j);
      if (exists) {
        return true;
      }
    }
  }

  return false;
};
```

## Sorting and Searching

### Sort Colors

> Given an array nums with n objects colored red, white, or blue, sort them in-place so that objects of the same color are adjacent, with the colors in the order red, white, and blue.  
We will use the integers 0, 1, and 2 to represent the color red, white, and blue, respectively.  

```typescript
// typescript
function sortColors(nums: number[]): void {
  let lastRedIndex = -1;
  let firstBlueIndex = nums.length;
  let currentIndex = 0;

  while (currentIndex < firstBlueIndex) {
    let current = nums[currentIndex];
    switch (current) {
      case 0:
        if (currentIndex === lastRedIndex + 1) {
          lastRedIndex++;
          currentIndex++;
        } else {
          nums[currentIndex] = nums[lastRedIndex + 1];
          nums[lastRedIndex + 1] = 0;
          lastRedIndex++;
        }
        break;
      case 1:
        currentIndex++;
        break;
      case 2:
        nums[currentIndex] = nums[firstBlueIndex - 1];
        nums[firstBlueIndex - 1] = 2;
        firstBlueIndex--;
        break;
    }
  }
};
```

### Top K Frequent Elements

> Given an integer array nums and an integer k, return the k most frequent elements. You may return the answer in any order.

```typescript
// typescript
function topKFrequent(nums: number[], k: number): number[] {
  const frequencies = new Map<number, number>();

  for (let i = 0; i < nums.length; i++) {
    const current = nums[i];
    if (frequencies.has(current)) {
      frequencies.set(current, frequencies.get(current) + 1);
    } else {
      frequencies.set(current, 1);
    }
  }

  // use an array to cache k most frequent elements in order
  // TODO: min heap or binary search or quicksort like algorithm could be implemented to improve performance
  const result: Array<{num: number, frequency: number}> = [];
  for (let [num, frequency] of frequencies) {
    if (result.length === 0) {
      result.push({num, frequency});
      continue;
    }
    let newNode = {num, frequency};
    for (let i = 0; i < result.length; i++) {
      if (frequency > result[i].frequency) {
        let temp = result[i];
        result[i] = newNode;
        newNode = temp;
      }
    }
    if (result.length < k) {
      result.push(newNode);
    }
  }
  return result.map(v => v.num);
};
```

### Kth Largest Element in an Array

> Given an integer array nums and an integer k, return the kth largest element in the array.  
Note that it is the kth largest element in the sorted order, not the kth distinct element.

```typescript
// typescript
// first try, use too much new arrays, bad performance
function findKthLargest(nums: number[], k: number): number {
  if (nums.length === 0) {
    return Number.NaN;
  }

  if (nums.length === 1) {
    return nums[0];
  }

  const bigger = [];
  const equal = [];
  const smaller = [];

  const current = nums[0];
  for (let i = 0; i < nums.length; i++) {
    if (nums[i] === current) {
      equal.push(nums[i]);
    } else if (nums[i] > current) {
      bigger.push(nums[i]);
    } else {
      smaller.push(nums[i]);
    }
  }
  const biggerCount = bigger.length;
  const equalCount = equal.length;

  if (k <= biggerCount) {
    return findKthLargest(bigger, k);
  } else if (k > biggerCount && k <= biggerCount + equalCount) {
    return current;
  } else {
    return findKthLargest(smaller, k - biggerCount - equalCount);
  }
};

// second try, implement 3 color algorithm, good space, not good performance
function findKthLargest(nums: number[], k: number): number {
  const swap = (indexA: number, indexB: number) => {
    const temp = nums[indexA];
    nums[indexA] = nums[indexB];
    nums[indexB] = temp;
  }
  
  const findKthLargestOfPart = (startIndex: number, endIndex: number) => {
    if (startIndex > endIndex) {
      return Number.NaN;
    }
    if (startIndex === endIndex) {
      return nums[startIndex];
    }
    let lastBiggerIndex = startIndex - 1;
    let firstSmallerIndex = endIndex + 1;
    let currentIndex = startIndex;
    const reference = nums[currentIndex];
    while (currentIndex < firstSmallerIndex) {
      let current = nums[currentIndex];
      if (current > reference) {
        if (currentIndex === lastBiggerIndex + 1) {
          lastBiggerIndex++;
          currentIndex++;
        } else {
          swap(currentIndex, lastBiggerIndex + 1);
          lastBiggerIndex++;
        }
      } else if (current === reference) {
        currentIndex++;
      } else {
        swap(currentIndex, firstSmallerIndex - 1);
        firstSmallerIndex--;
      }
    }
    if (k - 1 <= lastBiggerIndex) {
      return findKthLargestOfPart(startIndex, lastBiggerIndex);
    } else if (k - 1 < firstSmallerIndex) {
      return reference;
    } else {
      return findKthLargestOfPart(firstSmallerIndex, endIndex);
    }
  }

  return findKthLargestOfPart(0, nums.length - 1);
};

// third try, native algorithm
function findKthLargest(nums: number[], k: number): number {
  nums.sort((a, b) => {return b - a})
  return nums[k - 1];
};
```

### Find Peak Element

> A peak element is an element that is strictly greater than its neighbors.  
Given an integer array nums, find a peak element, and return its index. If the array contains multiple peaks, return the index to any of the peaks.  
You may imagine that nums[-1] = nums[n] = -∞.  
Constraints:  
1 <= nums.length <= 1000  
-231 <= nums[i] <= 231 - 1  
nums[i] != nums[i + 1] for all valid i.  

```typescript
// typescript
// constraints is important
function findPeakElement(nums: number[]): number {
  const _findPeakElement = (startIndex: number, endIndex: number) => {
    if (startIndex === endIndex) {
      return startIndex;
    }
    const middle = Math.floor((startIndex + endIndex) / 2);
    if (nums[middle] > nums[middle + 1]) {
      return _findPeakElement(startIndex, middle);
    } else {
      return _findPeakElement(middle + 1, endIndex);
    }
  }
  return _findPeakElement(0, nums.length - 1);
};
```

### Search for a Range

> Given an array of integers nums sorted in ascending order, find the starting and ending position of a given target value.  
If target is not found in the array, return [-1, -1].  
Follow up: Could you write an algorithm with O(log n) runtime complexity?  

```typescript
// typescript
function searchRange(nums: number[], target: number): number[] {
  const binarySearch = (startIndex: number, endIndex: number, condition: (index: number) => number): number[] => {
    if (startIndex > endIndex) {
      return [-1];
    }
    const mid = Math.floor((startIndex + endIndex) / 2);
    const c = condition(mid);
    if (c === 0) {
      return [mid, startIndex, endIndex];
    } else if (c > 0) {
      // search left
      return binarySearch(startIndex, mid - 1, condition);
    } else {
      // search right
      return binarySearch(mid + 1, endIndex, condition);
    }
  }

  const [found, lastStart, lastEnd] = binarySearch(0, nums.length - 1, (i) => {return nums[i] - target});

  if (found === -1) {
    return [-1, -1];
  }
  const foundLeft = binarySearch(lastStart, found, (i) => {
    if (nums[i] === target && i === lastStart) {
      return 0;
    }
    const isLeft = nums[i - 1] === target;
    const isThis = nums[i] === target;
    if (isThis && !isLeft) {
      return 0;
    } else if (isThis && isLeft) {
      return 1;
    } else {
      return -1;
    }
  })

  const foundRight = binarySearch(found, lastEnd, (i) => {
    if (nums[i] === target && i === lastEnd) {
      return 0;
    }
    const isThis = nums[i] === target;
    const isRight = nums[i + 1] === target;

    if (isThis && !isRight) {
      return 0;
    } else if (isThis && isRight) {
      return -1;
    } else {
      return 1;
    }
  });

  return [foundLeft[0], foundRight[0]]
};
```

### Merge Intervals

> Given an array of intervals where intervals[i] = [starti, endi], merge all overlapping intervals, and return an array of the non-overlapping intervals that cover all the intervals in the input.

```typescript
// typescript
// first try, good speed, poor memory usage
function merge(intervals: number[][]): number[][] {
  const arr: Array<{val: number, type: 0 | 1}> = [];
  for (let i = 0; i < intervals.length; i++) {
    const cur = intervals[i];
    arr.push({val: cur[0], type: 0}, {val: cur[1], type: 1});
  }
  arr.sort((a, b) => {
    const valDiff = a.val - b.val;
    return valDiff === 0 ? a.type - b.type : valDiff;
  });

  const result: number[][] = [];
  let remainingStartCount = 0;
  let currentStart = 0;
  for (let i = 0; i < arr.length; i++) {
    const cur = arr[i];
    if (cur.type === 0) {
      if (remainingStartCount === 0) {
        currentStart = cur.val;
      }
      remainingStartCount++;
    } else {
      remainingStartCount--;
      if (remainingStartCount === 0) {
        result.push([currentStart, cur.val]);
      }
    }
  }
  return result;
};

// second try, better memory usage
function merge(intervals: number[][]): number[][] {
  intervals.sort((a, b) => {
    return a[0] - b[0];
  });

  const result: number[][] = [];
  let lastInterval: number[] | undefined = undefined;

  for (let i = 0; i < intervals.length; i++) {
    const currentInterval = intervals[i];
    if (lastInterval === undefined) {
      lastInterval = currentInterval;
    } else if (lastInterval[1] < currentInterval[0]) {
      // push to result
      result.push(lastInterval);
      lastInterval = currentInterval;
    } else {
      lastInterval[1] = Math.max(lastInterval[1], currentInterval[1]);
    }
  }
  if (lastInterval !== undefined) {
    result.push(lastInterval);
  }

  return result;
};
```

### Search in Rotated Sorted Array

> There is an integer array nums sorted in ascending order (with distinct values).  
Prior to being passed to your function, nums is rotated at an unknown pivot index k (0 <= k < nums.length) such that the resulting array is [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] (0-indexed). For example, [0,1,2,4,5,6,7] might be rotated at pivot index 3 and become [4,5,6,7,0,1,2].  
Given the array nums after the rotation and an integer target, return the index of target if it is in nums, or -1 if it is not in nums.  

Comments: just a variation of binary search

```typescript
// typescript
// TODO: can be simplified
function search(nums: number[], target: number): number {
  const first = nums[0];
  const last = nums[nums.length - 1];

  if (target === first) {
    return 0;
  } else if (target === last) {
    return nums.length - 1;
  }

  if (target > first) {
    // find first part
    const binarySearch = (start: number, end: number) => {
      if (start > end) {
        return -1;
      }
      const mid = Math.floor((start + end) / 2);
      const midValue = nums[mid];
      if (midValue === target) {
        return mid;
      } else if (midValue < first || midValue > target) {
        // find left
        return binarySearch(start, mid - 1);
      } else {
        return binarySearch(mid + 1, end);
      }
    }
    return binarySearch(0, nums.length - 1);
  }

  if (target < last) {
    // find second part
    const binarySearch = (start: number, end: number) => {
      if (start > end) {
        return -1;
      }
      const mid = Math.floor((start + end) / 2);
      const midValue = nums[mid];
      if (midValue === target) {
        return mid;
      } else if (midValue > last || midValue < target) {
        // find right
        return binarySearch(mid + 1, end);
      } else {
        return binarySearch(start, mid - 1);
      }
    }
    return binarySearch(0, nums.length - 1);
  }

  return -1;
};
```

### Search a 2D Matrix II

> Write an efficient algorithm that searches for a target value in an m x n integer matrix. The matrix has the following properties:  
Integers in each row are sorted in ascending from left to right.  
Integers in each column are sorted in ascending from top to bottom.  

```typescript
// typescript
function searchMatrix(matrix: number[][], target: number): boolean {
  const m = matrix.length;
  const n = matrix[0].length;

  let i = n - 1;
  let j = 0;
  // start from the right upper corner
  while (true) {
    const current = matrix[j][i];
    if (current === target) {
      return true;
    }
    if (current > target) {
      if (i === 0) {
        return false;
      } else {
        i--;
      }
    } else {
      // move to next line
      if (j === m - 1) {
        return false;
      } else {
        j++;
      }
    }
  }
};
```

## Dynamic Programming

### Jump Game

> Given an array of non-negative integers nums, you are initially positioned at the first index of the array.  
Each element in the array represents your maximum jump length at that position.  
Determine if you are able to reach the last index.  

Comments: the official 'Greedy' solution is genius.

```typescript
// typescript
function canJump(nums: number[]): boolean {
  if (nums.length === 1) return true;
  const iterate = (index: number) => {
    const maxJumps = nums[index];
    // -1 is visited
    if (maxJumps === 0 || maxJumps === -1) {
      return false;
    }
    nums[index] = -1;
    if (index + maxJumps >= nums.length - 1) {
      return true;
    }
    for (let i = 1; i <= maxJumps; i++) {
      const possible = iterate(index + i);
      if (possible) {
        return true;
      }
    }
    return false;
  }

  return iterate(0);
};
```

### Unique Paths

> A robot is located at the top-left corner of a m x n grid (marked 'Start' in the diagram below).  
The robot can only move either down or right at any point in time. The robot is trying to reach the bottom-right corner of the grid (marked 'Finish' in the diagram below).  
How many possible unique paths are there?

Comments: looks like a Pascal's Triangle（杨辉三角形）.

```typescript
// typescript
function uniquePaths(m: number, n: number): number {
  const rows = Math.max(m, n);
  const columns = Math.min(m, n); // reduce memory usage

  let lastRow = new Array(columns).fill(1);
  for (let j = 1; j < rows; j++) {
    const currentRow = new Array(columns);
    currentRow[0] = 1;
    for (let i = 1; i < columns; i++) {
      currentRow[i] = currentRow[i - 1] + lastRow[i];
    }
    lastRow = currentRow;
  }
  return lastRow[lastRow.length - 1];
};
```

### Coin Change

> You are given an integer array coins representing coins of different denominations and an integer amount representing a total amount of money.  
Return the fewest number of coins that you need to make up that amount. If that amount of money cannot be made up by any combination of the coins, return -1.  
You may assume that you have an infinite number of each kind of coin.  

```typescript
// typescript
// first try, exceed time limit at some case
function coinChange(coins: number[], amount: number): number {
  let result = Number.MAX_VALUE;

  const backtrack = (countedNumber: number, remainsAmount: number, maxDenominationIndex: number) => {
    if (remainsAmount === 0) {
      if (countedNumber < result) {
        result = countedNumber;
      }
      return;
    }
    if (maxDenominationIndex === -1) {
      return;
    }
    const currentDenomination = coins[maxDenominationIndex];

    for (let i = Math.floor(remainsAmount / currentDenomination); i >= 0; i--) {
      backtrack(countedNumber + i, remainsAmount - i * currentDenomination, maxDenominationIndex - 1);
    }
  }

  backtrack(0, amount, coins.length - 1);

  return result === Number.MAX_VALUE ? -1 : result;
};

// second try
function coinChange(coins: number[], amount: number): number {
  const counts: Array<number | undefined> = new Array(amount).fill(undefined);
  counts[0] = 0;

  const countOfAmount = (amount: number) => {
    if (amount < 0) {
      return;
    }
    if (counts[amount] !== undefined) {
      return counts[amount];
    }
    let minCount = Number.MAX_VALUE;
    for (let i = 0; i < coins.length; i++) {
      const subCount = countOfAmount(amount - coins[i]);
      if (subCount === -1) {
        continue;
      }
      if (minCount > subCount + 1) {
        minCount = subCount + 1;
      }
    }
    counts[amount] = minCount === Number.MAX_VALUE ? -1 : minCount;
    return counts[amount];
  }

  countOfAmount(amount);

  return counts[counts.length - 1] !== undefined ? counts[counts.length - 1] : -1;
};
```

### Longest Increasing Subsequence

> Given an integer array nums, return the length of the longest strictly increasing subsequence.  
A subsequence is a sequence that can be derived from an array by deleting some or no elements without changing the order of the remaining elements. For example, [3,6,2,7] is a subsequence of the array [0,3,1,6,2,2,7].  

```typescript
// typescript
// first try, changing map to array will improve performance a bit
function lengthOfLIS(nums: number[]): number {
  const cache = new Map<number, number>(); // sequence length, minimal end amount sequence with same length

  for (let i = 0; i < nums.length; i++) {
    let newCache = new Map<number, number>();
    const current = nums[i];
    newCache.set(1, current);
    for (let [l, end] of cache) {
      if (current > end) {
        newCache.set(l + 1, current);
      }
    }

    // merge caches
    for (let [l, end] of newCache) {
      if (!cache.has(l)) {
        cache.set(l, end);
      } else {
        if (end < cache.get(l)) {
          cache.set(l, end)
        }
      }
    }
  }

  let maxLength = 0;

  for (let [l, e] of cache) {
    if (l > maxLength) {
      maxLength = l;
    }
  }
  return maxLength;
};
// TODO: O(nlog(n)) time complexity solution
```
