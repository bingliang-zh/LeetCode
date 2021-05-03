- [Arrays and Strings](#arrays-and-strings)
  - [Two Sum](#two-sum)
  - [Valid Palindrome](#valid-palindrome)
  - [String to Integer (atoi)](#string-to-integer-atoi)
  - [Reverse String](#reverse-string)
  - [Reverse Words in a String](#reverse-words-in-a-string)
  - [Reverse Words in a String II](#reverse-words-in-a-string-ii)
  - [Valid Parentheses](#valid-parentheses)
  - [Longest Palindromic Substring](#longest-palindromic-substring)
  - [Group Anagrams](#group-anagrams)
  - [Trapping Rain Water](#trapping-rain-water)
  - [Set Matrix Zeroes](#set-matrix-zeroes)
  - [Rotate Image](#rotate-image)
  - [Spiral Matrix](#spiral-matrix)

## Arrays and Strings

### Two Sum

Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

You can return the answer in any order.

```ts
function twoSum(nums: number[], target: number): number[] {
    const map = new Map<number, number>(); // value -> index
    for (let i = 0; i < nums.length; i++) {
        const diff = target - nums[i];
        if (map.has(diff)) {
            return [map.get(diff), i];
        } else {
            map.set(nums[i], i);
        }
    }
    return [];
};
```

### Valid Palindrome

Given a string s, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.

Skip. Two pointers.

### String to Integer (atoi)

Skip.

### Reverse String

Write a function that reverses a string. The input string is given as an array of characters s.

Skip. Two pointers.

### Reverse Words in a String

Given an input string s, reverse the order of the words.

A word is defined as a sequence of non-space characters. The words in s will be separated by at least one space.

Return a string of the words in reverse order concatenated by a single space.

Note that s may contain leading or trailing spaces or multiple spaces between two words. The returned string should only have a single space separating the words. Do not include any extra spaces.

Skip. A string for final string, another string for current word.

### Reverse Words in a String II

Given a character array s, reverse the order of the words.

A word is defined as a sequence of non-space characters. The words in s will be separated by a single space.

```ts
function reverseWords(s: string[]): void {
    const reverse = (i: number, j: number): void => {
        while (i < j) {
            const temp = s[j];
            s[j] = s[i];
            s[i] = temp;
            i++;
            j--;
        }
    }

    reverse(0, s.length - 1);

    for (let i = 0, j = 0; i < s.length; i++) {
        if (s[i] === ' ') {
            reverse(j, i - 1);
            j = i + 1;
        } else if (i === s.length - 1) {
            reverse(j, i);
        }
    }
};
```

### Valid Parentheses

Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

An input string is valid if:

Open brackets must be closed by the same type of brackets.
Open brackets must be closed in the correct order.
 
Skip. Use stack.

### Longest Palindromic Substring

Given a string s, return the longest palindromic substring in s.

Skip. Loop for each pivot.

### Group Anagrams

Given an array of strings strs, group the anagrams together. You can return the answer in any order.

An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

Skip. Format a word to counts, such as 'abc' -> [1,1,1,0...0]. Use formatted as map's keys.

### Trapping Rain Water

Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it can trap after raining.

```ts
// DP
function trap(height: number[]): number {
    const n = height.length;
    const maxOnRight = new Array<number>(n);
    const maxOnLeft = new Array<number>(n);
    let max = 0;
    for (let i = 0; i < n; i++) {
        max = maxOnLeft[i] = Math.max(height[i], max);
    }
    max = 0;
    for (let i = n - 1; i >= 0; i--) {
        max = maxOnRight[i] = Math.max(height[i], max);
    }

    let result = 0;
    for (let i = 0; i < n; i++) {
        result += Math.min(maxOnLeft[i], maxOnRight[i]) - height[i];
    }
    return result;
};
```

```ts
// two pointers
function trap(height: number[]): number {
    let result = 0;
    let leftMax = 0;
    let rightMax = 0;
    let i = 0;
    let j = height.length - 1;
    while (i < j) {
        if (height[i] < height[j]) {
            result += Math.max(leftMax - height[i], 0);
            leftMax = Math.max(leftMax, height[i]);
            i++;
        } else {
            result += Math.max(rightMax - height[j], 0);
            rightMax = Math.max(rightMax, height[j]);
            j--;
        }
    }
    return result;
};
```

### Set Matrix Zeroes

Given an m x n matrix. If an element is 0, set its entire row and column to 0. Do it in-place.

Follow up:

A straight forward solution using O(mn) space is probably a bad idea.
A simple improvement uses O(m + n) space, but still not the best solution.
Could you devise a constant space solution?
 
Skip. Use first row and first column as cache. Extra 2 space for first row and first column.

### Rotate Image

You are given an n x n 2D matrix representing an image, rotate the image by 90 degrees (clockwise).

You have to rotate the image in-place, which means you have to modify the input 2D matrix directly. DO NOT allocate another 2D matrix and do the rotation.

Skip. Mirror along diagonal and mirror along vertical center line.

### Spiral Matrix

Given an m x n matrix, return all elements of the matrix in spiral order.

```ts
function spiralOrder(matrix: number[][]): number[] {
    let direction = 0; // 0: right, 1: down, 2: left, 3: up
    let l = 0;
    let r = matrix[0].length - 1;
    let t = 0;
    let b = matrix.length - 1;

    let result = new Array<number>(matrix.length * matrix[0].length);
    let j = 0;

    while (l <= r && t <= b) {
        switch (direction % 4) {
            case 0:
                for (let i = l; i <= r; i++, j++) {
                    result[j] = matrix[t][i];
                }
                t++;
                break;
            case 1:
                for (let i = t; i <= b; i++, j++) {
                    result[j] = matrix[i][r];
                }
                r--;
                break;
            case 2:
                for (let i = r; i >= l; i--, j++) {
                    result[j] = matrix[b][i];
                }
                b--;
                break;
            case 3:
                for (let i = b; i >= t; i--, j++) {
                    result[j] = matrix[i][l];
                }
                l++;
                break;
        }
        direction++;
    }

    return result;
};
```

## Linked List

```ts
class ListNode {
    val: number
    next: ListNode | null
    constructor(val?: number, next?: ListNode | null) {
        this.val = (val===undefined ? 0 : val)
        this.next = (next===undefined ? null : next)
    }
}
```

### Reverse Linked List

Given the head of a singly linked list, reverse the list, and return the reversed list.

```ts
function reverseList(head: ListNode | null): ListNode | null {
    let a = null;
    let b = head;

    while (b) {
        const temp = b.next;
        b.next = a;
        a = b;
        b = temp;
    }

    return a;
};
```

### Linked List Cycle

Given head, the head of a linked list, determine if the linked list has a cycle in it.

There is a cycle in a linked list if there is some node in the list that can be reached again by continuously following the next pointer. Internally, pos is used to denote the index of the node that tail's next pointer is connected to. Note that pos is not passed as a parameter.

Return true if there is a cycle in the linked list. Otherwise, return false.

```ts
function hasCycle(head: ListNode | null): boolean {
    if (head === null) return false;
    if (head.next === null) return false;
    let fast = head.next;
    let slow = head;
    while (fast) {
        if (slow === fast) {
            return true;
        }
        slow = slow.next;
        if (fast.next && fast.next.next) {
            fast = fast.next.next;
        } else {
            return false;
        }
    }
};
```

### Add Two Numbers

Skip.

### Add Two Numbers II

Skip.

### Merge Two Sorted Lists

Skip.

### Merge k Sorted Lists

Skip.

### Intersection of Two Linked Lists

```ts
function getIntersectionNode(headA: ListNode | null, headB: ListNode | null): ListNode | null {
    const stackA = [];
    const stackB = [];
    while (headA) {
        stackA.push(headA);
        headA = headA.next;
    }
    while (headB) {
        stackB.push(headB);
        headB = headB.next;
    }
    if (stackA.length === 0 || stackB.length === 0) return null;
    let intersection = null;
    for (let i = stackA.length - 1, j = stackB.length - 1; i >= 0 && j >= 0; i--, j--) {
        if (stackA[i] === stackB[j]) {
            intersection = stackA[i];
        } else { break; }
    }
    return intersection;
};
```

### 138. Copy List with Random Pointer

```ts
class ListNode {
    val: number
    next: ListNode | null
    random: ListNode | null
    constructor(val?: number, next?: ListNode, random?: ListNode) {
        this.val = (val===undefined ? 0 : val)
        this.next = (next===undefined ? null : next)
        this.random = (random===undefined ? null : random)
    }
}
function copyRandomList(head: ListNode) {
    if (head === null) return null;
    let it = head;
    while (it) {
        // a->b => a->a'->b->b'
        const copy = new ListNode(it.val, it.next);
        it.next = copy;
        it = copy.next;
    }
    it = head;
    while (it) {
        // maintain random pointer
        const copy = it.next;
        copy.random = it.random ? it.random.next : null;
        it = copy.next;
    }
    const result = head.next;
    it = head;

    while (it) {
        const copy = it.next;
        it.next = copy.next;
        copy.next = copy.next ? copy.next.next : null;
        it = it.next;
    }
    return result;
};
```

## Trees and Graphs

```ts
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

### Validate Binary Search Tree

```ts
function isValidBST(root: TreeNode | null): boolean {
    // isValidBST -> left is Valid, right is valid, left.max < root.val < right.min
    const _IsValidBST = (node: TreeNode | null): {valid: boolean, min: number | null, max: number | null} => {
        if (node === null) return {valid: true, min: null, max: null};
        const left = _IsValidBST(node.left);
        const right = _IsValidBST(node.right);
        const leftValidInVal = left.max === null ? true : left.max < node.val;
        const rightValidInVal = right.min === null ? true : node.val < right.min;
        return {
            valid: left.valid && right.valid && leftValidInVal && rightValidInVal,
            min: left.min || node.val,
            max: right.max || node.val,
        }
    }
    return _IsValidBST(root).valid;
};
```

Verify whether the inorder traversal is strictly ascending is another method.

# TODO!!!: network is bad, revisit best solutions after.

### Binary Tree Inorder Traversal

Skip. Inorder(p) = [...Inorder(p.left), p.v, ...Inorder(p.right)];

Use a stack with DFS is a iterative method.

### Binary Tree Level Order Traversal

Skip. DFS. [level0, level1, ...].flat().

Use an array [l0A, l1A, l1B, ...]. Operate pointers carefully (pLastLevelHead, pLastLevelEnd, pLastLevelIterater).

### Binary Tree Zigzag Level Order Traversal

Skip. DFS as same as 'Binary Tree Level Order Traversal'

Use stack and queue in turns. Queue for odd level, stack for even level.

### Populating Next Right Pointers in Each Node

Skip. DFS. [level0's most right, level1's, ...]

### Populating Next Right Pointers in Each Node II

O(1) space.

Skip. Iterate every level. pLastLevel, pCurrentLevel, pCurrentLevelHead. Populating current level use last level as reference.

### Lowest Common Ancestor of a Binary Search Tree

```ts
function lowestCommonAncestor(root: TreeNode | null, p: TreeNode | null, q: TreeNode | null): TreeNode | null {
	if (root === null) return null;
    if (root.val === p.val || root.val === q.val) return root;
    if (p.val > q.val) return lowestCommonAncestor(root, q, p);
    if (p.val < root.val && root.val < q.val) return root;
    if (q.val < root.val) return lowestCommonAncestor(root.left, p, q);
    else return lowestCommonAncestor(root.right, p, q);
};
```

### Lowest Common Ancestor of a Binary Tree

```ts
function lowestCommonAncestor(root: TreeNode | null, p: TreeNode | null, q: TreeNode | null): TreeNode | null {
    if (root === null || p === null || q === null) return null;
    
    const findPath = (node: TreeNode, root: TreeNode | null): TreeNode[] | null => {
        if (root === null) return null;
        if (root === node) return [root];
        const sub = findPath(node, root.left) || findPath(node, root.right);
        return sub !== null ? [root, ...sub] : null;
    }

    const pQ = findPath(p, root);
    const qQ = findPath(q, root);

    let i = 0;
    for (; i < Math.min(pQ.length, qQ.length) && pQ[i] === qQ[i]; i++) {}

    return pQ[i-1];
};
```

### Construct Binary Tree from Preorder and Inorder Traversal

```ts
function buildTree(preorder: number[], inorder: number[]): TreeNode | null {
    // preorder [root, ...leftSub, ...rightSub]
    // inorder [...leftSub, root, ...rightSub]
    const inorderMap = new Map<number, number>(); // value -> index in inorder
    for (let i = 0; i < inorder.length; i++) {
        inorderMap.set(inorder[i], i);
    }
    const _buildTree = (lIndex: number, rIndex: number): TreeNode | null => {
        if (lIndex > rIndex) return null;
        const root = new TreeNode(preorder[lIndex]);
        if (lIndex === rIndex) return root;
        let i = lIndex + 1;
        for (; i <= rIndex && inorderMap.get(preorder[i]) < inorderMap.get(preorder[lIndex]); i++) {}
        root.left = _buildTree(lIndex + 1, i - 1);
        root.right = _buildTree(i, rIndex);
        return root;
    }

    return _buildTree(0, preorder.length - 1);
};
```

### Number of Islands

```ts
function numIslands(grid: string[][]): number {
    // DFS
    const m = grid.length;
    const n = grid[0].length;

    let currentIslandId = 2;

    const DFS = (i: number, j: number) => {
        if (grid[j][i] !== '1') {
            return false; // water or visited
        }
        grid[j][i] = currentIslandId.toString(); // visited
        // left
        if (i > 0) DFS(i - 1, j);
        // right
        if (i < n - 1) DFS(i + 1, j);
        // top
        if (j > 0) DFS(i, j - 1);
        // bottom
        if (j < m - 1) DFS(i, j + 1);
        return true;
    }

    for (let j = 0; j < m; j++) {
        for (let i = 0; i < n; i++) {
            const flag = DFS(i, j);
            if (flag) currentIslandId++;
        }
    }
    return (currentIslandId - 2);
};
```

### Clone Graph

```ts
function cloneGraph(node: Node | null): Node | null {
    if (node === null) return null;
	const map = new Map<number, Node>(); // val -> Node

    const DFS = (node: Node): Node => { // original -> clone
        if (map.has(node.val)) {
            return map.get(node.val);
        }

        const clone = new Node(node.val);
        map.set(node.val, clone);

        for (let neighbor of node.neighbors) {
            clone.neighbors.push(DFS(neighbor));
        }
        return clone;
    }
    return DFS(node);
};
```

## Backtracking

### Letter Combinations of a Phone Number

```ts
function digit2Characters(digit: string): string {
    switch (digit) {
        case '2': return 'abc';
        case '3': return 'def';
        case '4': return 'ghi';
        case '5': return 'jkl';
        case '6': return 'mno';
        case '7': return 'pqrs';
        case '8': return 'tuv';
        case '9': return 'wxyz';
    }
}

function letterCombinations(digits: string): string[] {
    if (digits.length === 0) return [];
    const backtrack = (done: string[], todo: string[]): string[] => {
        if (todo.length === 0) return done;
        const [digit, ...rest] = todo;
        const newDone: string[] = [];
        for (let char of digit2Characters(digit)) {
            for (let doneStr of done) {
                newDone.push(doneStr + char);
            }
        }
        return backtrack(newDone, rest);
    }
    return backtrack([''], [...digits]);
};
```

### Word Search II

```ts
class Trie {
    arr: Array<Trie | undefined> = new Array(26); // 'a' -> Trie
    word: string | undefined = undefined;

    insert(str: string, word?: string): void {
        if (str.length === 0) {
            this.word = word;
        } else {
            const first = str[0];
            const rest = str.substr(1);
            const index = first.charCodeAt(0) - 'a'.charCodeAt(0);
            if (!this.arr[index]) {
                this.arr[index] = new Trie;
            }
            this.arr[index].insert(rest, word ? word : str);
        }
    }

    getSubTrie(char: string): Trie | undefined {
        const index = char.charCodeAt(0) - 'a'.charCodeAt(0);
        return this.arr[index];
    }
}

function findWords(board: string[][], words: string[]): string[] {
    const root = new Trie;
    for (let word of words) {
        root.insert(word);
    }

    const n = board[0].length;
    const m = board.length;

    const findMatchedWords = (i: number, j: number, trie: Trie): string[] => {
        const currentChar = board[j][i];
        if (currentChar === ' ') return []; // space as visited
        const subTrie = trie.getSubTrie(currentChar);
        if (!subTrie) return []; // no such word
        const result = [];
        if (subTrie.word) {
            result.push(subTrie.word);
        }
        board[j][i] = ' ' // space as visited
        if (i > 0) result.push(...findMatchedWords(i - 1, j, subTrie));
        if (i < n - 1) result.push(...findMatchedWords(i + 1, j, subTrie));
        if (j > 0) result.push(...findMatchedWords(i, j - 1, subTrie));
        if (j < m - 1) result.push(...findMatchedWords(i, j + 1, subTrie));
        board[j][i] = currentChar;
        return result;
    }

    const set = new Set<string>();
    // DFS
    for (let j = 0; j < m; j++){
        for (let i = 0; i < n; i++) {
            for (let word of findMatchedWords(i, j, root)) {
                set.add(word);
            }
        }
    }
    return Array.from(set);
};
```

### Wildcard Matching

```ts
// first try
function isMatch(s: string, p: string): boolean {
    const memo = new Map<string, boolean>();

    const removeDuplicatedStars = (p: string): string => {
        if (p.length < 2) return p;
        let result = p[0];
        for (let i = 1; i < p.length; i++) {
            if (p[i] === '*' && p[i - 1] === '*') continue;
            result += p[i];
        }
        return result;
    }

    const backtrack = (s: string, p: string): boolean => {
        if (p === '' && s === '') return true;
        if (p === '*') return true;
        if (p === '') return false;
        if (s === '' && p[0] !== '*') return false;
        if (p === '?' && s.length === 1) return true;
        if (p === s) return true;
        const key = s + ',' + p;
        if (memo.has(key)) return memo.get(key);

        const firstP = p[0];
        const restP = p.substring(1);
        switch (firstP) {
            case '?': {
                const result = backtrack(s.substring(1), restP);
                memo.set(key, result);
                return result;
            }
            case '*':
                const possibleS = [];
                for (let i = 0; i <= s.length; i++) {
                    possibleS.push(s.substring(i));
                }
                for (let i = 0; i < possibleS.length; i++) {
                    if (backtrack(possibleS[i], restP)) {
                        memo.set(key, true);
                        return true;
                    }
                }
                memo.set(key, false);
                return false;
            default:
                const result = s[0] === firstP ? backtrack(s.substring(1), restP) : false;
                memo.set(key, result);
                return result;
        }
    }

    return backtrack(s, removeDuplicatedStars(p));
};
```

```ts
// DP
//  ^abcbd
// ^100000
// *111111
// b001010
// ?000101
// d000000
function isMatch(s: string, p: string): boolean {
    const removeDuplicatedStars = (p: string): string => {
        if (p.length < 2) return p;
        let result = p[0];
        for (let i = 1; i < p.length; i++) {
            if (p[i] === '*' && p[i - 1] === '*') continue;
            result += p[i];
        }
        return result;
    }

    p = removeDuplicatedStars(p);

    const m = p.length + 1;
    const n = s.length + 1;

    const table: boolean[][] = new Array(m);
    table[0] = new Array<boolean>(n).fill(false);
    table[0][0] = true;
    for (let j = 1; j < m; j++) {
        table[j] = new Array<boolean>(n).fill(false);
        for (let i = 0; i < n; i++) {
            switch (p[j - 1]) {
                case '*':
                    table[j][i] = table[j - 1][i] === true ? true : i === 0 ? false : table[j][i - 1];
                    break;
                case '?':
                    table[j][i] = i === 0 ? false : table[j - 1][i - 1];
                    break;
                default:
                    table[j][i] = i === 0 ? false : table[j - 1][i - 1] && s[i - 1] === p[j - 1];
                    break;
            }
        }
    }
    return table[m - 1][n - 1];
};
```

```ts
// second try
function isMatch(s: string, p: string): boolean {
    const cache = new Map<string, boolean>(); // sIndex,pIndex => bool
    const removeDuplicatedStars = (p: string): string => {
        if (p.length < 2) return p;
        let result = p[0];
        for (let i = 1; i < p.length; i++) {
            if (p[i] === '*' && p[i - 1] === '*') continue;
            result += p[i];
        }
        return result;
    }

    p = removeDuplicatedStars(p);
    const backtrack = (sIndex: number, pIndex: number): boolean => {
        const key = `${sIndex},${pIndex}`;
        if (cache.has(key)) return cache.get(key);
        if (sIndex === s.length) {
            for (let i = pIndex; i < p.length; i++) {
                if (p[i] !== '*') {
                    cache.set(key, false)
                    return false;
                }
            }
            cache.set(key, true)
            return true;
        }

        const sChar = s[sIndex];
        const pChar = p[pIndex];
        switch (pChar) {
            case '*':
                for (let i = sIndex; i <= s.length; i++) {
                    if (backtrack(i, pIndex + 1)) {
                        cache.set(key, true)
                        return true;
                    }
                }

                cache.set(key, false)
                return false;
            case '?':
                const result = backtrack(sIndex + 1, pIndex + 1);
                cache.set(key, result);
                return result;
            default:
                {
                    const result = sChar === pChar ? backtrack(sIndex + 1, pIndex + 1) : false;
                    cache.set(key, result);
                    return result;
                }
        }
    }
    return backtrack(0, 0);
};
```

```ts
// final
function isMatch(s: string, p: string): boolean {
    let sIndex = 0;
    let pIndex = 0;
    let sTempIndex = -1;
    let pStarIndex = -1;

    while (sIndex < s.length) {
        if (pIndex < p.length && (s[sIndex] === p[pIndex] || p[pIndex] === '?')) {
            sIndex++;
            pIndex++;
        } else if (pIndex < p.length && p[pIndex] === '*') {
            pStarIndex = pIndex;
            sTempIndex = sIndex;
            pIndex++;
        } else {
            if (sTempIndex === -1) return false;
            pIndex = pStarIndex + 1;
            sIndex = sTempIndex + 1;
            sTempIndex++;
        }
    }

    while (pIndex < p.length) {
        if (p[pIndex] !== '*') return false;
        pIndex++;
    }
    return true;
};
```

### Regular Expression Matching

```ts
// DP
function isMatch(s: string, p: string): boolean {
    const splitP = new Array<string>(); // 'ac*..*' -> a,c*,.,.*
    for (let i = 0; i < p.length; i++) {
        if (p[i + 1] === '*') {
            splitP.push(p[i] + p[i+1]);
            i++;
        } else {
            splitP.push(p[i]);
        }
    }

    const n = s.length + 1;
    const m = splitP.length + 1;

    const mat: boolean[][] = new Array(m);
    mat[0] = [true, ...new Array(n - 1).fill(false)];

    for (let j = 1; j < m; j++) {
        mat[j] = new Array(n);
        mat[j][0] = mat[j - 1][0] ? splitP[j - 1].length === 2 : false;
        for (let i = 1; i < n; i++) {
            if (splitP[j - 1] === '.'){
                mat[j][i] = mat[j - 1][i - 1];
            } else if (splitP[j - 1].length === 1) {
                mat[j][i] = splitP[j-1] === s[i - 1] ? mat[j-1][i-1] : false;
            } else if (splitP[j - 1] === '.*') {
                mat[j][i] = mat[j][i-1] || mat[j-1][i];
            } else {
                mat[j][i] = splitP[j-1][0] === s[i-1] ? mat[j][i-1] || mat[j-1][i] : mat[j-1][i];
            }
        }
    }

    return mat[m-1][n-1];
};
```

## Sorting and Searching

### Remove Duplicates from Sorted Array

```ts
function removeDuplicates(nums: number[]): number {
    let cur = 0;
    for (let next = 0; next < nums.length; next++) {
        if (nums[cur] === nums[next]) {
            continue;
        } else {
            cur++;
            nums[cur] = nums[next];
        }
    }
    return cur + 1;
};
```

### Merge Sorted Array

Skip. Ascending from left to right means descending from right to left.

### Sort Colors

```ts
function sortColors(nums: number[]): void {
    let left = 0;
    let right = nums.length - 1;
    let cur = 0;
    while (cur <= right) {
        if (nums[left] === 0) {
            left++;
            cur++;
        } else if (nums[right] === 2) {
            right--;
        } else if (nums[cur] === 1) {
            cur++;
        } else if (nums[cur] === 0) {
            nums[cur] = nums[left];
            nums[left] = 0;
        } else if (nums[cur] === 2) {
            nums[cur] = nums[right];
            nums[right] = 2;
        }
    }
};
```

### Find Minimum in Rotated Sorted Array

```ts
function findMin(nums: number[]): number {
    const n = nums.length;
    if (nums[0] < nums[n-1]) return nums[0];

    const BinarySearch = (left: number, right: number): number => {
        if (left === right) return left;
        const mid = Math.floor((left + right) / 2);
        if (nums[mid] >= nums[0]) {
            // find right
            return BinarySearch(mid + 1, right);
        } else if (nums[mid] < nums[mid - 1]) {
            return mid;
        } else {
            return BinarySearch(left, mid - 1);
        }
    }
    return nums[BinarySearch(0, n - 1)];
};
```

### Search in Rotated Sorted Array

```ts
function search(nums: number[], target: number): number {
    let left = 0;
    let right = nums.length - 1;
    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        if (nums[mid] === target) return mid;
        if (nums[mid] >= nums[0]) {
            if (nums[left] <= target && target < nums[mid]) {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        } else {
            if (nums[mid] < target && target < nums[0]) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
    }
    return -1;
};
```

### Search a 2D Matrix

```ts
function searchMatrix(matrix: number[][], target: number): boolean {
    const m = matrix.length;
    const n = matrix[0].length;

    const getVal = (num: number): number => {
        const j = Math.floor(num / n);
        const i = num % n;
        return matrix[j][i];
    }

    const BS = (l: number, r: number): boolean => {
        if (l > r) return false;
        const mid = Math.floor((l+r)/2);
        if (getVal(mid) === target) return true;
        if (getVal(mid) < target) {
            return BS(mid+1, r);
        } else {
            return BS(l, mid -1);
        }
    }
    return BS(0, m*n-1);
};
```

### Search a 2D Matrix II

Skip. From right top corner and to left and to bottom, do zig-zag.