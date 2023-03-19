require 'byebug'
require_relative '../../lib/circular_array'

class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      1
      2
      -3
      3
      -2
      0
      4
    TXT
    @part1_test_answer = 3

    @part2_test_input = <<~TXT
    TXT
    @part2_test_answer = nil
  end

  def part1(input)
    file = input.split("\n").map(&:to_i).map.with_index { |item, index| [item, index] }

    mixed_file = CircularArray.new(file.dup)
    file.each do |i|
      item, id = i
      current_index = mixed_file.index { _1[1] == id }
      offset = current_index + item
      mixed_file.delete_at(current_index)
      offset = mixed_file.length if offset.zero?
      offset -= 1 if offset >= file.length
      mixed_file.insert(offset, i)
    end
    return mixed_file[1000][0] = mixed_file[2000][0] + mixed_file[3000][0]
  end

  def part2(input); end
end
