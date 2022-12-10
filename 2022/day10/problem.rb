require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      addx 15
      addx -11
      addx 6
      addx -3
      addx 5
      addx -1
      addx -8
      addx 13
      addx 4
      noop
      addx -1
      addx 5
      addx -1
      addx 5
      addx -1
      addx 5
      addx -1
      addx 5
      addx -1
      addx -35
      addx 1
      addx 24
      addx -19
      addx 1
      addx 16
      addx -11
      noop
      noop
      addx 21
      addx -15
      noop
      noop
      addx -3
      addx 9
      addx 1
      addx -3
      addx 8
      addx 1
      addx 5
      noop
      noop
      noop
      noop
      noop
      addx -36
      noop
      addx 1
      addx 7
      noop
      noop
      noop
      addx 2
      addx 6
      noop
      noop
      noop
      noop
      noop
      addx 1
      noop
      noop
      addx 7
      addx 1
      noop
      addx -13
      addx 13
      addx 7
      noop
      addx 1
      addx -33
      noop
      noop
      noop
      addx 2
      noop
      noop
      noop
      addx 8
      noop
      addx -1
      addx 2
      addx 1
      noop
      addx 17
      addx -9
      addx 1
      addx 1
      addx -3
      addx 11
      noop
      noop
      addx 1
      noop
      addx 1
      noop
      noop
      addx -13
      addx -19
      addx 1
      addx 3
      addx 26
      addx -30
      addx 12
      addx -1
      addx 3
      addx 1
      noop
      noop
      noop
      addx -9
      addx 18
      addx 1
      addx 2
      noop
      noop
      addx 9
      noop
      noop
      noop
      addx -1
      addx 2
      addx -37
      addx 1
      addx 3
      noop
      addx 15
      addx -21
      addx 22
      addx -6
      addx 1
      noop
      addx 2
      addx 1
      noop
      addx -10
      noop
      noop
      addx 20
      addx 1
      addx 2
      addx 2
      addx -6
      addx -11
      noop
      noop
      noop
    TXT
    @part1_test_answer = 13_140

    @part2_test_input = @part1_test_input
    @part2_test_answer = <<~ANSWER
      ##..##..##..##..##..##..##..##..##..##..
      ###...###...###...###...###...###...###.
      ####....####....####....####....####....
      #####.....#####.....#####.....#####.....
      ######......######......######......####
      #######.......#######.......#######.....
    ANSWER
  end

  def part1(input)
    register = 1
    cycles = 0
    sum = 0
    input.split("\n").each do |instruction|
      if instruction.include?('noop')
        cycles += 1
        sum += (register * cycles) if cycles == 20 || (cycles - 20) % 40 == 0
        next
      end

      next unless instruction.include?('addx')

      cycles += 1
      sum += (register * cycles) if cycles == 20 || (cycles - 20) % 40 == 0
      cycles += 1
      sum += (register * cycles) if cycles == 20 || (cycles - 20) % 40 == 0
      register += instruction.split(' ').last.to_i
    end

    return sum
  end

  def part2(input)
    register = 1
    cycles = 0
    result = ''
    input.split("\n").each do |instruction|
      if instruction.include?('noop')
        result += (register - 1..register + 1).member?(cycles % 40) ? '#' : '.'
        cycles += 1
        result += "\n" if cycles % 40 == 0
        next
      end

      next unless instruction.include?('addx')

      result += (register - 1..register + 1).member?(cycles % 40) ? '#' : '.'
      cycles += 1
      result += "\n" if cycles % 40 == 0
      result += (register - 1..register + 1).member?(cycles % 40) ? '#' : '.'
      cycles += 1
      result += "\n" if cycles % 40 == 0
      register += instruction.split(' ').last.to_i
    end

    return result
  end
end
