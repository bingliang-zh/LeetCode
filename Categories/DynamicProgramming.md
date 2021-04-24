- [Easy](#easy)
  - [1025. Divisor Game](#1025-divisor-game)
  - [746. Min Cost Climbing Stairs](#746-min-cost-climbing-stairs)
  - [392. Is Subsequence](#392-is-subsequence)
  - [303. Range Sum Query - Immutable](#303-range-sum-query---immutable)
- [Medium](#medium)
  - [464. Can I Win](#464-can-i-win)

All code written in typescript.

## Easy

### 1025. Divisor Game

Alice and Bob take turns playing a game, with Alice starting first.

Initially, there is a number n on the chalkboard. On each player's turn, that player makes a move consisting of:

Choosing any x with 0 < x < n and n % x == 0.
Replacing the number n on the chalkboard with n - x.
Also, if a player cannot make a move, they lose the game.

Return true if and only if Alice wins the game, assuming both players play optimally.

```typescript
const getDivisors = (num: number): Array<number> => {
    const result: Array<number> = [];
    for (let i = 1; i * i <= num; i++) {
        if (num % i === 0) {
            result.push(i);
        }
    }
    return result;
}

function divisorGame(n: number, cache: Map<number, boolean> = new Map()): boolean {
    if (n === 1) return false;
    if (n === 2) return true;
    if (cache.has(n)) {
        return cache.get(n);
    }

    const divisors = getDivisors(n);

    for (let div of divisors) {
        if (divisorGame(n - div, cache) === false) {
            cache.set(n, true);
            return true;
        }
    }
    cache.set(n, false);
    return false;
};
```

### 746. Min Cost Climbing Stairs

You are given an integer array cost where cost[i] is the cost of ith step on a staircase. Once you pay the cost, you can either climb one or two steps.

You can either start from the step with index 0, or the step with index 1.

Return the minimum cost to reach the top of the floor.

```typescript
function minCostClimbingStairs(cost: number[]): number {
    const totalCost: number[] = new Array(cost.length); // Space complexity can be reduced to O(1)
    totalCost[0] = cost[0];
    totalCost[1] = cost[1];
    for (let i = 2; i < totalCost.length; i++) {
        totalCost[i] = Math.min(totalCost[i - 2], totalCost[i - 1]) + cost[i];
    }
    return Math.min(totalCost[totalCost.length - 1], totalCost[totalCost.length - 2]);
};
```

### 392. Is Subsequence

Given two strings s and t, check if s is a subsequence of t.

A subsequence of a string is a new string that is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (i.e., "ace" is a subsequence of "abcde" while "aec" is not).

```typescript
function isSubsequence(s: string, t: string): boolean {
    let startIndex = 0;

    for (let char of s) {
        let found = false;
        for (let i = startIndex; i < t.length; i++) {
            if (char === t[i]) {
                startIndex = i + 1;
                found = true;
                break;
            }
        }
        if (found === false) {
            return false;
        }
    }
    return true;
};
```

### 303. Range Sum Query - Immutable

Given an integer array nums, find the sum of the elements between indices left and right inclusive, where (left <= right).

Implement the NumArray class:

NumArray(int[] nums) initializes the object with the integer array nums.
int sumRange(int left, int right) returns the sum of the elements of the nums array in the range [left, right] inclusive (i.e., sum(nums[left], nums[left + 1], ... , nums[right])).

```typescript
class NumArray {
    sums = [0];

    constructor(nums: number[]) {
        let lastSum = 0;
        for (let num of nums) {
            lastSum = lastSum + num;
            this.sums.push(lastSum);
        }
    }

    sumRange(left: number, right: number): number {
        return this.sums[right+1] - this.sums[left];
    }
}
```

## Medium

### 464. Can I Win

In the "100 game" two players take turns adding, to a running total, any integer from 1 to 10. The player who first causes the running total to reach or exceed 100 wins.

What if we change the game so that players cannot re-use integers?

For example, two players might take turns drawing from a common pool of numbers from 1 to 15 without replacement until they reach a total >= 100.

Given two integers maxChoosableInteger and desiredTotal, return true if the first player to move can force a win, otherwise, return false. Assume both players play optimally.

```typescript
function canIWin(maxChoosableInteger: number, desiredTotal: number): boolean {
    if (desiredTotal <= maxChoosableInteger) return true;
    if (maxChoosableInteger * (maxChoosableInteger + 1) / 2 < desiredTotal) return false;

    const cacheMap: Map<string, boolean> = new Map; // "1,2,3,4" -> true
    const arrToStr = (nums: number[]): string => {
        const sorted = nums.concat().sort();
        return sorted.join();
    }

    const canIForcedWin = (used: number[], unused: number[], todo: number): boolean => {
        const tag = arrToStr(used);
        if (cacheMap.has(tag)) {
            return cacheMap.get(tag);
        }

        for (let num of unused) {
            if (num >= todo) {
                cacheMap.set(tag, true);
                return true;
            }
        }
        for (let num of unused) {
            const enemyWin = canIForcedWin([...used, num], unused.filter(i => i !== num), todo - num);
            if (!enemyWin) {
                cacheMap.set(tag, true);
                return true;
            }
        }
        cacheMap.set(tag, false);
        return false;
    }

    const unused = [];
    for (let i = 1; i <= maxChoosableInteger; i++) {
        unused.push(i);
    }

    console.log(unused)
    return canIForcedWin([], unused, desiredTotal);
};
```