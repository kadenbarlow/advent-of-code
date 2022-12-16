require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      0
      3
      0
      1
      -3
    TXT
    @part1_test_answer = 5

    @part2_test_input = <<~TXT
      0
      3
      0
      1
      -3
    TXT
    @part2_test_answer = 10
  end

  def part1(input)
    current = 0
    steps = 0
    items = input.split("\n").map(&:to_i)
    while current >= 0 && current <= items.length - 1
      last = current
      current += items[current]
      items[last] += 1
      steps += 1
    end
    return steps
  end

  def part2(input)
    current = 0
    steps = 0
    items = input.split("\n").map(&:to_i)
    while current >= 0 && current <= items.length - 1
      last = current
      jump = items[current]
      current += jump
      items[last] -= 1 if jump >= 3
      items[last] += 1 if jump < 3
      steps += 1
    end
    return steps
  end
end
