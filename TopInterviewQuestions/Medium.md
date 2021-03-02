<https://leetcode.com/explore/interview/card/top-interview-questions-medium/>

- [Array and Strings](#array-and-strings)
  - [3Sum](#3sum)
  - [Set Matrix Zeroes](#set-matrix-zeroes)
  - [Group Anagrams](#group-anagrams)
  - [Longest Substring Without Repeating Characters](#longest-substring-without-repeating-characters)
  - [Longest Palindromic Substring](#longest-palindromic-substring)
  - [Increasing Triplet Subsequence](#increasing-triplet-subsequence)

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