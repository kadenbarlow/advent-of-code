require 'byebug'
require 'set'
require_relative '../../lib/hash'

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
    graph = Hash.new { |hash, key| hash[key] = [] }
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

          graph[[x, y]] << [point[0], point[1]]
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

  def dijkstras_algorithm(graph, start_location)
    distances = Hash.new { |hash, key| hash[key] = Float::INFINITY }
    previous = Hash.new { |hash, key| hash[key] = nil }
    graph.each_key { distances[_1] && previous[_1] }
    distances[start_location] = 0
    verticies = graph.keys.to_set

    until verticies.empty?
      min_distances = distances.values.sort
      nodes = distances.slice(*verticies).safe_invert
      min_distance = min_distances.find { !nodes[_1].nil? }
      vertex = nodes[min_distance].first
      verticies.delete(vertex)

      graph[vertex].each do |neighbor|
        distance = distances[vertex] + 1
        if distance < distances[neighbor]
          distances[neighbor] = distance
          previous[neighbor] = vertex
        end
      end
    end

    return distances
  end

  def part1(input)
    graph, start_location, exit_location = parse_input(input, 'S', 'E', :forwards)
    dijkstras_algorithm(graph, start_location)[exit_location.first]
  end

  def part2(input)
    graph, start_location, exit_locations = parse_input(input, 'E', 'a', :backwards)
    dijkstras_algorithm(graph, start_location).slice(*exit_locations).values.min
  end
end
