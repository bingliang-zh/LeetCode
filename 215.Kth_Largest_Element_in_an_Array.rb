# encoding: UTF-8
# author: bl_indie
# link: https://leetcode.com/problems/kth-largest-element-in-an-array/
# Your runtime beats 60.00% of rubysubmissions.

# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer}
def find_kth_largest(nums, k)
    nums.sort!.reverse!
    nums[k-1]
end
