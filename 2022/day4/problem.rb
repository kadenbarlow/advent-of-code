require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      2-4,6-8
      2-3,4-5
      5-7,7-9
      2-8,3-7
      6-6,4-6
      2-6,4-8
    TXT
    @part1_test_answer = 2

    @part2_test_input = <<~TXT
      2-4,6-8
      2-3,4-5
      5-7,7-9
      2-8,3-7
      6-6,4-6
      2-6,4-8
    TXT
    @part2_test_answer = 4
  end

  def part1(input)
    input.split("\n").reduce(0) do |sum, list|
      first, second = list.split(",").map do |pair|
        nums = pair.split('-').map(&:to_i)
        (nums.first..nums.last)
      end
      sum + (first.cover?(second) || second.cover?(first) ? 1 : 0)
    end
  end

  def part2(input)
    input.split("\n").reduce(0) do |sum, list|
      first, second = list.split(",").map do |pair|
        nums = pair.split('-').map(&:to_i)
        (nums.first..nums.last)
      end
      sum + ((first.to_a & second.to_a).empty? ? 0 : 1)
    end
  end
end
