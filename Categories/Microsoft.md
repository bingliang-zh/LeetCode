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