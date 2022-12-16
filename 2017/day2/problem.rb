require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      5 1 9 5
      7 5 3
      2 4 6 8
    TXT
    @part1_test_answer = 18

    @part2_test_input = <<~TXT
      5 9 2 8
      9 4 7 3
      3 8 6 5
    TXT
    @part2_test_answer = 9
  end

  def part1(input)
    return input.split("\n")
            .map{  _1.split( ' ').map(&:to_i) }
            .map { [_1.min, _1.max] }
            .reduce(0) { |sum, row| sum += row[1] - row[0] }
  end

  def part2(input)
    return input.split("\n")
            .map{  _1.split( ' ').map(&:to_i) }
            .map { _1.combination(2) }
            .reduce(0) do |sum, row|
              items = row.find { (_1.max.to_f / _1.min) % 1 == 0 }
              sum += items.max / items.min
            end
  end
end
