require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
199
200
208
210
200
207
240
269
260
263
    TXT
    @part1_test_answer = 7

    @part2_test_input = @part1_test_input
    @part2_test_answer = 5
  end

  def answer(array)
    previous = nil
    return array.reduce(0) { |count, n|
      tmp = previous
      previous = n
      !tmp.nil? && n > tmp ? count + 1 : count
    }
  end

  def part1(input)
    answer(input.split("\n").map(&:to_i))
  end

  def part2(input)
    values = []
    nums = input.split("\n").map(&:to_i)
    nums.each_with_index { |current, index|
      break if index + 2 >= nums.length
      values << (current.to_i + nums[index + 1] + nums[index + 2])
    }
    answer(values)
  end
end
