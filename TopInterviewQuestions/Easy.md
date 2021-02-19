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