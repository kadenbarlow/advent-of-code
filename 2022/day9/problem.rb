require 'byebug'
require 'set'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      R 4
      U 4
      L 3
      D 1
      R 4
      D 1
      L 5
      R 2
    TXT
    @part1_test_answer = 13

    @part2_test_input = <<~TXT
      R 5
      U 8
      L 8
      D 3
      R 17
      D 10
      L 25
      U 20
    TXT
    @part2_test_answer = 36
  end

  def move_tail(head, tail)
    x_diff = head[0] - tail[0]
    y_diff = head[1] - tail[1]
    move_x = (x_diff.positive? ? 1 : -1)
    move_y = (y_diff.positive? ? 1 : -1)
    return tail unless [x_diff.abs, y_diff.abs].max == 2

    return [tail[0] + move_x, tail[1] + move_y] if [x_diff.abs, y_diff.abs].sum >= 3
    return [tail[0] + move_x, tail[1]] if x_diff.abs == 2
    return [tail[0], tail[1] + move_y] if y_diff.abs == 2
  end

  def move_head(head, direction)
    case direction
    when 'R'
      return [head[0] + 1, head[1]]
    when 'U'
      return [head[0], head[1] + 1]
    when 'L'
      return [head[0] - 1, head[1]]
    when 'D'
      return [head[0], head[1] - 1]
    end
  end

  def part1(input)
    points = Set.new
    head = [0, 0]
    tail = [0, 0]

    input.split("\n").each do |move|
      direction, steps = move.split(' ')
      steps.to_i.times do |_step|
        head = move_head(head, direction)
        tail = move_tail(head, tail)
        points << tail
      end
    end
    return points.count
  end

  def part2(input)
    points = Set.new
    head = [0, 0]
    tail = []
    9.times { tail << [0, 0] }

    input.split("\n").each_with_index do |move, i|
      direction, steps = move.split(' ')
      steps.to_i.times do
        head = move_head(head, direction)
        tail.each_index do |index|
          tail[index] = move_tail(index.zero? ? head : tail[index - 1], tail[index])
          points << tail[8]
        end
      end
    end
    return points.count
  end
end
