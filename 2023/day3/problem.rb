require 'byebug'
require_relative '../../lib/graph'
require_relative '../../lib/string'

class Solution < AbstractSolution
  def initialize
    super
    @part1_test_cases = [
      {
        answer: 4361,
        input: <<~TXT
          467..114..
          ...*......
          ..35..633.
          ......#...
          617*......
          .....+.58.
          ..592.....
          ......755.
          ...$.*....
          .664.598..
        TXT
      }
    ]

    @part2_test_cases = [{
      answer: 467_835,
      input: <<~TXT
        467..114..
        ...*......
        ..35..633.
        ......#...
        617*......
        .....+.58.
        ..592.....
        ......755.
        ...$.*....
        .664.598..
      TXT
    }]
  end

  def extract_part_at(grid:, point:)
    string = grid[point[1]][point[0]].dup
    x = point[0] - 1
    while x >= 0
      break unless grid[point[1]][x].integer?

      string.prepend(grid[point[1]][x])
      x -= 1
    end
    x = point[0] + 1
    while x < grid[point[1]].length
      break unless grid[point[1]][x].integer?

      string += (grid[point[1]][x])
      x += 1
    end
    return [string.to_i, [x, point[1]]]
  end

  def find_adjacent_parts(grid:, parts:, point:)
    points_to_check = [[point[0], point[1] + 1], [point[0], point[1] - 1],
                       [point[0] + 1, point[1]], [point[0] - 1, point[1]],
                       [point[0] + 1, point[1] + 1], [point[0] + 1, point[1] - 1],
                       [point[0] - 1, point[1] + 1], [point[0] - 1, point[1] - 1]]

    points_to_check.each do |x, y|
      next if x.negative? || y.negative?
      next if y >= grid.length || x >= grid[y].length

      parts << extract_part_at(grid:, point: [x, y]) if grid[y][x].integer?
    end
  end

  def part1(input)
    grid = input.split("\n").map(&:chars)
    parts = Set.new
    grid.each_with_index do |row, y|
      row.each_with_index do |char, x|
        next if char == '.'
        next if char.integer?

        find_adjacent_parts(grid:, parts:, point: [x, y])
      end
    end
    parts.to_a.map { _1[0] }.sum
  end

  def part2(input)
    grid = input.split("\n").map(&:chars)
    parts = Hash.new { |h, k| h[k] = Set.new }
    grid.each_with_index do |row, y|
      row.each_with_index do |char, x|
        next unless char == '*'

        find_adjacent_parts(grid:, parts: parts[[x, y]], point: [x, y])
      end
    end

    gears = parts.values.map(&:to_a).select { _1.length > 1 }
    ratios = gears.map { |p| p.map { _1[0] }.reduce(:*) }
    ratios.sum
  end
end
