# encoding: UTF-8
# author: bl_indie
# link: https://leetcode.com/problems/single-number/
# Your runtime beats 43.75% of rubysubmissions.

# @param {Integer[]} nums
# @return {Integer}
def single_number(nums)
  nums.sort!
  flag = 1
  sum = 0
  nums.each do |n|
    sum += n*flag
    flag *= -1
  end
  sum
end

# # Your runtime beats 18.75% of rubysubmissions.
#
# # @param {Integer[]} nums
# # @return {Integer}
# def single_number(nums)
#   hash = Hash.new
#   nums.each do |n|
#     if hash[n] == nil
#       hash[n] = true
#     else
#     # elsif hash[n] == true
#       hash.delete(n)
#     end
#   end
#   (hash.to_a)[0][0]
# end
