## Reference

<https://leetcode.com/explore/featured/card/top-interview-questions-easy>

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