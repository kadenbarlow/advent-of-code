require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      30373
      25512
      65332
      33549
      35390
    TXT
    @part1_test_answer = 21

    @part2_test_input = <<~TXT
      30373
      25512
      65332
      33549
      35390
    TXT
    @part2_test_answer = 16
  end

  def parse_input(input)
    rows = Hash.new { |hash, key| hash[key] = [] }
    columns = Hash.new { |hash, key| hash[key] = [] }

    input.split("\n").each_with_index do |row, i|
      row.chars.each_with_index do |column, j|
        rows[i] << column
        columns[j] << column
      end
    end

    height = input.split("\n").length
    width = input.split("\n").first.length

    return rows, columns, width, height
  end

  def part1(input)
    rows, columns, width, height = parse_input(input)
    trees = 0
    input.split("\n").each_with_index do |row, i|
      row.chars.each_with_index do |column, j|
        if i.zero? ||
           j.zero? ||
           i == (height - 1) ||
           j == (width - 1) ||
           rows[i][0...j].max < column ||
           rows[i][(j + 1)..].max < column ||
           columns[j][0...i].max < column ||
           columns[j][(i + 1)..].max < column
          trees += 1
        end
      end
    end
    return trees
  end

  def part2(input)
    rows, columns, width, height = parse_input(input)
    max_score = 0
    input.split("\n").each_with_index do |row, i|
      row.chars.each_with_index do |column, j|
        score = []
        score << (j - rows[i].each_index.select{ _1 < j && rows[i][_1] >= column }.max unless j == 0 rescue j)
        score << (rows[i].each_index.find{ _1 > j && rows[i][_1] >= column } - j unless j == width -1 rescue (width - 1 - j))
        score << (i - columns[j].each_index.select{ _1 < i && columns[j][_1] >= column }.max unless i == 0 rescue i)
        score << (columns[j].each_index.find{ _1 > i && columns[j][_1] >= column } - i unless i == height -1 rescue (height - 1 - i))
        score = score.compact.reduce(:*)
        max_score = [score, max_score].max if score
      end
    end
    return max_score
  end
end
