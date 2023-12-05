require 'byebug'
class Solution < AbstractSolution
  def initialize
    super
    @part1_test_cases = [
      {
        answer: 142,
        input: <<~TXT
          1abc2
          pqr3stu8vwx
          a1b2c3d4e5f
          treb7uchet
        TXT
      }
    ]

    @part2_test_cases = [
      {
        answer: 281,
        input: <<~TXT
          two1nine
          eightwothree
          abcone2threexyz
          xtwone3four
          4nineeightseven2
          zoneight234
          7pqrstsixteen
        TXT
      }
    ]
  end

  def part1(input)
    return input.split("\n").reduce(0) do |sum, line|
      first_digit = line.index(/[0-9]/)
      last_digit = line.reverse.index(/[0-9]/)
      sum + "#{line[first_digit]}#{line[line.length - last_digit - 1]}".to_i
    end
  end

  DIGITS = {
    'one' => 1,
    'two' => 2,
    'three' => 3,
    'four' => 4,
    'five' => 5,
    'six' => 6,
    'seven' => 7,
    'eight' => 8,
    'nine' => 9
  }.freeze

  def find_digits(arr)
    indexes = arr.chars.each_with_index.map { |char, i| char =~ /[0-9]/ ? [i, char.to_i] : nil }.compact.to_h
    DIGITS.each_key do |d|
      indexes.merge!(arr.to_enum(:scan, d).to_h { [Regexp.last_match.begin(0), DIGITS[d]] })
    end
    return indexes
  end

  def part2(input)
    return input.split("\n").reduce(0) do |sum, line|
      indexes = find_digits(line)
      sorted_indexes = indexes.keys.sort
      sum + "#{indexes[sorted_indexes.first]}#{indexes[sorted_indexes.last]}".to_i
    end
  end
end
