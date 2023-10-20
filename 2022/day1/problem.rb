require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_cases = [{
      answer: 24_000,
      input: <<~TXT
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
    }]

    @part2_test_cases = [{
      answer: 45_000,
      input: @part1_test_cases[0][:input]
    }]
  end

  def part1(input)
    elves = input.split("\n\n")
    return elves.map { |elf| elf.split("\n").map(&:to_i).reduce(:+) }.max
  end

  def part2(input)
    elves = input.split("\n\n")
    calories = elves.map { |elf| elf.split("\n").map(&:to_i).reduce(:+) }
    return calories.sort[-3..].reduce(:+)
  end
end
