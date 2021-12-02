require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      forward 5
      down 5
      forward 8
      up 3
      down 8
      forward 2
    TXT
    @part1_test_answer = 150

    @part2_test_input = @part1_test_input
    @part2_test_answer = 900
  end

  def part1(input)
    data = Hash.new { |hash, key| hash[key] = 0 }
    input.split("\n")
         .each { r = _1.split(' '); data[r[0]] += r[1].to_i }
    return data['forward'] * (data['up'] - data['down']).abs
  end

  def part2(input)
    horizontal, depth, aim = 0, 0, 0
    input.split("\n").each do |row|
      direction, amount = row.split(' ')
      amount = amount.to_i

      if direction['forward']
        horizontal += amount
        depth += (amount * aim)
      end

      aim -= amount if direction['up']
      aim += amount if direction['down']
    end
    return horizontal * depth
  end
end
