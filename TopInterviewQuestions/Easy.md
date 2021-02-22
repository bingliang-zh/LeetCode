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

## Array

### Remove Duplicates from Sorted Array

> Given a sorted array nums, remove the duplicates in-place such that each element appears only once and returns the new length.  
Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.  

Solution: Two indexes, one for next element (unidentified), one for identified independent elements' length.

```typescript
// typescript
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

    // Optional
    // while (nums.length > identifiedCount) {
    //     nums.pop();
    // }

    return identifiedCount;
};
```

### Best Time to Buy and Sell Stock II

> Say you have an array prices for which the ith element is the price of a given stock on day i.  
Design an algorithm to find the maximum profit. You may complete as many transactions as you like (i.e., buy one and sell one share of the stock multiple times).  
Note: You may not engage in multiple transactions at the same time (i.e., you must sell the stock before you buy again).

```typescript
// typescript
function maxProfit(prices: number[]): number {
    if (prices.length === 1) return 0;

    const extremes: number[] = [prices[0]];

    let lastPrice = prices[0];
    let currentPrice = prices[0];

    for (let next = 1; next < prices.length; next ++) {
        const nextPrice = prices[next];
        const deltaLast = currentPrice - lastPrice;
        const deltaNext = currentPrice - nextPrice;

        if (deltaNext === 0) {
            continue;
        }

        if (deltaLast === 0) {
            currentPrice = nextPrice;
            continue;
        }

        if (deltaLast * deltaNext < 0) {
            // keep trending
            currentPrice = nextPrice;
            continue;
        } else {
            // find an extreme
            extremes.push(currentPrice);
            lastPrice = currentPrice;
            currentPrice = nextPrice;
        }
    }
    // deal with the end of prices
    const end = prices[prices.length - 1];
    if (extremes.length < 2
        || (extremes[extremes.length - 1] - extremes[extremes.length - 2]) * (extremes[extremes.length - 1] - end) > 0) {
        extremes.push(end);
    }

    // all extremes are found, calculate profit
    if (extremes[0] > extremes[1]) {
        extremes.shift();
    }
    if (extremes.length % 2 !== 0) {
        extremes.pop();
    }
    let profit = 0;
    for (let i = 0; i < extremes.length; i += 2) {
        profit += extremes[i + 1] - extremes[i];
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
// typescript
function rotate(nums: number[], _k: number): void {
    const k = _k % nums.length;
    nums.reverse();
    let index0 = 0;
    let index1 = k - 1;
    let temp = 0;
    while (index0 < index1) {
        temp = nums[index0];
        nums[index0] = nums[index1];
        nums[index1] = temp;
        index0 ++;
        index1 --;
    }
    index0 = k;
    index1 = nums.length - 1;
    while (index0 < index1) {
        temp = nums[index0];
        nums[index0] = nums[index1];
        nums[index1] = temp;
        index0 ++;
        index1 --;
    }
};
```

### Contains Duplicate

> Given an array of integers, find if the array contains any duplicates.  
Your function should return true if any value appears at least twice in  the array, and it should return false if every element is distinct.  

```typescript
// typescript
// in place search
function containsDuplicate(nums: number[]): boolean {
    for (let i = 0; i < nums.length; i++) {
        for (let j = 0; j < i; j++) {
            if (nums[i] == nums[j]) {
                return true;
            }
        }
    }
    return false;
};

// use Sort
function containsDuplicate(nums: number[]): boolean {
    nums.sort();
    for (let i = 0; i < nums.length - 1; i++) {
        if (nums[i] === nums[i + 1]) {
            return true;
        }
    }
    return false;
};

// use Set
function containsDuplicate(nums: number[]): boolean {
    const numsSet = new Set<number>();
    for (let i = 0; i < nums.length; i++) {
        const cur = nums[i];
        if (numsSet.has(cur)) {
            return true;
        }
        numsSet.add(cur);
    }
    return false;
};
```

### Single Number

> Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.  
Follow up: Could you implement a solution with a linear runtime  complexity and without using extra memory?  

```typescript
// typescript

// use Set
function singleNumber(nums: number[]): number {
    const numsSet = new Set<number>();

    for (let i = 0; i < nums.length; i++) {
        const current = nums[i];
        if (numsSet.has(current)) {
            numsSet.delete(current);
        } else {
            numsSet.add(current);
        }
    }

    const arr = Array.from(numsSet);
    return arr[0];
};

// use XOR
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
// typescript
function intersect(_nums1: number[], _nums2: number[]): number[] {
    const result = Array<number>();

    const flag = _nums1.length < _nums2.length;

    const nums1 = flag ? _nums1 : _nums2;
    const nums2 = flag ? _nums2 : _nums1;

    while (nums1.length > 0 && nums2.length > 0) {
        const index2 = nums2.indexOf(nums1[0]);
        
        if (index2 > -1) {
            // found
            result.push(nums1[0]);
            if (nums1.length > 1) {
                nums1[0] = nums1.pop();
            } else {
                nums1.pop();
            }
            if (index2 !== nums2.length - 1) {
                nums2[index2] = nums2.pop();
            } else {
                nums2.pop();
            }
        } else {
            if (nums1.length > 1) {
                nums1[0] = nums1.pop();
            } else {
                nums1.pop();
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
// typescript
function twoSum(nums: number[], sum: number): number[] {
    for (let i = 0; i < nums.length; i++) {
        const target = sum - nums[i];
        const targetIndex = nums.indexOf(target, i + 1);
        if (targetIndex > -1) {
            return [i, targetIndex];
        }
    }
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

Comments: stupid question with official solution by copying value inside the node but not deleting the node itself.

### Remove Nth Node From End of List

> Given the head of a linked list, remove the nth node from the end of the list and return its head.  
Follow up: Could you do this in one pass?  

Comments: two passes is easy. The official one pass solution with two pointer is refreshing at glance, but its time consuming is same to the two pass solution. Not convincing.

### Reverse Linked List

> Given the head of a singly linked list, reverse the list, and return the reversed list. 

Comments: finally a good question.

```typescript
// typescript
function reverseList(head: ListNode | null): ListNode | null {
    if (!head || !head.next) {
        return head;
    }
    let pA: ListNode | null = null;
    let pB: ListNode | null = head;
    let pC: ListNode | null = head.next;

    while (pC) {
        pB.next = pA;
        pA = pB;
        pB = pC;
        pC = pC.next;
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
