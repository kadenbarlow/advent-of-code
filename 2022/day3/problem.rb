require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      vJrwpWtwJgWrhcsFMMfFFhFp
      jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
      PmmdzqPrVvPwwTWBwg
      wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
      ttgJtRGJQctTZtZT
      CrZsJsPPZsGzwwsLwLmpwMDw
    TXT
    @part1_test_answer = 157

    @part2_test_input = <<~TXT
      vJrwpWtwJgWrhcsFMMfFFhFp
      jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
      PmmdzqPrVvPwwTWBwg
      wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
      ttgJtRGJQctTZtZT
      CrZsJsPPZsGzwwsLwLmpwMDw
    TXT
    @part2_test_answer = 70
  end

  def part1(input)
    alphabet = ('a'..'z').to_a + ('A'..'Z').to_a
    input.split("\n").reduce(0) do |sum, items|
      item = items[0...(items.length / 2)].chars & items[items.length / 2..].chars
      sum + alphabet.index(item[0]) + 1
    end
  end

  def part2(input)
    alphabet = ('a'..'z').to_a + ('A'..'Z').to_a
    input.split("\n").each_slice(6).reduce(0) do |sum, items|
      result = items.map(&:chars).each_slice(3).to_a.map { _1.reduce(:&) }
      sum + alphabet.index(result[0][0]) + alphabet.index(result[1][0]) + 2
    end
  end
end
