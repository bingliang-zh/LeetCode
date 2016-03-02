# encoding: UTF-8
# author: bl_indie
# link: https://leetcode.com/problems/max-points-on-a-line/
# 

# Definition for a point.
class Point
    attr_accessor :x, :y
    def initialize(x=0, y=0)
        @x = x
        @y = y
    end
end
# Definition for a line.
class Line
    attr_accessor :a, :b, :c
    def initialize(a=0, b=0, c=0)
        @a = a
        @b = b
        @c = c
    end
end

# @param {Point[]} points
# @return {Integer}
def max_points(points)

end

p1 = Point.new(0,0)
p2 = Point.new(0,1)
p3 = Point.new(1,0)
p4 = Point.new(1,1)
p5 = Point.new(2,2)

# points = [p1,p2,p3,p4,p5]
#
# p points

# Ax+By+C=0
def draw_line(p1,p2)
  if p1.x==p2.x
    a=1
    b=0
    c=-p1.x
    return Line.new(a,b,c)
  else
    a = (p1.y-p2.y)/(p1.x-p2.x)
    b = -1
    c = (p2.y*p1.x-p1.y*p2.x)/(p1.x-p2.x)
    return Line.new(a,b,c)
  end
end

p draw_line(p1,p4)
