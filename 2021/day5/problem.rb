require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      0,9 -> 5,9
      8,0 -> 0,8
      9,4 -> 3,4
      2,2 -> 2,1
      7,0 -> 7,4
      6,4 -> 2,0
      0,9 -> 2,9
      3,4 -> 1,4
      0,0 -> 8,8
      5,5 -> 8,2
    TXT
    @part1_test_answer = 5

    @part2_test_input = <<~TXT
    TXT
    @part2_test_answer = nil
  end

  def part1(input)
    grid = Hash.new { |hash, key| hash[key] = Hash.new { |h, k| h[k] = 0 } }

    input.split("\n").each do |row|
      a, b = row.split(' -> ').map { |point| point.split(',') }

      range = [a[1], b[1]].sort
      (range[0]..range[1]).each { |y| grid[y][a[0]] += 1 } if a[0] == b[0]

      range = [a[0], b[0]].sort
      (range[0]..range[1]).each { |x| grid[a[1]][x] += 1 } if a[1] == b[1]
    end

    return grid.values.map(&:values).flatten.filter { |num| num >= 2 }.count
  end

  def part2(input)
  end
end
