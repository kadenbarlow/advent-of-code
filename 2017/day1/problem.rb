require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      91212129
    TXT
    @part1_test_answer = 9

    @part2_test_input = <<~TXT
      12131415
    TXT
    @part2_test_answer = 4
  end

  def part1(input)
    chars = input.chomp.chars.map(&:to_i)
    sum = 0
    chars.each_index.to_a[0..-2].each { |i| sum += chars[i] if chars[i] == chars[i+1] }
    sum += chars[0] if chars[-1] == chars[0]
    return sum
  end

  def part2(input)
    chars = input.chomp.chars.map(&:to_i)
    sum = 0
    length = chars.length / 2
    chars.each_index.each { |i| sum += chars[i] if chars[i] == chars[(i + length)%(chars.length)] }
    return sum
  end
end
