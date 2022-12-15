require 'byebug'
require 'set'

class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      Sensor at x=2, y=18: closest beacon is at x=-2, y=15
      Sensor at x=9, y=16: closest beacon is at x=10, y=16
      Sensor at x=13, y=2: closest beacon is at x=15, y=3
      Sensor at x=12, y=14: closest beacon is at x=10, y=16
      Sensor at x=10, y=20: closest beacon is at x=10, y=16
      Sensor at x=14, y=17: closest beacon is at x=10, y=16
      Sensor at x=8, y=7: closest beacon is at x=2, y=10
      Sensor at x=2, y=0: closest beacon is at x=2, y=10
      Sensor at x=0, y=11: closest beacon is at x=2, y=10
      Sensor at x=20, y=14: closest beacon is at x=25, y=17
      Sensor at x=17, y=20: closest beacon is at x=21, y=22
      Sensor at x=16, y=7: closest beacon is at x=15, y=3
      Sensor at x=14, y=3: closest beacon is at x=15, y=3
      Sensor at x=20, y=1: closest beacon is at x=15, y=3
    TXT
    @part1_test_answer = 26

    @part2_test_input = @part1_test_input
    @part2_test_answer = 56_000_011
  end

  SENSOR = 'S'.freeze
  BEACON = 'B'.freeze

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
    grid = Hash.new { |hash, key| hash[key] = '.' }
    sensors = {}
    distances = {}
    input.split("\n").each do |info|
      sensor, beacon = info.split(':')

      sensor_x = sensor[/x=(-*\d+)/, 1].to_i
      sensor_y = sensor[/y=(-*\d+)/, 1].to_i
      sensor = [sensor_x, sensor_y]
      grid[sensor] = SENSOR

      beacon_x = beacon[/x=(-*\d+)/, 1].to_i
      beacon_y = beacon[/y=(-*\d+)/, 1].to_i
      beacon = [beacon_x, beacon_y]
      grid[beacon] = BEACON

      distance = (sensor[0] - beacon[0]).abs + (sensor[1] - beacon[1]).abs
      distances[sensor] = distance
      sensors[sensor] = beacon
    end
    return grid, sensors, distances
  end

  def part1(input)
    answer = input.split("\n").count < 15 ? 10 : 2_000_000
    _, sensors, distances = parse_input(input)

    relevant = sensors.keys.select do |sensor|
      y = sensor[1]
      distance = distances[sensor]
      ((y - distance)..(y + distance)).cover?(answer)
    end

    ranges = []
    relevant.each do |sensor|
      beacon = sensors[sensor]
      distance = (sensor[0] - beacon[0]).abs + (sensor[1] - beacon[1]).abs
      coverage = (distance - (sensor[1] - answer).abs).abs
      ranges << ((sensor[0] - coverage)..(sensor[0] + coverage))
    end

    return ranges.flat_map(&:to_a).uniq.count - 1
  end

  def part2(input)
    # Cheated and looked up how to do this the next morning
    answer = input.split("\n").count < 15 ? 20 : 4_000_000
    sensors = input.split("\n").map do |line|
      sensor_x, sensor_y, beacon_x, beacon_y = line.scan(/-?\d+/).map(&:to_i)
      [[sensor_x, sensor_y], (beacon_y - sensor_y).abs + (beacon_x - sensor_x).abs]
    end

    lines = sensors.map do |(x, y), r|
      [[x - y + r, x - y - r],
       [x + y + r, x + y - r]]
    end

    lines = lines.transpose.map(&:flatten)

    lines[0].product(lines[1])
            .map { |c1, c2| (c2 - c1) / 2 }
            .select { |y| y.is_a?(Integer) }
            .select { |y| (0..answer).include?(y) }
            .uniq
            .each do |row|

      ranges = sensors.map do |(x, y), radius|
        radius -= (row - y).abs
        [x - radius, x + radius]
      end

      ranges = ranges.select { |a, b| b > a }.sort

      col = ranges.first.first
      ranges.each do |x1, x2|
        if col >= x1 && col <= x2
          col = x2 + 1
        elsif x1 > col
          return row + (col * 4_000_000)
        end
      end
    end
  end
end
