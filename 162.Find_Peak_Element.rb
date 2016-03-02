# encoding: UTF-8
# author: bl_indie
# link: https://leetcode.com/problems/find-peak-element/
# Your runtime beats 83.33% of rubysubmissions.

# @param {Integer[]} nums
# @return {Integer}
def find_peak_element(nums)
  n = nums.size
  if n == 1
    return 0
  end
  if nums[0]>nums[1]
    return 0
  elsif nums[n-1]>nums[n-2]
    return n-1
  end
  i = 1
  while i <= n-2 do
    if nums[i]>nums[i-1] and nums[i]>nums[i+1]
      return i
    end
    i += 1
  end
end
