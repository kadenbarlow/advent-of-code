require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010
    TXT
    @part1_test_answer = 198

    @part2_test_input = @part1_test_input
    @part2_test_answer = 230
  end

  def part1(input)
    grid = input.split("\n").map { |row| row.split('') }
    gamma_rate = ""
    epsilon_rate = ""
    (0...grid.first.count).each do |index|
      counts = grid.map { |row| row[index] }.tally
      gamma_rate += counts.invert[counts.values.max]
      epsilon_rate += counts.invert[counts.values.min]
    end
    return gamma_rate.to_i(2) * epsilon_rate.to_i(2)
  end

  def part2(input)
    grid = input.split("\n").map { |row| row.split('') }

    ratings = [:min, :max].map do |bit_criteria|
      rows = grid.dup

      (0...grid.first.count).each do |index|
        break if rows.count == 1

        counts = rows.map { |row| row[index] }.tally
        values = counts.values
        result = values[0] == values[1] ? [0, 1].send(bit_criteria).to_s : counts.invert[counts.values.send(bit_criteria)]
        rows = rows.filter { |row| row[index] == result }
      end

      rows.first
    end

    return ratings.map { |rating| rating.join('').to_i(2) }.reduce(:*)
  end
end
