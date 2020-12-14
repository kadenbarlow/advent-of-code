require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
      mem[8] = 11
      mem[7] = 101
      mem[8] = 0
    TXT
    @part1_test_answer = 165

    @part2_test_input = <<~TXT
      mask = 000000000000000000000000000000X1001X
      mem[42] = 100
      mask = 00000000000000000000000000000000X0XX
      mem[26] = 1
    TXT
    @part2_test_answer = 208
  end

  def apply_mask(value, mask)
    int = value.to_s(2)
    int36 = ('0' * (36 - int.length)) + int
    mask.chars.each_with_index do |char, index|
      next unless %w[1 0].include?(char)

      int36[index] = char
    end
    return int36.to_i(2)
  end

  def part1(input)
    lines = input.split("\n")
    mask = ''

    memory = {}
    lines.each do |line|
      if line.include?('mask')
        mask = line.sub('mask = ', '')
      else
        address = line[/mem\[(\d*)\]/, 1]
        value = line.sub(/mem\[\d*\] = /, '').to_i

        memory[address] = apply_mask(value, mask)
      end
    end

    return memory.values.reduce(:+)
  end

  def address_mask(value, mask)
    int = value.to_s(2)
    int36 = ('0' * (36 - int.length)) + int
    x_indexes = []
    mask.chars.each_with_index do |char, index|
      next if char == '0'

      x_indexes << index if char == 'X'
      int36[index] = char
    end

    values = []
    [0, 1].repeated_permutation(x_indexes.length).each do |combo|
      val = int36.clone
      x_indexes.each_with_index { |x_index, combo_index| val[x_index] = combo[combo_index].to_s }
      values << val.to_i(2)
    end
    return values
  end

  def part2(input)
    lines = input.split("\n")
    mask = ''

    memory = {}
    lines.each do |line|
      if line.include?('mask')
        mask = line.sub('mask = ', '')
      else
        address = line[/mem\[(\d*)\]/, 1].to_i
        value = line.sub(/mem\[\d*\] = /, '').to_i

        addresses = address_mask(address, mask)
        addresses.each { |addr| memory[addr] = value }
      end
    end

    return memory.values.reduce(:+)
  end
end
