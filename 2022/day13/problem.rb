require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      [1,1,3,1,1]
      [1,1,5,1,1]

      [[1],[2,3,4]]
      [[1],4]

      [9]
      [[8,7,6]]

      [[4,4],4,4]
      [[4,4],4,4,4]

      [7,7,7,7]
      [7,7,7]

      []
      [3]

      [[[]]]
      [[]]

      [1,[2,[3,[4,[5,6,7]]]],8,9]
      [1,[2,[3,[4,[5,6,0]]]],8,9]
    TXT
    @part1_test_answer = 13

    @part2_test_input = @part1_test_input
    @part2_test_answer = 140
  end

  def compare(left, right)
    if left.is_a?(Array) && right.is_a?(Array)
      left.each_index do |index|
        # puts "Looking at #{left[index]} vs #{right[index]}"
        return false if right[index].nil?

        result = compare(left[index], right[index])

        next if result.nil?

        return result
      end
      return true if left.length < right.length

      return nil
    elsif left.is_a?(Integer) && right.is_a?(Integer)
      # puts "Comparing #{left} to #{right}"
      return true if left < right
      return nil if left == right
      return false if left > right
    elsif left.is_a?(Integer) && right.is_a?(Array)
      # puts "Converting left"
      return compare([left], right)
    elsif left.is_a?(Array) && right.is_a?(Integer)
      # puts "Converting right"
      return compare(left, [right])
    end
  end

  def part1(input)
    answer = []
    pairs = input.split("\n\n")
    pairs.each_with_index do |pair, index|
      left, right = pair.split("\n").map { eval(_1) }
      answer << (index + 1) if compare(left, right) == true || compare(left, right).nil?
    end
    return answer.reduce(:+)
  end

  def part2(input)
    packets = []
    input.split("\n\n").each { |pair| packets.concat([eval(pair.split("\n").first), eval(pair.split("\n").last)]) }
    packets.concat([[[2]], [[6]]])
    packets.sort! { |a, b| compare(a, b) == true || compare(a, b).nil? ? -1 : 1 }
    return (packets.index([[2]]) + 1) * (packets.index([[6]]) + 1)
  end
end
