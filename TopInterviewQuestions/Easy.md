<https://leetcode.com/explore/featured/card/top-interview-questions-easy>

- [Array](#array)
  - [Remove Duplicates from Sorted Array](#remove-duplicates-from-sorted-array)
  - [Best Time to Buy and Sell Stock II](#best-time-to-buy-and-sell-stock-ii)
  - [Rotate Array](#rotate-array)
  - [Contains Duplicate](#contains-duplicate)
  - [Single Number](#single-number)
  - [Intersection of Two Arrays II](#intersection-of-two-arrays-ii)
  - [Plus One](#plus-one)
  - [Move Zeroes](#move-zeroes)
  - [Two Sum](#two-sum)
  - [Valid Sudoku](#valid-sudoku)
  - [Rotate Image](#rotate-image)
- [Strings](#strings)
  - [Reverse String](#reverse-string)
  - [Reverse Integer](#reverse-integer)
  - [First Unique Character in a String](#first-unique-character-in-a-string)
  - [Valid Anagram](#valid-anagram)
  - [Valid Palindrome](#valid-palindrome)
  - [String to Integer (atoi)](#string-to-integer-atoi)
  - [Implement strStr()](#implement-strstr)
  - [Count and Say](#count-and-say)
  - [Longest Common Prefix](#longest-common-prefix)
- [Linked List](#linked-list)
  - [Delete Node in a Linked List](#delete-node-in-a-linked-list)
  - [Remove Nth Node From End of List](#remove-nth-node-from-end-of-list)
  - [Reverse Linked List](#reverse-linked-list)
  - [Merge Two Sorted Lists](#merge-two-sorted-lists)
  - [Palindrome Linked List](#palindrome-linked-list)
  - [Linked List Cycle](#linked-list-cycle)
- [Trees](#trees)
  - [Maximum Depth of Binary Tree](#maximum-depth-of-binary-tree)
  - [Validate Binary Search Tree](#validate-binary-search-tree)
  - [Symmetric Tree](#symmetric-tree)
  - [Binary Tree Level Order Traversal](#binary-tree-level-order-traversal)
  - [Convert Sorted Array to Binary Search Tree](#convert-sorted-array-to-binary-search-tree)
- [Sorting and Searching](#sorting-and-searching)
  - [Merge Sorted Array](#merge-sorted-array)
  - [First Bad Version](#first-bad-version)
- [Dynamic Programming](#dynamic-programming)
  - [Climbing Stairs](#climbing-stairs)
  - [Best Time to Buy and Sell Stock](#best-time-to-buy-and-sell-stock)
  - [Maximum Subarray](#maximum-subarray)
  - [House Robber](#house-robber)
- [Design](#design)
  - [Shuffle an Array](#shuffle-an-array)
  - [Min Stack](#min-stack)
- [Math](#math)
  - [Fizz Buzz](#fizz-buzz)
  - [Count Primes](#count-primes)
  - [Power of Three](#power-of-three)
  - [Roman to Integer](#roman-to-integer)
- [Others](#others)
  - [Number of 1 Bits](#number-of-1-bits)
  - [Hamming Distance](#hamming-distance)
  - [Reverse Bits](#reverse-bits)
  - [Pascal's Triangle](#pascals-triangle)
  - [Valid Parentheses](#valid-parentheses)
  - [Missing Number](#missing-number)

## Array

### Remove Duplicates from Sorted Array

> Given a sorted array nums, remove the duplicates in-place such that each element appears only once and returns the new length.  
Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.  

Solution: Two indexes, one for next element (unidentified), one for identified independent elements' length.

```typescript
function removeDuplicates(nums: number[]): number {
    let identifiedCount = 0;

    for (let next = 0; next < nums.length; next ++) {
        if (identifiedCount === 0) {
            identifiedCount++;
            continue;
        }
        if (nums[next] === nums[identifiedCount - 1]) {
            continue;
        } else {
            nums[identifiedCount] = nums[next];
            identifiedCount++;
        }
    }

    return identifiedCount;
};
```

### Best Time to Buy and Sell Stock II

> Say you have an array prices for which the ith element is the price of a given stock on day i.  
Design an algorithm to find the maximum profit. You may complete as many transactions as you like (i.e., buy one and sell one share of the stock multiple times).  
Note: You may not engage in multiple transactions at the same time (i.e., you must sell the stock before you buy again).

```typescript
function maxProfit(prices: number[]): number {
    let profit = 0;
    let currentInvestment = prices[0];

    for (let i = 0; i < prices.length; i++) {
        if (prices[i] > currentInvestment) {
            profit += prices[i] - currentInvestment;
            currentInvestment = prices[i];
        } else {
            currentInvestment = prices[i];
        }
    }
    return profit;
};
```

### Rotate Array

> Given an array, rotate the array to the right by k steps, where k is non-negative.  
Follow up:  
Try to come up as many solutions as you can, there are at least 3 different ways to solve this problem.  
Could you do it in-place with O(1) extra space?  

Solution with hint: reverse

```typescript
function rotate(nums: number[], k: number): void {
    const reversePartition = (l: number, r: number): void => {
        while (l < r) {
            const temp = nums[l];
            nums[l] = nums[r];
            nums[r] = temp;
            l++;
            r--;
        }
    }

    nums.reverse();
    const _k = k % nums.length;
    reversePartition(0, _k - 1);
    reversePartition(_k, nums.length - 1);
};
```

### Contains Duplicate

> Given an array of integers, find if the array contains any duplicates.  
Your function should return true if any value appears at least twice in  the array, and it should return false if every element is distinct.  

```typescript
function containsDuplicate(nums: number[]): boolean {
    return new Set(nums).size !== nums.length;
};
```

### Single Number

> Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.  
Follow up: Could you implement a solution with a linear runtime  complexity and without using extra memory?  

```typescript
function singleNumber(nums: number[]): number {
    let result = 0;
    for (let i = 0; i < nums.length; i++) {
        result = result ^ nums[i];
    }
    return result;
};
```

### Intersection of Two Arrays II

> Given two arrays, write a function to compute their intersection.  
Note:  
Each element in the result should appear as many times as it shows in both arrays.  
The result can be in any order.  
Follow up:  
What if the given array is already sorted? How would you optimize your algorithm?  
What if nums1's size is small compared to nums2's size? Which algorithm is better?  
What if elements of nums2 are stored on disk, and the memory is limited such that you cannot load all elements into the memory at once?  

Solution: Solution to the common case is given below. If the given array is sorted, then simply convert it to a Map with <value, count>, merge two maps but the count uses the lesser one's but > 0, and convert the result to an array.

```typescript
function intersect(nums1: number[], nums2: number[]): number[] {
    const _nums1 = nums1.length < nums2.length ? nums1 : nums2;
    const _nums2 = nums1.length < nums2.length ? nums2 : nums1;

    const map = new Map<number, number>();
    for (let i = 0; i < _nums1.length; i++) {
        if (map.has(_nums1[i])) {
            map.set(_nums1[i], map.get(_nums1[i]) + 1);
        } else {
            map.set(_nums1[i], 1);
        }
    }
    
    const result = [];
    for (let i = 0; i < _nums2.length; i++) {
        if (map.has(_nums2[i])) {
            result.push(_nums2[i]);
            if (map.get(_nums2[i]) === 1) {
                map.delete(_nums2[i])
            } else {
                map.set(_nums2[i], map.get(_nums2[i]) - 1);
            }
        }
    }

    return result;
};
```

### Plus One

> Given a non-empty array of decimal digits representing a non-negative integer, increment one to the integer.

The digits are stored such that the most significant digit is at the head of the list, and each element in the array contains a single digit.

You may assume the integer does not contain any leading zero, except the number 0 itself.

```typescript
// typescript
function plusOne(digits: number[]): number[] {
    if (digits[digits.length - 1] !== 9) {
        digits[digits.length - 1] ++;
        return digits;
    }

    let non9Index = -1;

    // this for and fill could be executed in one pass
    for (let i = digits.length - 1; i >= 0; i--) {
        if (digits[i] !== 9) {
            non9Index = i;
            break;
        }
    }

    if (non9Index === -1) {
        digits.fill(0);
        digits[0] = 1;
        digits.push(0);
    } else {
        digits.fill(0, non9Index + 1);
        digits[non9Index] ++;
    }
    return digits;
};
```

### Move Zeroes

> Given an array nums, write a function to move all 0's to the end of it while maintaining the relative order of the non-zero elements.

```typescript
// typescript
function moveZeroes(nums: number[]): void {
    for (let searchIndex = 0, homeIndex = -1; searchIndex < nums.length; searchIndex++) {
        if (homeIndex === -1 && nums[searchIndex] === 0) {
            homeIndex = searchIndex;
            continue;
        }

        if (nums[searchIndex] === 0) {
            continue;
        }

        if (homeIndex !== -1) {
            nums[homeIndex] = nums[searchIndex];
            nums[searchIndex] = 0;
            homeIndex++;
        }
    }
};
```

### Two Sum

> Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.  
You may assume that each input would have exactly one solution, and you may not use the same element twice.  
You can return the answer in any order.  

Hint: search, not add and compare.

```typescript
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

### Valid Sudoku

> Determine if a 9 x 9 Sudoku board is valid. Only the filled cells need to be validated according to the following rules:  
Each row must contain the digits 1-9 without repetition.  
Each column must contain the digits 1-9 without repetition.  
Each of the nine 3 x 3 sub-boxes of the grid must contain the digits 1-9 without repetition.  
Note:  
A Sudoku board (partially filled) could be valid but is not necessarily solvable.  
Only the filled cells need to be validated according to the mentioned rules.  

My response: the official solution of this question looks boring to me.

```typescript
// typescript
// Leetcode thinks this is wrong
// Failed test case:
// Input:
// [["8",".","3",".",".",".",".",".","."],[".",".",".",".",".",".",".","2","."],[".","1",".",".",".",".",".","7","."],["1",".",".",".",".",".",".",".","3"],[".",".",".",".",".","2",".",".","."],[".",".",".",".",".","3",".",".","."],[".",".",".",".","6",".",".",".","."],["9",".",".",".",".",".","6",".","."],[".",".","1",".",".","4",".",".","."]]
// Output:
// false
// Expected:
// true
// But my compiler returned true with this input.
function isValidSudoku(board: string[][]): boolean {
    for (let i = 0; i < 9; i++) {
        if (!isValid(...board[i])) {
            return false;
        }
        if (!isValid(
            board[0][i], board[1][i], board[2][i],
            board[3][i], board[4][i], board[5][i],
            board[6][i], board[7][i], board[8][i]
        )) {
            return false;
        }
        const a = Math.floor(i / 3) * 3;
        const b = i % 3 * 3;
        if (!isValid(
            board[0 + b][0 + a], board[0 + b][1 + a], board[0 + b][2 + a], 
            board[1 + b][0 + a], board[1 + b][1 + a], board[1 + b][2 + a], 
            board[2 + b][0 + a], board[2 + b][1 + a], board[2 + b][2 + a],
        )) {
            return false;
        }
    }
    return true;
};

const set = new Set<number>();

function isValid(...items: string[]): boolean {
    for (let i = 0; i < items.length; i++) {
        if (items[i][0] === '.') {
            continue;
        }
        const current = Number(items[i][0]);
        if (set.has(current)) {
            return false;
        } else {
            set.add(current)
        }
    }
    set.clear();
    return true;
}

```

### Rotate Image

> You are given an n x n 2D matrix representing an image, rotate the image by 90 degrees (clockwise).  
You have to rotate the image in-place, which means you have to modify the input 2D matrix directly. DO NOT allocate another 2D matrix and do the rotation.  

Solution: flip twice

```typescript
// typescript
function rotate(matrix: number[][]): void {
    const k = matrix.length;

    // flip along diagonal
    for (let i = 0; i < k; i++) {
        for (let j = i; j < k; j++) {
            const temp = matrix[i][j];
            matrix[i][j] = matrix[j][i];
            matrix[j][i] = temp;
        }
    }

    // flip vertically
    for (let i = 0; i < k / 2; i++) {
        for (let j = 0; j < k; j++) {
            const temp = matrix[j][i];
            matrix[j][i] = matrix[j][k - 1 - i];
            matrix[j][k - 1 - i] = temp;
        }
    }
};
```

## Strings

### Reverse String

> Write a function that reverses a string. The input string is given as an array of characters char[].  
Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.  
You may assume all the characters consist of printable ascii characters.  

Solution: the idea is to swap end to end.

```typescript
// typescript
function reverseString(s: string[]): void {
    // using built in function
    s.reverse();
};
```

### Reverse Integer

> Given a signed 32-bit integer x, return x with its digits reversed. If reversing x causes the value to go outside the signed 32-bit integer range [-231, 231 - 1], then return 0.  
Assume the environment does not allow you to store 64-bit integers (signed or unsigned).  

```typescript
// typescript
function reverse(x: number): number {
    let str = [...x.toString(10)];
    const isMinus = str[0] === '-';
    if (isMinus) {
        str.shift();
    }
    // if the system is 32-bit integer max, use overflow method watching its sign's change
    // since js is not and reproducing overflow is complicated, I'll go with mathematic comparison

    let sum = 0;
    for (let i = 0; i < str.length; i++) {
        sum += Number(str[i]) * Math.pow(10, i);
    }
    if (isMinus) {
        sum *= -1;
    }

    if (sum > Math.pow(2, 31) - 1 || sum < -Math.pow(2, 31)) {
        sum = 0;
    }
    return sum;
};
```

### First Unique Character in a String

> Given a string, find the first non-repeating character in it and return its index. If it doesn't exist, return -1.  
Note: You may assume the string contains only lowercase English letters.  

```typescript
// typescript
// array
interface Bundle {
    char: string;
    index: number;
    count: number;
}

function firstUniqChar(s: string): number {
    const arr = new Array<Bundle>();
    for (let i = 0; i < s.length; i++) {
        const index = arr.findIndex(a => a.char === s[i]);
        if (index === -1) {
            arr.push({
                char: s[i],
                index: i,
                count: 1
            });
        } else {
            arr[index].count++;
        }
    }

    for (let i = 0; i < arr.length; i++) {
        if (arr[i].count === 1) {
            return arr[i].index;
        }
    }
    return -1;
};

// map: better read performance
interface Bundle {
    index: number;
    count: number;
}

function firstUniqChar(s: string): number {
    const map = new Map<string, Bundle>();
    for (let i = 0; i < s.length; i++) {
        if (map.has(s[i])) {
            map.get(s[i]).count++;
        } else {
            map.set(s[i], {index: i, count: 1})
        }
    }

    let index = -1;
    for (let item of map.values()) {
        if (item.count === 1) {
            if (index === -1 || index > item.index) {
                index = item.index;
            }
        }
    }
    return index;
};
```

### Valid Anagram

> Given two strings s and t , write a function to determine if t is an anagram of s.  
Note: You may assume the string contains only lowercase alphabets.  
Follow up: What if the inputs contain unicode characters? How would you adapt your solution to such case?  

```typescript
// typescript
function isAnagram(s: string, t: string): boolean {
    const map = new Map<string, number>();
    for (let i = 0; i < s.length; i++) {
        const c = s[i];
        if (map.has(c)) {
            const count = map.get(c);
            map.set(c, count + 1);
        } else {
            map.set(c, 1);
        }
    }

    for (let i = 0; i < t.length; i++) {
        const c = t[i];
        if (!map.has(c)) {
            return false;
        } else {
            const count = map.get(c);
            if (count === 1) {
                map.delete(c);
            } else {
                map.set(c, count - 1);
            }
        }
    }

    return map.size === 0;
};
```

### Valid Palindrome

> Given a string s, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.

```typescript
// typescript
const aCode = 'a'.charCodeAt(0);
const zCode = 'z'.charCodeAt(0);
const ACode = 'A'.charCodeAt(0);
const ZCode = 'Z'.charCodeAt(0);
const _0Code = '0'.charCodeAt(0);
const _9Code = '9'.charCodeAt(0);

function getId(charCode: number): number {
    if (charCode >= aCode && charCode <= zCode) {
        return charCode - aCode;
    }
    if (charCode >= ACode && charCode <= ZCode) {
        return charCode - ACode;
    }
    if (charCode >= _0Code && charCode <= _9Code) {
        return charCode - _0Code + 30;
    }
    return -1;
}

function isPalindrome(s: string): boolean {
    let a = 0;
    let b = s.length - 1;
    while (a < b) {
        const charCodeA = s.charCodeAt(a);
        const charCodeB = s.charCodeAt(b);

        const idA = getId(charCodeA);
        const idB = getId(charCodeB);

        if (idA === -1 || idB === -1) {
            if (idA === -1) {
                a++;
            }
            if (idB === -1) {
                b--;
            }
            continue;
        }

        if (idA !== idB) {
            return false;
        } else {
            a++;
            b--;
        }
    }
    return true;
};
```

### String to Integer (atoi)

> Implement the myAtoi(string s) function, which converts a string to a 32-bit signed integer (similar to C/C++'s atoi function).  
The algorithm for myAtoi(string s) is as follows:  
Read in and ignore any leading whitespace.  
Check if the next character (if not already at the end of the string) is '-' or '+'. Read this character in if it is either. This determines if the final result is negative or positive respectively. Assume the result is positive if neither is present.  
Read in next the characters until the next non-digit charcter or the end of the input is reached. The rest of the string is ignored.
Convert these digits into an integer (i.e. "123" -> 123, "0032" -> 32). If no digits were read, then the integer is 0. Change the sign as necessary (from step 2).  
If the integer is out of the 32-bit signed integer range [-231, 231 - 1], then clamp the integer so that it remains in the range. Specifically, integers less than -231 should be clamped to -231, and integers greater than 231 - 1 should be clamped to 231 - 1.  
Return the integer as the final result.  
Note:  
Only the space character ' ' is considered a whitespace character.  
Do not ignore any characters other than the leading whitespace or the rest of the string after the digits.  

```typescript
// typescript
const _0CharCode = '0'.charCodeAt(0);

function myAtoi(s: string): number {
    let result = 0;

    let i;
    let positive = true;

    for (i = 0; i < s.length; i++) {
        const current = s[i];
        if (current === ' ') continue;
        if (current === '+' || current === '-') {
            i++;
            positive = current === '+';
            break;
        } else if (current >= '0' && current <= '9') {
            break;
        }
        return result;
    }

    for (; i < s.length; i++) {
        const current = s[i];
        if (current >= '0' && current <= '9') {
            result *= 10;
            result += current.charCodeAt(0) - _0CharCode;
        } else {
            break;
        }
    }

    result *= positive ? 1 : -1;

    if (result > Math.pow(2, 31) - 1) {
        result = Math.pow(2, 31) - 1
    }
    if (result < -Math.pow(2, 31)) {
        result = -Math.pow(2, 31)
    }
    return result;
};
```

### Implement strStr()

> Implement strStr().  
Return the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.  
Clarification:  
What should we return when needle is an empty string? This is a great question to ask during an interview.  
For the purpose of this problem, we will return 0 when needle is an empty string. This is consistent to C's strstr() and Java's indexOf().  

```typescript
// typescript
function strStr(haystack: string, needle: string): number {
    if (needle.length === 0) {
        return 0;
    }
    for (let i = 0; i < haystack.length; i++) {
        let found = true;
        for (let j = 0; j < needle.length; j++) {
            if (i + j >= haystack.length) {
                return -1;
            }
            if (haystack[i + j] !== needle[j]) {
                found = false;
                break;
            }
        }
        if (found) {
            return i;
        }
    }
    return -1;
};
```

### Count and Say

> The count-and-say sequence is a sequence of digit strings defined by the recursive formula:  
countAndSay(1) = "1"  
countAndSay(n) is the way you would "say" the digit string from countAndSay(n-1), which is then converted into a different digit string.  
To determine how you "say" a digit string, split it into the minimal number of groups so that each group is a contiguous section all of the same character. Then for each group, say the number of characters, then say the character. To convert the saying into a digit string, replace the counts with a number and concatenate every saying.  
Given a positive integer n, return the nth term of the count-and-say sequence.

```typescript
// typescript
function _countAndSay(n: string[]): string[] {
    let result = Array<string>();
    let current;
    let count = 0;
    for (let i = 0; i < n.length; i++) {
        if (current === undefined) {
            current = n[i];
            count = 1;
        } else if (current === n[i]) {
            count++;
        } else {
            result.push(count.toString());
            result.push(current);
            current = n[i];
            count = 1;
        }
    }
    result.push(count.toString());
    result.push(current);
    return result;
}

function countAndSay(n: number): string {
    let arr = ['1'];
    for (let i = 0; i < n - 1; i++) {
        arr = _countAndSay(arr);
    }
    return arr.join('');
};
```

### Longest Common Prefix

> Write a function to find the longest common prefix string amongst an array of strings.  
If there is no common prefix, return an empty string "".  

Solution: a better solution is adapting binary search.

```typescript
// typescript
function longestCommonPrefix(strs: string[]): string {
    if (strs.length === 0) {
        return '';
    }

    let minLength = -1;
    strs.forEach(str => {
        if (minLength === -1) {
            minLength = str.length;
        } else if (minLength > str.length) {
            minLength = str.length;
        }
    })

    let i = 0;
    for (; i < minLength; i++) {
        const item = strs[0][i];
        let allEqual = true;
        for (let j = 1; j < strs.length; j++) {
            if (strs[j][i] !== item) {
                allEqual = false;
                break;
            }
        }
        if (!allEqual) {
            break;
        }
    }

    return strs[0].substring(0, i);
};
```

## Linked List

```typescript
class ListNode {
    val: number
    next: ListNode | null
    constructor(val?: number, next?: ListNode | null) {
        this.val = (val===undefined ? 0 : val)
        this.next = (next===undefined ? null : next)
    }
}


function fromArray(nums: number[]): ListNode | null {
    let node = null;
    while (nums.length > 0) {
        if (node === null) {
            node = new ListNode(nums.pop());
        } else {
            node = new ListNode(nums.pop(), node);
        }
    }
    return node;
}
```

### Delete Node in a Linked List

> Write a function to delete a node in a singly-linked list. You will not be given access to the head of the list, instead you will be given access to the node to be deleted directly.  
It is guaranteed that the node to be deleted is not a tail node in the list.  

```ts
function deleteNode(root: ListNode | null): void {
    const next = root.next;
    const nextNext = next.next;
    root.val = next.val;
    root.next = nextNext;
};
```

### Remove Nth Node From End of List

> Given the head of a linked list, remove the nth node from the end of the list and return its head.  
Follow up: Could you do this in one pass?  

Comments: two passes is easy. The official one pass solution with two pointer is refreshing at glance, but its time consuming is same to the two pass solution. Not convincing.

### Reverse Linked List

> Given the head of a singly linked list, reverse the list, and return the reversed list. 

```typescript
function reverseList(head: ListNode | null): ListNode | null {
    if (!head) {
        return head;
    }
    let pA: ListNode | null = null;
    let pB: ListNode | null = head;

    while (pB.next) {
        const pC = pB.next;
        pB.next = pA;
        pA = pB;
        pB = pC;
    }
    pB.next = pA;

    return pB;
};
```

### Merge Two Sorted Lists

> Merge two sorted linked lists and return it as a sorted list. The list should be made by splicing together the nodes of the first two lists.

```typescript
// typescript
function mergeTwoLists(l1: ListNode | null, l2: ListNode | null): ListNode | null {
    if (l1 === null && l2 === null) return null;
    if (l1 === null) return l2;
    if (l2 === null) return l1;

    const result: ListNode | null = new ListNode();
    let pt = result;

    while (l1 || l2) {
        if (l1 === null) {
            pt.next = l2;
            break;
        }
        if (l2 === null) {
            pt.next = l1;
            break;
        }

        if (l1.val <= l2.val) {
            pt.next = l1;
            l1 = l1.next;
        } else {
            pt.next = l2;
            l2 = l2.next;
        }
        pt = pt.next;
    }


    return result.next;
};
```

### Palindrome Linked List

> Given a singly linked list, determine if it is a palindrome.  
Follow up:  
Could you do it in O(n) time and O(1) space?

Solution: fast | slow pointers.

```typescript
// typescript
function isEqual(l1: ListNode | null, l2: ListNode | null): boolean {
    while (true) {
        if (l1 === null && l2 === null) {
            return true;
        } else {
            if (l1 === null || l2 === null) {
                return false;
            } else if (l1.val !== l2.val) {
                return false;
            } else {
                l1 = l1.next;
                l2 = l2.next;
            }
        }
    }
}

function isPalindrome(head: ListNode | null): boolean {
    if (!head || !head.next) {
        return true;
    }

    let pFast = head.next;
    let pA = null;
    let pB = head; // pSlow
    let pC = head.next;

    let pMidL = null;
    let pMidR = null;

    while (true) {
        if (pFast.next && pFast.next.next) {
            pFast = pFast.next.next;

            pB.next = pA;
            pA = pB;
            pB = pC;
            pC = pC.next;
        } else if (pFast.next) {
            pMidL = pB;
            pMidR = pC.next;
            break;
        } else {
            pMidL = pB;
            pMidR = pC;
            break;
        }
    }
    pB.next = pA;

    return isEqual(pMidL, pMidR);
};
```

### Linked List Cycle

> Given head, the head of a linked list, determine if the linked list has a cycle in it.  
There is a cycle in a linked list if there is some node in the list that can be reached again by continuously following the next pointer. Internally, pos is used to denote the index of the node that tail's next pointer is connected to. Note that pos is not passed as a parameter.  
Return true if there is a cycle in the linked list. Otherwise, return false.  
Follow up: Can you solve it using O(1) (i.e. constant) memory?

Solution: fast | slow pointers.

```typescript
// typescript
function hasCycle(head: ListNode | null): boolean {
    if (!head || !head.next) {
        return false;
    }

    let pFast = head.next;
    let pSlow = head;

    while (true) {
        if (pFast.next && pFast.next.next) {
            pFast = pFast.next.next;
            pSlow = pSlow.next;
            if (pFast === pSlow) {
                return true;
            }
        } else {
            return false;
        }
    }
};
```

## Trees

```typescript
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

### Maximum Depth of Binary Tree

> Given the root of a binary tree, return its maximum depth.  
A binary tree's maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.

```typescript
// typescript
function maxDepth(root: TreeNode | null): number {
    if (root === null) {
        return 0;
    }
    return Math.max(maxDepth(root.left), maxDepth(root.right)) + 1;
};
```

### Validate Binary Search Tree

> Given the root of a binary tree, determine if it is a valid binary search tree (BST).  
A valid BST is defined as follows:  
The left subtree of a node contains only nodes with keys less than the node's key.  
The right subtree of a node contains only nodes with keys greater than the node's key.  
Both the left and right subtrees must also be binary search trees.  

```typescript
// typescript
function concatBST(root: TreeNode | null): Array<number> {
    if (root === null) return [];
    const left = concatBST(root.left);
    const right = concatBST(root.right);
    return [...left, root.val, ...right];
}

function isValidBST(root: TreeNode | null): boolean {
    const arr = concatBST(root);
    for (let i = 0; i < arr.length - 1; i++) {
        if (arr[i] >= arr[i + 1]) {
            return false;
        }
    }
    return true;
};
```

### Symmetric Tree

> Given the root of a binary tree, check whether it is a mirror of itself (i.e., symmetric around its center). 

```typescript
// typescript
function _IsSymmetric(left: TreeNode | null, right: TreeNode | null): boolean {
    if (left === null && right === null) return true;
    if (left !== right && (left === null || right === null)) return false;
    if (left.val !== right.val) {
        return false;
    }
    return _IsSymmetric(left.left, right.right) && _IsSymmetric(left.right, right.left);
}

function isSymmetric(root: TreeNode | null): boolean {
    if (root === null) return true;
    return _IsSymmetric(root.left, root.right);
};
```

### Binary Tree Level Order Traversal

> Given the root of a binary tree, return the level order traversal of its nodes' values. (i.e., from left to right, level by level).

```typescript
// typescript
function levelOrder(root: TreeNode | null): number[][] {
    const map = new Map<number, number[]>();
    const traverse = (node: TreeNode | null, depth: number = 0) => {
        if (!map.has(depth)) {
            map.set(depth, []);
        }
        if (node) {
            map.get(depth).push(node.val);
            traverse(node.left, depth + 1);
            traverse(node.right, depth + 1);
        }
    }

    traverse(root, 0);

    const result = [];
    for (let i = 0; i < map.size; i++) {
        const item = map.get(i);
        if (item.length > 0) {
            result.push(item);
        }
    }
    return result;
};
```

### Convert Sorted Array to Binary Search Tree

> Given an integer array nums where the elements are sorted in ascending order, convert it to a height-balanced binary search tree.  
A height-balanced binary tree is a binary tree in which the depth of the two subtrees of every node never differs by more than one.

```typescript
// typescript
function sortedArrayToBST(nums: number[]): TreeNode | null {
    if (nums.length === 0) return null;
    if (nums.length === 1) return new TreeNode(nums[0]);
    const halfIndex = Math.floor(nums.length / 2);
    // slice is time consuming, use two indexes instead
    const leftHalf = nums.slice(0, halfIndex);
    const rightHalf = nums.slice(halfIndex + 1, nums.length);
    const leftNode = sortedArrayToBST(leftHalf);
    const rightNode = sortedArrayToBST(rightHalf);
    return new TreeNode(nums[halfIndex], leftNode, rightNode);
};
```

## Sorting and Searching

### Merge Sorted Array

> Given two sorted integer arrays nums1 and nums2, merge nums2 into nums1 as one sorted array.  
The number of elements initialized in nums1 and nums2 are m and n respectively. You may assume that nums1 has a size equal to m + n such that it has enough space to hold additional elements from nums2.

```typescript
// typescript
function merge(nums1: number[], m: number, nums2: number[], n: number): void {
    let i1 = m - 1;
    let i2 = n - 1;
    let i3 = m + n - 1;

    while (i1 >= 0 && i2 >= 0) {
        // changing >= to >, improved speed a lot
        if (nums2[i2] > nums1[i1]) {
            nums1[i3] = nums2[i2];
            i2--;
        } else {
            nums1[i3] = nums1[i1];
            i1--;
        }
        i3--;
    }

    while (i2 >= 0) {
        nums1[i3] = nums2[i2];
        i2--;
        i3--;
    }
};
```

### First Bad Version

> You are a product manager and currently leading a team to develop a new product. Unfortunately, the latest version of your product fails the quality check. Since each version is developed based on the previous version, all the versions after a bad version are also bad.  
Suppose you have n versions [1, 2, ..., n] and you want to find out the first bad one, which causes all the following ones to be bad.  
You are given an API bool isBadVersion(version) which returns whether version is bad. Implement a function to find the first bad version. You should minimize the number of calls to the API.  

Solution: binary search.

```typescript
// typescript
const solution = (isBadVersion: (version: number) => boolean) => {
    const binarySearch = (n: number, start: number, end: number) => {
        if (end === 1) return 1;
        const center = Math.floor((start + end) / 2);
        if (isBadVersion(center) && !isBadVersion(center - 1)) {
            return center;
        } else {
            if (isBadVersion(center)) {
                return binarySearch(n, start, center - 1);
            } else {
                return binarySearch(n, center + 1, end);
            }
        }
    }

    return (n: number): number => {
        return binarySearch(n, 1, n);
    };
};
```

## Dynamic Programming

### Climbing Stairs

> You are climbing a staircase. It takes n steps to reach the top.  
Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?

```typescript
// typescript
// mathematic solution
function climbStairs(n: number): number {
    const max2s = Math.floor(n / 2);

    let result = 0;

    for (let i = 0; i <= max2s; i++) {
        const ones = n - 2 * i;
        const twos = i;
        const count = ones + twos;

        let val = 1;

        for (let j = 1; j <= Math.min(ones, twos); j++) {
            val *= count - j + 1;
            val /= j;
        }

        result += val;
    }
    return result;
};
```

### Best Time to Buy and Sell Stock

> You are given an array prices where prices[i] is the price of a given stock on the ith day.  
You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.  
Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.

```typescript
// typescript
function maxProfit(prices: number[]): number {
    if (prices.length < 2) return 0;

    let bestProfit = 0;
    let lastProfit = 0; // lastProfit is unnecessary

    let lastMinPrice = prices[0];

    for (let i = 1; i < prices.length; i++) {
        const currentPrice = prices[i];
        const currentProfit= currentPrice - lastMinPrice;
        if (currentProfit > lastProfit) {
            lastProfit = currentProfit;
            if (lastProfit > bestProfit) {
                bestProfit = lastProfit;
            }
            continue;
        }
        if (currentPrice < lastMinPrice) {
            lastMinPrice = currentPrice;
            lastProfit = 0;
        }
    }
    return bestProfit;
};
// see [Category - Dynamic Programming](Categories/DynamicProgramming.md) for better solution
```

### Maximum Subarray

> Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.

```typescript
// typescript
function maxSubArray(nums: number[]): number {
    let largestSum = -Number.MAX_VALUE;
    let currentSum = 0;

    for (let i = 0; i < nums.length; i++) {
        if (currentSum < 0) {
            currentSum = 0;
        }
        currentSum += nums[i];
        if (largestSum < currentSum) {
            largestSum = currentSum;
        }
    }
    return largestSum;
};
```

### House Robber

> You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security system connected and it will automatically contact the police if two adjacent houses were broken into on the same night.  
Given a list of non-negative integers representing the amount of money of each house, determine the maximum amount of money you can rob tonight without alerting the police.

```typescript
// typescript
// basic idea, but exceeded time limit
function rob(nums: number[]): number {
    const maxProfit = (i: number) => {
        if (i < 0) return 0;
        return Math.max(maxProfit(i - 2) + nums[i], maxProfit(i - 1));
    }

    return maxProfit(nums.length - 1);
};

// rewrite
function rob(nums: number[]): number {
    let maxProfitOdd = 0;
    let maxProfitEven = 0;

    for (let i = 0; i < nums.length; i++) {
        if (i === 0) {
            maxProfitEven = nums[i];
        } else {
            if (i % 2 === 0) {
                maxProfitEven = Math.max(maxProfitEven + nums[i], maxProfitOdd);
            } else {
                maxProfitOdd = Math.max(maxProfitOdd + nums[i], maxProfitEven);
            }
        }
    }

    return Math.max(maxProfitEven, maxProfitOdd);
};
```

## Design

### Shuffle an Array

> Given an integer array nums, design an algorithm to randomly shuffle the array.  
Implement the Solution class:  
Solution(int[] nums) Initializes the object with the integer array nums.  
int[] reset() Resets the array to its original configuration and returns it.  
int[] shuffle() Returns a random shuffling of the array.  

```typescript
// typescript
class Solution {
    private raw: Array<number>;
    constructor(nums: number[]) {
        this.raw = nums.concat();
    }

    reset(): number[] {
        return this.raw.concat();
    }

    shuffle(): number[] {
        const result = new Array<number>(this.raw.length);
        const tempArr = this.raw.concat();
        for (let i = 0, j = tempArr.length; i < result.length; i++, j--) {
            const randomIndex = Math.floor(Math.random() * j);
            result[i] = tempArr[randomIndex];
            tempArr[randomIndex] = tempArr[j - 1];
        }
        return result;
    }
}
```

### Min Stack

> Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.  
push(x) -- Push element x onto stack.  
pop() -- Removes the element on top of the stack.  
top() -- Get the top element.  
getMin() -- Retrieve the minimum element in the stack.  

```typescript
// typescript
// solved after hinted
class MinStack {
    private stack: Array<{val: number, min: number}>;
    constructor() {
        this.stack = [];
    }

    push(x: number): void {
        if (this.stack.length === 0) {
            this.stack.push({val: x, min: x});
        } else {
            this.stack.push({val: x, min: Math.min(this.stack[this.stack.length - 1].min, x)});
        }
    }

    pop(): void {
        this.stack.pop();
    }

    top(): number {
        return this.stack[this.stack.length - 1].val;
    }

    getMin(): number {
        return this.stack[this.stack.length - 1].min;
    }
}
```


## Math

### Fizz Buzz

> Write a program that outputs the string representation of numbers from 1 to n.  
But for multiples of three it should output “Fizz” instead of the number and for the multiples of five output “Buzz”. For numbers which are multiples of both three and five output “FizzBuzz”.

```typescript
// typescript
function fizzBuzz(n: number): string[] {
    const result = new Array<string>();

    for (let i = 1; i <= n; i++) {
        const fizz = i % 3 === 0;
        const buzz = i % 5 === 0;
        if (fizz && buzz) {
            result.push('FizzBuzz');
        } else if (fizz) {
            result.push('Fizz');
        } else if (buzz) {
            result.push('Buzz');
        } else {
            result.push(i.toString());
        }
    }

    return result;
};
```

### Count Primes

> Count the number of prime numbers less than a non-negative number, n.

```typescript
// typescript
function countPrimes(n: number): number {
    if (n < 3) {
        return 0;
    }
    if (n === 3) {
        return 1;
    }
    const primes = [2];

    const isPrime = (num: number) => {
        for (let i = 0; i < primes.length; i++) {
            if (primes[i] * primes[i] > num) {
                break;
            }
            if (num % primes[i] === 0) {
                return false;
            }
        }
        return true;
    }

    for (let i = 3; i < n; i++) {
        const primeFlag = isPrime(i);
        if (primeFlag) {
            primes.push(i);
        }
    }

    return primes.length;
};
```

### Power of Three

> Given an integer n, return true if it is a power of three. Otherwise, return false.  
An integer n is a power of three, if there exists an integer x such that n == 3x.

```typescript
// typescript
function isPowerOfThree(n: number): boolean {
    let t = n;
    if (t <= 0) {
        return false;
    }
    while (t > 1) {
        if (t % 3 !== 0) return false;
        t /= 3;
    }
    return true;
};
```

### Roman to Integer

> <https://leetcode.com/explore/featured/card/top-interview-questions-easy/102/math/878/>

```typescript
// typescript
function romanToInt(s: string): number {
    const nums = new Array<number>();
    for (let i = 0; i < s.length; i++) {
        switch (s[i]) {
            case 'I': nums.push(1); break;
            case 'V': nums.push(5); break;
            case 'X': nums.push(10); break;
            case 'L': nums.push(50); break;
            case 'C': nums.push(100); break;
            case 'D': nums.push(500); break;
            case 'M': nums.push(1000); break;
        }
    }

    let sum = 0;
    for (let i = 0; i < nums.length; i++) {
        if (i + 1 < nums.length) {
            if (nums[i] >= nums[i + 1]) {
                sum += nums[i];
            } else {
                sum -= nums[i];
            }
        } else {
            sum += nums[i];
        }
    }
    return sum;
};
```

## Others

### Number of 1 Bits

> Write a function that takes an unsigned integer and returns the number of '1' bits it has (also known as the Hamming weight).  
Note:  
Note that in some languages such as Java, there is no unsigned integer type. In this case, the input will be given as a signed integer type. It should not affect your implementation, as the integer's internal binary representation is the same, whether it is signed or unsigned.  
In Java, the compiler represents the signed integers using 2's complement notation. Therefore, in Example 3, the input represents the signed integer. -3.  
Follow up: If this function is called many times, how would you optimize it?

Comments: using parallel calculations?

```typescript
// typescript
function hammingWeight(n: number): number {
    let count = 0;
    for (let i = 0; i < 32; i++) {
        if ((n & 1) === 1) {
            count ++;
        }
        n = n >> 1;
    }
    return count;
};
```

### Hamming Distance

> The Hamming distance between two integers is the number of positions at which the corresponding bits are different.  
Given two integers x and y, calculate the Hamming distance.  

```typescript
// typescript
function hammingDistance(x: number, y: number): number {
    const n = x ^ y;
    // use 'hammingWeight' ahead
    return hammingWeight(n);
};
```

### Reverse Bits

> Reverse bits of a given 32 bits unsigned integer.  
Note:  
Note that in some languages such as Java, there is no unsigned integer type. In this case, both input and output will be given as a signed integer type. They should not affect your implementation, as the integer's internal binary representation is the same, whether it is signed or unsigned.  
In Java, the compiler represents the signed integers using 2's complement notation. Therefore, in Example 2 above, the input represents the signed integer -3 and the output represents the signed integer -1073741825.  
Follow up:  
If this function is called many times, how would you optimize it?  

Comments: failed when n = 0b11111111111111111111111111111101, sign flipped.

```typescript
// typescript
function reverseBits(n: number): number {
    let result = 0;
	for (let i = 0; i < 32; i++) {
        const b = n & 1;
        result = (result << 1) + b;
        n = n >> 1;
    }
    return result;
};
```

### Pascal's Triangle

> Given an integer numRows, return the first numRows of Pascal's triangle.  
In Pascal's triangle, each number is the sum of the two numbers directly above it.  

```typescript
// typescript
function generate(numRows: number): number[][] {
    const result: number[][] = [];
    for (let i = 0; i < numRows; i++) {
        if (i === 0) {
            result.push([1]);
            continue;
        }
        const temp: number[] = [1];
        for (let j = 0; j < result[i - 1].length - 1; j++) {
            temp.push(result[i - 1][j] + result[i - 1][j + 1]);
        }
        temp.push(1);
        result.push(temp);
    }
    return result;
};
```

### Valid Parentheses

> Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.  
An input string is valid if:  
Open brackets must be closed by the same type of brackets.  
Open brackets must be closed in the correct order.  

```typescript
// typescript
function isValid(s: string): boolean {
    const stack = Array<string>();

    for (let i = 0; i < s.length; i++) {
        const current = s[i];
        switch (current) {
            case '(':
            case '{':
            case '[': stack.push(current); break;
            case ')':
                if (stack[stack.length - 1] === '(') {
                    stack.pop();
                } else {
                    return false;
                }
                break;
            case '}':
                if (stack[stack.length - 1] === '{') {
                    stack.pop();
                } else {
                    return false;
                }
                break;
            case ']':
                if (stack[stack.length - 1] === '[') {
                    stack.pop();
                } else {
                    return false;
                }
                break;
        }
    };
    return stack.length === 0;
};
```

### Missing Number

> Given an array nums containing n distinct numbers in the range [0, n], return the only number in the range that is missing from the array.  
Follow up: Could you implement a solution using only O(1) extra space complexity and O(n) runtime complexity?  

Comments: seems XOR is much better.

```typescript
// typescript
function missingNumber(nums: number[]): number {
    if (nums.length % 2 === 0) {
        nums.push(nums.length + 1);
    }
    const k = (nums.length + 1) / 2;
    const idealSum = -k;
    let actualSum = 0;
    for (let i = 0; i < nums.length; i++) {
        const current = nums[i];
        if (current % 2 === 0) {
            actualSum += current;
        } else {
            actualSum -= current;
        }
    }
    if (actualSum > idealSum) {
        return actualSum - idealSum;
    } else {
        return idealSum - actualSum;
    }
};
```
