require 'byebug'
class Solution < AbstractSolution
  def initialize
    super
    @part1_test_cases = [
      {
        answer: 13,
        input: <<~TXT
          Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
          Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
          Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
          Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
          Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
          Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
        TXT
      }
    ]

    @part2_test_cases = [{
      answer: 30,
      input: <<~TXT
        Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
        Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
        Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
        Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
        Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
        Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
      TXT
    }]
  end

  def count_winners(game)
    nums = {}
    winning_numbers, numbers = game.split(':').last.split('|')
    winning_numbers.scan(/\d+/).map { |n| nums[n] = true }
    numbers.scan(/\d+/).select { |n| nums[n] }.count
  end

  def part1(input)
    input.split("\n").reduce(0) do |sum, line|
      count = count_winners(line)
      sum + (count.positive? ? 2**(count - 1) : 0)
    end
  end

  def part2(input)
    cards = Hash.new { |hash, key| hash[key] = 1 }
    input.split("\n").each_with_index do |line, index|
      count = count_winners(line)
      cards[index].times { count.times { cards[_1 + index + 1] += 1 } }
    end
    cards.each_key.reduce(0) { |sum, card| sum + cards[card] }
  end
end
