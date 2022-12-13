require 'byebug'
require 'set'
require_relative '../../lib/graph'

class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      Sabqponm
      abcryxxl
      accszExk
      acctuvwj
      abdefghi
    TXT
    @part1_test_answer = 31

    @part2_test_input = @part1_test_input
    @part2_test_answer = 29
  end

  def parse_input(input, start_location, exit_location, criteria)
    graph = Graph.new
    exit_locations = []

    grid = input.split("\n").map { _1.chars }
    grid.each_index do |y|
      grid[y].each_index do |x|
        start_location = [x, y] if grid[y][x] == start_location
        exit_locations << [x, y] if grid[y][x] == exit_location
        coordinates = [[x + 1, y], [x - 1, y], [x, y + 1], [x, y - 1]]
        coordinates.each do |point|
          next unless point[0] < grid[y].length &&
                      point[0] >= 0 &&
                      point[1] < grid.length &&
                      point[1] >= 0

          next unless method(criteria).call(grid, x, y, point)

          graph.add_edge(from: [x, y], to: [point[0], point[1]], weight: 1)
        end
      end
    end
    return graph, start_location, exit_locations
  end

  def forwards(grid, x, y, point)
    ((grid[y][x] == 'y' && grid[point[1]][point[0]] == 'E') ||
     (grid[y][x] == 'z' && grid[point[1]][point[0]] == 'E') ||
     (grid[point[1]][point[0]] != 'E' && (grid[point[1]][point[0]].ord - grid[y][x].ord <= 1 || grid[y][x] == 'S')))
  end

  def backwards(grid, x, y, point)
    ((grid[y][x] == 'a' && grid[point[1]][point[0]] == 'S') ||
     (grid[y][x] == 'b' && grid[point[1]][point[0]] == 'S') ||
     (grid[y][x] == 'E' && grid[point[1]][point[0]] == 'z') ||
     (grid[y][x] == 'E' && grid[point[1]][point[0]] == 'y') ||
     (grid[point[1]][point[0]] != 'S' && grid[y][x] != 'E' && (grid[y][x].ord - grid[point[1]][point[0]].ord <= 1)))
  end

  def part1(input)
    graph, start_location, exit_location = parse_input(input, 'S', 'E', :forwards)
    distances, = graph.dijkstras_algorithm(from: start_location)
    return distances[exit_location.first]
  end

  def part2(input)
    graph, start_location, exit_locations = parse_input(input, 'E', 'a', :backwards)
    distances, = graph.dijkstras_algorithm(from: start_location)
    distances.slice(*exit_locations).values.min
  end
end
