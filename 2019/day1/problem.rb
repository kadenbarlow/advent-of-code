require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      12
      14
      1969
      100756
    TXT
    @part1_test_answer = (658 + 33_583)

    @part2_test_input = <<~TXT
      1969
    TXT
    @part2_test_answer = 966
  end

  def calculate(input)
    result = (input / 3) - 2
    return 0 if result.negative?

    return result
  end

  def calculate_recursive(input, sum)
    result = calculate(input)
    return sum if result.negative? || result.zero?

    return calculate_recursive(result, (sum + result))
  end

  def part1(input)
    input.split("\n").map(&:to_i).reduce(0) { |sum, item| sum + calculate(item) }
  end

  def part2(input)
    input.split("\n").map(&:to_i).reduce(0) { |sum, item| sum + calculate_recursive(item, 0) }
  end
end
