require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
          [D]
      [N] [C]
      [Z] [M] [P]
       1   2   3

      move 1 from 2 to 1
      move 3 from 1 to 3
      move 2 from 2 to 1
      move 1 from 1 to 2
    TXT
    @part1_test_answer = 'CMZ'

    @part2_test_input = <<~TXT
          [D]
      [N] [C]
      [Z] [M] [P]
       1   2   3

      move 1 from 2 to 1
      move 3 from 1 to 3
      move 2 from 2 to 1
      move 1 from 1 to 2
    TXT
    @part2_test_answer = 'MCD'
  end

  def parse_input(input)
    boxes = Hash.new { |hash, key| hash[key] = [] } # {"1"=>["Z", "N"], "2"=>["M", "C", "D"], "3"=>["P"]}
    index = {} # {1=>"1", 5=>"2", 9=>"3"} the indexes corresponding to the box names on each line
    box_input, instructions = input.split("\n\n")

    box_input.split("\n").last.chars.each_with_index { |letter, i| index[i] = letter unless letter.to_i.zero? }
    box_input.split("\n")
             .reverse[1..] # Remove the lines with the indexes
             .each { |line| index.each { |k, v| boxes[v] << line[k] if line[k]&.match?(/[A-Za-z]/) } }

    return boxes, instructions
  end

  def part1(input)
    boxes, instructions = parse_input(input)
    instructions.split("\n").each do |instruction|
      move, from, to = instruction.scan(/\d+/)
      move.to_i.times { boxes[to] << boxes[from].pop }
    end
    boxes.values.map(&:last).join
  end

  def part2(input)
    boxes, instructions = parse_input(input)
    instructions.split("\n").each do |instruction|
      move, from, to = instruction.scan(/\d+/)
      boxes[to] = boxes[to].concat(boxes[from].pop(move.to_i))
    end
    boxes.values.map(&:last).join
  end
end
