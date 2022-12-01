require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
    1000
    2000
    3000

    4000

    5000
    6000

    7000
    8000
    9000

    10000
    TXT
    @part1_test_answer = 24000

    @part2_test_input = @part1_test_input
    @part2_test_answer = 45000
  end

  def part1(input)
    elves = input.split("\n\n")
    return elves.map { |elf| elf.split("\n").map(&:to_i).reduce(:+) }.max
  end

  def part2(input)
    elves = input.split("\n\n")
    calories = elves.map { |elf| elf.split("\n").map(&:to_i).reduce(:+) }
    answer = 0
    3.times { answer += calories.delete(calories.max) }
    return answer
  end
end
