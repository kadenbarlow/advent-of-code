require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      bvwbjplbgvbhsrlpgdmjqwftvncz
    TXT
    @part1_test_answer = 5

    @part2_test_input = <<~TXT
      mjqjpqmgbljsphdztnvjfqwrcgsmlb
    TXT
    @part2_test_answer = 19
  end

  def part1(input)
    input.chars.length.times do |x|
      return x + 4 if input[x..(x + 3)].chars.uniq.count == 4
    end
  end

  def part2(input)
    input.chars.length.times do |x|
      return x + 14 if input[x..(x + 13)].chars.uniq.count == 14
    end
  end
end
