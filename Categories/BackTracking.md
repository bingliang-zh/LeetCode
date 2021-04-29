- [Hard](#hard)
  - [679. 24 Game](#679-24-game)

## Hard

### 679. 24 Game

You have 4 cards each containing a number from 1 to 9. You need to judge whether they could operated through *, /, +, -, (, ) to get the value of 24.

```typescript
function judgePoint24(nums: number[]): boolean {
    if (nums.length === 1) {
        // pass [3, 3, 8, 8]
        return Math.abs(nums[0] - 24) < 1E-6;
    }

    let valid = false;
    // pick 2 numbers, do calculations, push result back to nums
    for (let i = 0; i < nums.length - 1; i++) {
        for (let j = i + 1; j < nums.length; j++) {
            const a = nums[i];
            const b = nums[j];
            const rest = nums.filter((v, index) => {
                return index !== i && index !== j;
            });
            // do calculations
            // +
            valid = valid || judgePoint24([a + b, ...rest]);
            // -
            valid = valid || judgePoint24([a - b, ...rest]);
            valid = valid || judgePoint24([b - a, ...rest]);
            // *
            valid = valid || judgePoint24([a * b, ...rest]);
            // /
            valid = valid || judgePoint24([a / b, ...rest]);
            valid = valid || judgePoint24([b / a, ...rest]);
        }
    }
    return valid;
};
```