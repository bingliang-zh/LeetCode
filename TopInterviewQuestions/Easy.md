<https://leetcode.com/explore/featured/card/top-interview-questions-easy>

- [Array](#array)
  - [Remove Duplicates from Sorted Array](#remove-duplicates-from-sorted-array)
  - [Best Time to Buy and Sell Stock II](#best-time-to-buy-and-sell-stock-ii)
  - [Rotate Array](#rotate-array)
  - [Contains Duplicate](#contains-duplicate)
  - [Single Number](#single-number)
  - [Intersection of Two Arrays II](#intersection-of-two-arrays-ii)

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

```typescript
// typescript

```
