require 'byebug'
require 'set'

class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      0, 2, 7, 0
    TXT
    @part1_test_answer = 5

    @part2_test_input = <<~TXT
      0, 2, 7, 0
    TXT
    @part2_test_answer = 4
  end

  def part1(input)
    configurations = Set.new
    items = input.split(" ").map(&:to_i)
    configurations << items
    result = 0

    while true
      result += 1
      index = items.index(items.max)
      amount = items[index]
      items[index] = 0
      (index+1..(index+amount)).each { items[_1%items.length] += 1 }
      break if configurations.member?(items)
      configurations << items
    end

    return result
  end

  def part2(input)
    answer = {}
    configurations = Set.new
    items = input.split(" ").map(&:to_i)
    configurations << items
    result = 0
    answer[items] = 0

    while true
      result += 1
      index = items.index(items.max)
      amount = items[index]
      items[index] = 0
      (index+1..(index+amount)).each { items[_1%items.length] += 1 }
      break if configurations.member?(items)
      configurations << items
      answer[items] = result
    end

    return result - answer[items]
  end
end
