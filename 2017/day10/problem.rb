require 'byebug'

class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      3,4,1,5
    TXT
    @part1_test_answer = 12

    @part2_test_input = <<~TXT
      1,2,3
    TXT
    @part2_test_answer = '3efbe78a8d82f29979031a4aa0b16a9d'
  end

  def to_hex(int)
    int < 16 ? '0' + int.to_s(16) : int.to_s(16)
  end

  def part1(input)
    lengths = input.chomp.split(',').map(&:to_i)
    items = lengths.count == 4 ? (0..4).to_a : (0..255).to_a
    current = 0
    skip = 0

    lengths.each do |length|
      subset = (current...(current + length)).map { items[_1%items.count] }.reverse
      (current...(current + length)).each_with_index { items[_1%items.count] = subset[_2] }
      current += ((length + skip) % items.count)
      skip += 1
    end

    return items[0] * items[1]
  end

  def part2(input)
    result = input.chomp.chars.map(&:ord)
    result << [17,31,73,47,23]
    lengths = result.flatten
    items = (0..255).to_a
    current = 0
    skip = 0

    64.times do
      lengths.each do |length|
        subset = (current...(current + length)).map { items[_1%items.count] }.reverse
        (current...(current + length)).each_with_index { items[_1%items.count] = subset[_2] }
        current += ((length + skip) % items.count)
        skip += 1
      end
    end

    return items.each_slice(16).reduce("") { |answer, slice| answer += to_hex(slice.reduce(:^)) }
  end
end
