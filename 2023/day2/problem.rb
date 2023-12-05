require 'byebug'
class Solution < AbstractSolution
  def initialize
    super
    @part1_test_cases = [
      {
        answer: 8,
        input: <<~TXT
          Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
          Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
          Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
          Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
          Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
        TXT
      }
    ]

    @part2_test_cases = [
      {
        answer: 2286,
        input: <<~TXT
          Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
          Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
          Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
          Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
          Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
        TXT
      }
    ]
  end

  PART1_RULES = {
    'red' => 12,
    'green' => 13,
    'blue' => 14
  }.freeze

  def part1(input)
    ids = []
    input.split("\n").each_with_index do |game, index|
      possible = true
      game.split(':').last.split(';').each do |presentation|
        presentation.split(',').each do |set|
          num, color = set.split
          possible = false if num.to_i > PART1_RULES[color]
        end
      end
      ids << (index + 1) if possible
    end
    return ids.sum
  end

  def part2(input)
    powers = []
    input.split("\n").each_with_index do |game, _index|
      values = { 'red' => 0, 'green' => 0, 'blue' => 0 }
      game.split(':').last.split(';').each do |presentation|
        presentation.split(',').each do |set|
          num, color = set.split
          values[color] = [values[color], num.to_i].max
        end
      end
      powers << (values['red'] * values['green'] * values['blue'])
    end
    return powers.sum
  end
end
