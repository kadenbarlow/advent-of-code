require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      {{<!!>},{<!!>},{<!!>},{<!!>}}
    TXT
    @part1_test_answer = 9

    @part2_test_input = <<~TXT
      <{o"i!a,<{i<a>
    TXT
    @part2_test_answer = 10
  end

  def part1(input)
    stack = 0
    result = 0
    string = input.gsub(/!./, '').gsub(/<.*?>/, '')
    string.chars.each do |char|
      stack += 1 if char == '{'
      if char == '}'
        result += stack
        stack -= 1
      end
    end
    return result
  end

  def part2(input)
    input.gsub(/!./, '').scan(/<.*?>/).reduce(0) { |sum, string| sum += (string.length - 2) }
  end
end
