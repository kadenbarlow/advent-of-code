require 'byebug'
class Solution < AbstractSolution
  def initialize
    super
    @part1_test_cases = [
      {
        answer: 4,
        input: <<~TXT
          .....
          .S-7.
          .|.|.
          .L-J.
          .....
        TXT
      },
      {
        answer: 8,
        input: <<~TXT
          ..F7.
          .FJ|.
          SJ.L7
          |F--J
          LJ...
        TXT
      }
    ]

    @part2_test_cases = [
      {
        answer: 4,
        input: <<~TXT
          ..........
          .S------7.
          .|F----7|.
          .||....||.
          .||....||.
          .|L-7F-J|.
          .|..||..|.
          .L--JL--J.
          ..........
        TXT
      },
      {
        answer: 4,
        input: <<~TXT
          ...........
          .S-------7.
          .|F-----7|.
          .||.....||.
          .||.....||.
          .|L-7.F-J|.
          .|..|.|..|.
          .L--J.L--J.
          ...........
        TXT
      },
      {
        answer: 8,
        input: <<~TXT
          .F----7F7F7F7F-7....
          .|F--7||||||||FJ....
          .||.FJ||||||||L7....
          FJL7L7LJLJ||LJ.L-7..
          L--J.L7...LJS7F-7L7.
          ....F-J..F7FJ|L7L7L7
          ....L7.F7||L7|.L7L7|
          .....|FJLJ|FJ|F7|.LJ
          ....FJL-7.||.||||...
          ....L---J.LJ.LJLJ...
        TXT
      },
      {
        answer: 10,
        input: <<~TXT
          FF7FSF7F7F7F7F7F---7
          L|LJ||||||||||||F--J
          FL-7LJLJ||||||LJL-77
          F--JF--7||LJLJ7F7FJ-
          L---JF-JLJ.||-FJLJJ7
          |F|F-JF---7F7-L7L|7|
          |FFJF7L7F-JF7|JL---7
          7-L-JL7||F7|L7F-7F7|
          L.L7LFJ|||||FJL7||LJ
          L7JLJL-JLJLJL--JLJ.L
        TXT
      }
    ]
  end

  VISITED = 'V'.freeze
  VERTICAL_PIPE = '|'.freeze
  HORIZONTAL_PIPE = '-'.freeze
  NORTH_EAST_BEND = 'L'.freeze
  NORTH_WEST_BEND = 'J'.freeze
  SOUTH_EAST_BEND = 'F'.freeze
  SOUTH_WEST_BEND = '7'.freeze
  GROUND = '.'.freeze
  START = 'S'.freeze

  OPTIONS = {
    VERTICAL_PIPE => [[0, -1], [0, 1]],
    HORIZONTAL_PIPE => [[-1, 0], [1, 0]],
    NORTH_EAST_BEND => [[0, -1], [1, 0]],
    NORTH_WEST_BEND => [[0, -1], [-1, 0]],
    SOUTH_EAST_BEND => [[0, 1], [1, 0]],
    SOUTH_WEST_BEND => [[0, 1], [-1, 0]]
  }.freeze

  def starting_options(grid:, point:)
    x, y = point
    options = []
    options << [0, -1] if [VERTICAL_PIPE, SOUTH_EAST_BEND, SOUTH_WEST_BEND].include?(grid[y - 1][x])
    options << [0, 1] if [VERTICAL_PIPE, NORTH_EAST_BEND, NORTH_WEST_BEND].include?(grid[y + 1][x])
    options << [-1, 0] if [HORIZONTAL_PIPE, NORTH_EAST_BEND, SOUTH_EAST_BEND].include?(grid[y][x - 1])
    options << [1, 0] if [HORIZONTAL_PIPE, NORTH_WEST_BEND, SOUTH_WEST_BEND].include?(grid[y][x + 1])
    return options
  end

  def dfs(grid:, start:)
    current = start
    previous = nil
    steps = 0
    loop do
      x, y = current
      current_pipe = grid[y][x]
      steps += 1 and break if current == start && current_pipe == VISITED

      options = starting_options(grid:, point: current) if current_pipe == START
      options ||= OPTIONS[current_pipe]

      options = (options.map { [x + _1[0], y + _1[1]] } - [previous]).filter { grid[_1[1]][_1[0]] != GROUND }
      grid[y][x] = VISITED
      previous = current
      current = options.first
      steps += 1
    end
    return steps
  end

  def part1(input)
    grid = input.split("\n").map(&:chars)
    start = []
    grid.each_with_index { |row, y| row.each_with_index { |char, x| start = [x, y] and break if char == START } }
    (dfs(grid:, start:).to_f / 2).floor
  end

  def expand_grid(grid)
    new_grid = []
    grid.each { |row| new_grid << row.zip(Array.new(row.length, '#')).flatten }
    new_grid = new_grid.zip(Array.new(new_grid.length) { Array.new(new_grid[0].length, '#') }).flatten(1)

    new_grid.each_with_index do |row, y|
      row.each_with_index do |char, x|
        if char == '#' &&
           [START, HORIZONTAL_PIPE, NORTH_EAST_BEND, SOUTH_EAST_BEND].include?(new_grid[y][x - 1]) &&
           [START, HORIZONTAL_PIPE, NORTH_WEST_BEND, SOUTH_WEST_BEND].include?(new_grid[y][x + 1])
          new_grid[y][x] = HORIZONTAL_PIPE
        end
        next unless char == '#' &&
                    (y - 1) >= 0 && (y + 1) < new_grid.length &&
                    [START, VERTICAL_PIPE, NORTH_EAST_BEND, NORTH_WEST_BEND].include?(new_grid[y + 1][x]) &&
                    [START, VERTICAL_PIPE, SOUTH_EAST_BEND, SOUTH_WEST_BEND].include?(new_grid[y - 1][x])

        new_grid[y][x] = VERTICAL_PIPE
      end
    end

    return new_grid
  end

  def part2(input)
    grid = input.split("\n").map(&:chars)
    grid = expand_grid(grid)
    start = []
    grid.each_with_index { |row, y| row.each_with_index { |char, x| start = [x, y] and break if char == START } }
    dfs(grid:, start:)

    answer = 0
    visited = Set.new
    grid.each_with_index do |row, y|
      row.each_with_index do |char, x|
        next if visited.include?([x, y]) || char == VISITED

        to_visit = [[x, y]]
        count = 0
        loop do
          check = to_visit.shift
          break if check.nil?
          next if visited.include?(check)

          visited.add(check)

          a, b = check
          to_add = [[a - 1, b], [a + 1, b],
                    [a, b - 1], [a, b + 1]]

          outside = to_add.any? do |p|
            p[0].negative? || p[1].negative? || p[1] >= grid.length || p[0] >= grid[p[1]].length
          end
          count = 0 and break if outside

          if grid[check[1]][check[0]] == '#'
            to_visit.concat(to_add)
          elsif grid[check[1]][check[0]] != 'V' && a.even? && b.even?
            count += 1
            to_visit.concat(to_add)
          end
        end
        answer += count
      end
    end
    return answer
  end
end
