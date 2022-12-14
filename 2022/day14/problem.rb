require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      498,4 -> 498,6 -> 496,6
      503,4 -> 502,4 -> 502,9 -> 494,9
    TXT
    @part1_test_answer = 24

    @part2_test_input = @part1_test_input
    @part2_test_answer = 93
  end

  AIR = '.'.freeze
  ROCK = '#'.freeze
  SAND = '0'.freeze

  def print_grid(grid)
    x_values = grid.keys.map { _1[0] }
    y_values = grid.keys.map { _1[1] }
    (y_values.min..y_values.max).each do |y|
      (x_values.min..x_values.max).each do |x|
        print(grid[[x, y]])
      end
      print("\n")
    end
  end

  def parse_input(input)
    grid = Hash.new { |hash, key| hash[key] = AIR }
    input.split("\n").each do |row|
      points = row.split(' -> ')
      points[0..-2].each_index do |index|
        x, y = points[index].split(',').map(&:to_i)
        next_x, next_y = points[index + 1].split(',').map(&:to_i)

        x_values = [x, next_x]
        (x_values.min..x_values.max).each { grid[[_1, y]] = ROCK }

        y_values = [y, next_y]
        (y_values.min..y_values.max).each { grid[[x, _1]] = ROCK }
      end
    end
    return grid
  end

  def part1(input)
    grid = parse_input(input)
    last_y = 0
    max_y = grid.keys.map{ _1[1] }.max
    counter = 0

    while last_y < max_y
      point = [500, 0]
      previous_point = nil
      while point != previous_point && point[1] < max_y
        previous_point = point
        point = [point[0], point[1] + 1] and next if grid[[point[0], point[1] + 1]] == AIR
        point = [point[0] - 1, point[1] + 1] and next if grid[[point[0] - 1, point[1] + 1]] == AIR
        point = [point[0] + 1, point[1] + 1] and next if grid[[point[0] + 1, point[1] + 1]] == AIR
      end
      grid[point] = SAND
      counter += 1
      last_y = point[1]
    end

    return counter - 1
  end

  def part2(input)
    grid = parse_input(input)
    last_y = 0
    max_y = grid.keys.map{ _1[1] }.max
    counter = 0

    (0..1000).each { grid[[_1, max_y + 2]] = ROCK }
    max_y += 2

    while last_y < max_y
      point = [500, 0]
      previous_point = nil
      while point != previous_point && point[1] < max_y
        previous_point = point
        point = [point[0], point[1] + 1] and next if grid[[point[0], point[1] + 1]] == AIR
        point = [point[0] - 1, point[1] + 1] and next if grid[[point[0] - 1, point[1] + 1]] == AIR
        point = [point[0] + 1, point[1] + 1] and next if grid[[point[0] + 1, point[1] + 1]] == AIR
      end
      grid[point] = SAND
      counter += 1
      break if point == [500, 0]

      last_y = point[1]
    end

    return counter
  end
end
