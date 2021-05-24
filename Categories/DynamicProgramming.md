- [Easy](#easy)
  - [53. Maximum Subarray](#53-maximum-subarray)
  - [70. Climbing Stairs](#70-climbing-stairs)
  - [121. Best Time to Buy and Sell Stock](#121-best-time-to-buy-and-sell-stock)
  - [303. Range Sum Query - Immutable](#303-range-sum-query---immutable)
  - [392. Is Subsequence](#392-is-subsequence)
  - [746. Min Cost Climbing Stairs](#746-min-cost-climbing-stairs)
  - [1025. Divisor Game](#1025-divisor-game)
- [Medium](#medium)
  - [464. Can I Win](#464-can-i-win)
  - [1641. Count Sorted Vowel Strings](#1641-count-sorted-vowel-strings)
  - [1314. Matrix Block Sum](#1314-matrix-block-sum)
  - [1277. Count Square Submatrices with All Ones](#1277-count-square-submatrices-with-all-ones)
  - [338. Counting Bits](#338-counting-bits)
  - [1043. Partition Array for Maximum Sum](#1043-partition-array-for-maximum-sum)
  - [1130. Minimum Cost Tree From Leaf Values](#1130-minimum-cost-tree-from-leaf-values)
  - [877. Stone Game](#877-stone-game)
  - [1140. Stone Game II](#1140-stone-game-ii)
  - [322. Coin Change](#322-coin-change)
- [Hard](#hard)
  - [1335. Minimum Difficulty of a Job Schedule](#1335-minimum-difficulty-of-a-job-schedule)
  - [139. Word Break](#139-word-break)

All code written in typescript.

## Easy

### 53. Maximum Subarray

Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.

```typescript
function maxSubArray(nums: number[]): number {
    // maxSubArray(nums, i) = maxSubArray(nums, i - 1) > 0 ? maxSubArray(nums, i - 1) : 0 + nums[i];
    let max = -Number.MAX_VALUE;
    let currentMax = 0;
    for (let i = 0; i < nums.length; i++) {
        currentMax += nums[i];
        max = Math.max(max, currentMax);
        currentMax = Math.max(currentMax, 0);
    }
    return max;
};
```

### 70. Climbing Stairs

You are climbing a staircase. It takes n steps to reach the top.

Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?

```typescript
// DP
function climbStairs(n: number): number {
    if (n === 1) return 1;
    if (n === 2) return 2;
    let first = 1;
    let second = 2;
    for (let i = 3; i < n; i++) {
        const sum = first + second;
        first = second;
        second = sum;
    }
    return first + second;
};
```

```typescript
// typescript
// math, 计算组合数量
function climbStairs(n: number): number {
    const max2s = Math.floor(n / 2);

    let result = 0;

    for (let i = 0; i <= max2s; i++) {
        // 对每一种x个1，y个2，计算组合数量
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

### 121. Best Time to Buy and Sell Stock

You are given an array prices where prices[i] is the price of a given stock on the ith day.

You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.

Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.

```typescript
function maxProfit(prices: number[]): number {
    let maxProfit = 0;
    let minPrice = Number.MAX_VALUE;

    for (let i = 0; i < prices.length; i++) {
        if (prices[i] < minPrice) {
            minPrice = prices[i];
        } else if (maxProfit < (prices[i] - minPrice)) {
            maxProfit = prices[i] - minPrice;
        }
    }
    return maxProfit;
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

### 392. Is Subsequence

Given two strings s and t, check if s is a subsequence of t.

A subsequence of a string is a new string that is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (i.e., "ace" is a subsequence of "abcde" while "aec" is not).

```typescript
function isSubsequence(s: string, t: string): boolean {
    if (s.length === 0) return true;
    if (s.length > t.length) return false;
    let j = 0;

    for (let i = 0; i < t.length; i++) {
        if (t[i] === s[j]) {
            j++;
            if (j === s.length) {
                return true;
            }
        }
    }

    return false;
};
```

Follow up: If there are lots of incoming s, say s1, s2, ..., sk where k >= 109, and you want to check one by one to see if t has its subsequence. In this scenario, how would you change your code?

```typescript
function isSubsequence(s: string, t: string): boolean {
    const mapT = new Map<string, number[]>(); // character -> indexes

    for (let i = 0; i < t.length; i++) {
        if (mapT.has(t[i])) {
            mapT.get(t[i]).push(i);
        } else {
            mapT.set(t[i], [i]);
        }
    }

    const binarySearchNextIndex = (indexes: number[], min: number, max: number, target: number): number => {
        if (min > max) return -1;
        const mid = Math.floor((min + max) / 2);
        if (mid === 0) {
            return target <= indexes[0] ? indexes[0] : -1;
        }
        if (indexes[mid] >= target && indexes[mid - 1] < target) {
            return indexes[mid];
        } else if (indexes[mid] < target) {
            // find right part
            return binarySearchNextIndex(indexes, mid + 1, max, target);
        } else {
            // find left part
            return binarySearchNextIndex(indexes, min, mid - 1, target);
        }
        
    }

    let currentIndex = 0;
    for (let i = 0; i < s.length; i++) {
        const indexes = mapT.get(s[i]);
        if (!indexes) return false;

        const foundedIndex = binarySearchNextIndex(indexes, 0, indexes.length - 1, currentIndex);
        if (foundedIndex === -1) {
            return false;
        }
        currentIndex = foundedIndex + 1;
    }
    return true;
};
```

### 746. Min Cost Climbing Stairs

You are given an integer array cost where cost[i] is the cost of ith step on a staircase. Once you pay the cost, you can either climb one or two steps.

You can either start from the step with index 0, or the step with index 1.

Return the minimum cost to reach the top of the floor.

```typescript
function minCostClimbingStairs(cost: number[]): number {
    let first = cost[0];
    let second = cost[1];
    for (let i = 2; i < cost.length; i++) {
        const newValue = Math.min(first, second) + cost[i];
        first = second;
        second = newValue;
    }
    return Math.min(first, second);
};
```

### 1025. Divisor Game

Alice and Bob take turns playing a game, with Alice starting first.

Initially, there is a number n on the chalkboard. On each player's turn, that player makes a move consisting of:

Choosing any x with 0 < x < n and n % x == 0.
Replacing the number n on the chalkboard with n - x.
Also, if a player cannot make a move, they lose the game.

Return true if and only if Alice wins the game, assuming both players play optimally.

```typescript
// solution 1
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

// solution 2
// If Alice get an even number, she always minus 1. So Bob can only get an odd number. Bob will return an even number regardless the number he choose. Alice will finally win.
// If Alice get an odd number, she will return an odd number regardless which number she choose. Bob get an even number. Bob will win. Alice will lose.
function divisorGame(n: number): boolean {
    // return n % 2 === 0; // divisor
    return (n & 1) === 0; // bit operate
};
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

### 1641. Count Sorted Vowel Strings

Given an integer n, return the number of strings of length n that consist only of vowels (a, e, i, o, u) and are lexicographically sorted.

A string s is lexicographically sorted if for all valid i, s[i] is the same as or comes before s[i+1] in the alphabet.

```typescript
function countVowelStrings(n: number): number {
    // f(a, b) = f(a - 1, b) + f(a, b - 1)
    let arr = [2, 3, 4, 5]; // n = 1;
    for (let i = 1; i < n; i++) {
        const [a, b, c, d] = arr;
        arr = [1+a, 1+a+b, 1+a+b+c, 1+a+b+c+d];
    }
    return arr[3];
};
```

### 1314. Matrix Block Sum

Given a m x n matrix mat and an integer k, return a matrix answer where each answer[i][j] is the sum of all elements mat[r][c] for:

i - k <= r <= i + k,
j - k <= c <= j + k, and
(r, c) is a valid position in the matrix.

```ts
function matrixBlockSum(mat: number[][], k: number): number[][] {
    const m = mat.length;
    const n = mat[0].length;

    const sums = new Array<number[]>(m);
    for (let j = 0; j < m; j++) {
        sums[j] = new Array<number>(n);
    }
    sums[0][0] = mat[0][0];
    for (let i = 1; i < n; i++) {
        sums[0][i] = sums[0][i - 1] + mat[0][i];
    }
    for (let j = 1; j < m; j++) {
        sums[j][0] = sums[j - 1][0] + mat[j][0];
        for (let i = 1; i < n; i++) {
            sums[j][i] = mat[j][i] + sums[j][i - 1] + sums[j - 1][i] - sums[j - 1][i - 1];
        }
    }

    const getSum = (i: number, j: number): number => {
        if (i < 0 || j < 0) {
            return 0;
        }
        return sums[Math.min(j, m - 1)][Math.min(i, n - 1)];
    }
    const result = new Array<number[]>(m);
    for (let j = 0; j < m; j++) {
        result[j] = new Array<number>(n);
    }
    for (let j = 0; j < m; j++) {
        for (let i = 0; i < n; i++) {
            const left = i - k - 1;
            const top = j - k - 1;
            const right = i + k;
            const bottom = j + k;
            result[j][i] = getSum(right, bottom) - getSum(left, bottom) - getSum(right, top) + getSum(left, top);
        }
    }

    return result;
};
```

### 1277. Count Square Submatrices with All Ones

Given a m * n matrix of ones and zeros, return how many square submatrices have all ones.

```ts
// first try
// 0111 -> 011 -> 01 -> []
// 1111    011
// 0111
function countSquares(matrix: number[][]): number {
    const m = matrix.length;
    if (m === 0) return 0;
    const n = matrix[0].length;
    if (n === 0) return 0;

    let currentLevelSum = 0;
    
    for (let j = 0; j < m; j++) {
        for (let i = 0; i < n; i++) {
            if (matrix[j][i] === 1) {
                currentLevelSum++;
            }
        }
    }
    if (currentLevelSum === 0) {
        return 0;
    }

    const newMatrix: number[][] = new Array(m - 1);
    for (let j = 0; j < m - 1; j++) {
        newMatrix[j] = new Array(n - 1);
    }

    for (let j = 0; j < m - 1; j++) {
        for (let i = 0; i < n - 1; i++) {
            if (matrix[j][i] * matrix[j + 1][i] * matrix[j][i + 1] * matrix[j+1][i+1] === 1) {
                newMatrix[j][i] = 1;
            } else {
                newMatrix[j][i] = 0;
            }
        }
    }

    return currentLevelSum + countSquares(newMatrix);
};
```

```ts
// implement most votes' solution
// 0111 -> 0111
// 1111    1122
// 0111    0123
function countSquares(mat: number[][]): number {
    let result = 0;
    for (let j = 0; j < mat.length; j++) {
        for (let i = 0; i < mat[0].length; i++) {
            if (mat[j][i] === 1) {
                if (i === 0 || j === 0) {
                    result++;
                } else {
                    mat[j][i] = Math.min(mat[j-1][i-1], mat[j][i-1], mat[j-1][i]) + 1;
                    result += mat[j][i];
                }
            }
        }
    }
    return result;
};
```

### 338. Counting Bits

Given an integer num, return an array of the number of 1's in the binary representation of every number in the range [0, num].

```ts
function countBits(num: number): number[] {
    const result = new Array(num + 1);
    result[0] = 0;
    for (let i = 1; i <= num; i++) {
        result[i] = result[i >> 1] + (i & 1);
    }
    return result;
};
```

### 1043. Partition Array for Maximum Sum

Given an integer array arr, you should partition the array into (contiguous) subarrays of length at most k. After partitioning, each subarray has their values changed to become the maximum value of that subarray.

Return the largest sum of the given array after partitioning.

```ts
function maxSumAfterPartitioning(arr: number[], k: number): number {
    const results: Array<number> = new Array(arr.length); // results[i] 为到 i 为止最大切分结果。

    for (let i = 0; i < arr.length; i++) {
        let curMax = 0;
        let curMaxSum = 0;
        for (let j = 1; j <= k && i + 1 >= j; j++) { // j 表示从右算起共 j 个数字为一个 partition
            curMax = Math.max(arr[i - (j - 1)], curMax);
            curMaxSum = Math.max(curMaxSum, ((i - j >= 0) ? results[i - j] : 0) + curMax * j); // 保证i-j有效
        }
        results[i] = curMaxSum;
    }

    return results[arr.length - 1];
};
```

### 1130. Minimum Cost Tree From Leaf Values

Given an array arr of positive integers, consider all binary trees such that:

Each node has either 0 or 2 children;
The values of arr correspond to the values of each leaf in an in-order traversal of the tree.  (Recall that a node is a leaf if and only if it has 0 children.)
The value of each non-leaf node is equal to the product of the largest leaf value in its left and right subtree respectively.
Among all possible binary trees considered, return the smallest possible sum of the values of each non-leaf node.  It is guaranteed this sum fits into a 32-bit integer.

```ts
// DP
function mctFromLeafValues(arr: number[]): number {
    const dp: number[][] = new Array(arr.length);
    for (let i = 0; i < arr.length; i++) {
        dp[i] = new Array(arr.length).fill(0);
    }
    const max: number[][] = new Array(arr.length);
    for (let i = 0; i < arr.length; i++) {
        max[i] = new Array(arr.length).fill(0);
    }

    const MAX = (i: number, j: number): number => {
        if (i === j) return arr[i];
        if (i > j) return MAX(j, i);
        if (max[i][j] !== 0) return max[i][j];
        const mid = Math.floor((i + j) / 2);
        const result = Math.max(MAX(i, mid), MAX(mid + 1, j));
        max[i][j] = result;
        return result;
    }

    // DP(i, j) => min(DP(i, k) + DP(k+1, j) + Max(arr[i~k]) * Max(arr[(k+1)~j])) where i < k < k+1 < j
    const DP = (i: number, j: number): number => {
        if (i === j) return 0;
        if (i > j) return DP(j, i);
        if (dp[i][j] !== 0) return dp[i][j];
        
        let minCost = Number.MAX_VALUE;
        for (let k = i; k < j; k++) {
            const cost = DP(i, k) + DP(k+1, j) + MAX(i, k) * MAX(k+1, j);
            minCost = Math.min(minCost, cost);
        }
        dp[i][j] = minCost;
        return minCost;
    }

    return DP(0, arr.length - 1);
};
```

[lee215's solutions](https://leetcode.com/problems/minimum-cost-tree-from-leaf-values/discuss/339959/One-Pass-O(N)-Time-and-Space)
```ts
// lee215's solution 1
function mctFromLeafValues(arr: number[]): number {
    let costSum = 0;
    while (arr.length > 1) {
        // find min's index
        let min = arr[0];
        let minIndex = 0;
        for (let i = 1; i < arr.length; i++) {
            if (arr[i] < min) {
                min = arr[i];
                minIndex = i;
            }
        }
        // costSum += min * Min(arr[min - 1], arr[min + 1]) // 注意边界
        const temp = Math.min(
            minIndex === 0 ? Number.MAX_VALUE : arr[minIndex - 1],
            minIndex === (arr.length - 1) ? Number.MAX_VALUE : arr[minIndex + 1]
            )
        costSum += min * temp;
        // remove min
        arr.splice(minIndex, 1);
    }
    return costSum;
};
```
```ts
// lee215's solution 2
function mctFromLeafValues(arr: number[]): number {
    let costSum = 0;
    const stack = [Number.MAX_VALUE];
    for (let i = 0; i < arr.length; i++) {
        while (arr[i] >= stack[stack.length - 1]) {
            const poped = stack.pop();
            costSum += poped * Math.min(stack[stack.length - 1], arr[i]);
        }
        stack.push(arr[i]);
    }
    while (stack.length > 2) {
        costSum += stack.pop() * stack[stack.length - 1];
    }
    return costSum;
};
```

### 877. Stone Game

Alex and Lee play a game with piles of stones.  There are an even number of piles arranged in a row, and each pile has a positive integer number of stones piles[i].

The objective of the game is to end with the most stones.  The total number of stones is odd, so there are no ties.

Alex and Lee take turns, with Alex starting first.  Each turn, a player takes the entire pile of stones from either the beginning or the end of the row.  This continues until there are no more piles left, at which point the person with the most stones wins.

Assuming Alex and Lee play optimally, return True if and only if Alex wins the game.

```ts
// first try
function stoneGame(p: number[]): boolean {
    // f(i, j) => stones sum
    // f(i, i) => p[i]
    // f(i, i+1) => max(p[i], p[i+1])
    // f(i, j) => max(
    //     p[i] + min(f(i+1, j-1), f(i+2, j)),
    //     p[j] + min(f(i+1, j-1), f(i, j-2))
    // )
    const n = p.length;
    const dp: Array<number[]> = new Array(n);
    for (let i = 0; i < n; i++) {
        dp[i] = new Array(n).fill(0);
    }

    const DP = (i: number, j: number): number => {
        if (i === j) return p[i];
        if (i > j) return DP(j, i);
        if (i + 1 === j) return Math.max(p[i], p[j]);

        if (dp[j][i] !== 0) return dp[j][i];
        dp[j][i] = Math.max(
            p[i] + Math.min(DP(i+1, j-1), DP(i+2, j)),
            p[j] + Math.min(DP(i+1, j-1), DP(i, j-2))
        );
        return dp[j][i];
    }

    return DP(0, n - 1) > Math.min(DP(0, n - 2), DP(1, n - 1))
};
```

[lee215's solution](https://leetcode.com/problems/stone-game/discuss/154610/DP-or-Just-return-true)
```ts
// if (sum(p[even]) > sum(p[odd])) pick even, else pick odd
function stoneGame(p: number[]): boolean {
    return true;
};
```

### 1140. Stone Game II

Alice and Bob continue their games with piles of stones.  There are a number of piles arranged in a row, and each pile has a positive integer number of stones piles[i].  The objective of the game is to end with the most stones. 

Alice and Bob take turns, with Alice starting first.  Initially, M = 1.

On each player's turn, that player can take all the stones in the first X remaining piles, where 1 <= X <= 2M.  Then, we set M = max(M, X).

The game continues until all the stones have been taken.

Assuming Alice and Bob play optimally, return the maximum number of stones Alice can get.

```ts
function stoneGameII(p: number[]): number {
    const n = p.length;
    const map: Map<string, number> = new Map; // "i,M" => maxPossibleStoneCount
    const sums = new Array<number>(n); // 从结尾到i（含）的总和

    sums[n - 1] = p[n - 1];
    for (let i = n - 2; i >= 0; i--) {
        sums[i] = p[i] + sums[i + 1];
    }

    const DP = (i: number, M: number) => {
        if ((i + 2 * M) >= n) return sums[i]; // pick all rest piles
        const key = i + ',' + M;
        if (map.has(key)) return map.get(key);
        let max = 0;

        for (let X = 1; X <= 2 * M; X++) {
            const current = sums[i] - DP(i+X, Math.max(M, X)); // Eureka!
            if (current > max) {
                max = current;
            }
        }

        map.set(key, max);
        return max;
    }

    return DP(0, 1);
};
```

### 322. Coin Change

You are given an integer array coins representing coins of different denominations and an integer amount representing a total amount of money.

Return the fewest number of coins that you need to make up that amount. If that amount of money cannot be made up by any combination of the coins, return -1.

You may assume that you have an infinite number of each kind of coin.

```ts
function coinChange(coins: number[], amount: number): number {
    // const dp: Map<number, number> = new Map; // amount -> fewest number of coins
    const dp: Array<number | undefined> = new Array(amount + 1).fill(undefined);

    const DP = (amount: number): number => {
        if (amount < 0) return -1;
        if (amount === 0) return 0;
        if (dp[amount] !== undefined) return dp[amount];

        let min = Number.MAX_VALUE;
        for (let i = 0; i < coins.length; i++) {
            const subDP = DP(amount - coins[i]);
            if (subDP === -1) {
                continue;
            }
            if (subDP < min) {
                min = subDP;
            }
        }
        const subMin = min === Number.MAX_VALUE ? -1 : min + 1;
        dp[amount] = subMin;
        return subMin;
    }

    return DP(amount);
};
```

## Hard

### 1335. Minimum Difficulty of a Job Schedule

You want to schedule a list of jobs in d days. Jobs are dependent (i.e To work on the i-th job, you have to finish all the jobs j where 0 <= j < i).

You have to finish at least one task every day. The difficulty of a job schedule is the sum of difficulties of each day of the d days. The difficulty of a day is the maximum difficulty of a job done in that day.

Given an array of integers jobDifficulty and an integer d. The difficulty of the i-th job is jobDifficulty[i].

Return the minimum difficulty of a job schedule. If you cannot find a schedule for the jobs return -1.

```ts
function minDifficulty(jobDifficulty: number[], d: number): number {
    const cache: Map<string, number> = new Map;
    const _minDif = (currentIndex: number, days: number): number => {
        const todos = jobDifficulty.length - currentIndex;
        if (todos < days) return -1;
        const key = currentIndex + ',' + days;
        if (cache.has(key)) return cache.get(key);

        let maxDiff = 0;
        let minDiff = Number.MAX_VALUE;

        if (days === 1) {
            for (let i = currentIndex; i < jobDifficulty.length; i++) {
                maxDiff = Math.max(maxDiff, jobDifficulty[i]);
            }
            minDiff = maxDiff;
        } else {
            for (let todays = 1; (todos - todays) >= (days - 1); todays++) {
                maxDiff = Math.max(maxDiff, jobDifficulty[currentIndex + todays - 1]);
                minDiff = Math.min(minDiff, maxDiff + _minDif(currentIndex + todays, days - 1));
            }
        }

        cache.set(key, minDiff);
        return minDiff;
    }

    const result = _minDif(0, d);
    return result;
};
```

### 139. Word Break

Given a string s and a dictionary of strings wordDict, return true if s can be segmented into a space-separated sequence of one or more dictionary words.

Note that the same word in the dictionary may be reused multiple times in the segmentation.

```ts
class Trie {
    subTrie: Array<Trie | undefined>;
    word: string | undefined;
    constructor() {
        this.subTrie = new Array(26).fill(undefined);
        this.word = undefined;
    }

    insert(index: number, word: string) {
        if (index === word.length) {
            this.word = word;
            return;
        }
        const current = word[index];
        const charIndex = current.charCodeAt(0) - 'a'.charCodeAt(0);
        if (this.subTrie[charIndex] === undefined) {
            this.subTrie[charIndex] = new Trie;
        }
        this.subTrie[charIndex].insert(index + 1, word);
    }
}

function wordBreak(s: string, wordDict: string[]): boolean {
    const root = new Trie;
    for (let i = 0; i < wordDict.length; i++) {
        root.insert(0, wordDict[i]);
    }
    const dp = new Map<number, boolean>();

    const _wordBreak = (index: number, lastTrie: Trie): boolean => {
        if (index === s.length) {
            return lastTrie.word !== undefined;
        }
        const currentChar = s[index];
        const charIndex = currentChar.charCodeAt(0) - 'a'.charCodeAt(0);
        const currentTrie = lastTrie.subTrie[charIndex];
        if (currentTrie === undefined) return false;
        if (currentTrie.word) {
            if (dp.get(index + 1) === undefined) {
                if (_wordBreak(index + 1, root)) {
                    return true;
                } else {
                    dp.set(index + 1, false);
                }
            }
        }
        return _wordBreak(index + 1, currentTrie);
    }

    return _wordBreak(0, root);
};
```