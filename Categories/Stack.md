- [Easy](#easy)
  - [496. Next Greater Element I](#496-next-greater-element-i)
- [Medium](#medium)
  - [503. Next Greater Element II](#503-next-greater-element-ii)
## Easy

### 496. Next Greater Element I

You are given two integer arrays nums1 and nums2 both of unique elements, where nums1 is a subset of nums2.

Find all the next greater numbers for nums1's elements in the corresponding places of nums2.

The Next Greater Number of a number x in nums1 is the first greater number to its right in nums2. If it does not exist, return -1 for this number.

```ts
function nextGreaterElement(nums1: number[], nums2: number[]): number[] {
    const map: Map<number, number> = new Map; // value -> next greater value
    const stack = [nums2[nums2.length - 1]];
    map.set(nums2[nums2.length - 1], -1);
    for (let i = nums2.length - 2; i >= 0; i--) {
        while (stack.length > 0 && stack[stack.length - 1] < nums2[i]) {
            stack.pop();
        }
        if (stack.length === 0) {
            map.set(nums2[i], -1);
        } else {
            map.set(nums2[i], stack[stack.length - 1]);
        }
        stack.push(nums2[i]);
    }
    return nums1.map(val => map.get(val));
};
```

## Medium

### 503. Next Greater Element II

Given a circular integer array nums (i.e., the next element of nums[nums.length - 1] is nums[0]), return the next greater number for every element in nums.

The next greater number of a number x is the first greater number to its traversing-order next in the array, which means you could search circularly to find its next greater number. If it doesn't exist, return -1 for this number.

```ts
function nextGreaterElements(nums: number[]): number[] {
    const result = new Array(nums.length).fill(-1);
    const stack = []; // indices

    for (let i = 0; i < 2 * nums.length; i++) {
        while (stack.length > 0 && nums[stack[stack.length - 1]] < nums[i % nums.length]) {
            const index = stack.pop();
            result[index] = nums[i % nums.length];
        }
        stack.push(i % nums.length);
    }

    return result;
};
```