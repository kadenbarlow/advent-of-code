require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      b inc 5 if a > 1
      a inc 1 if b < 5
      c dec -10 if a >= 1
      c inc -20 if c == 10
    TXT
    @part1_test_answer = 1

    @part2_test_input = <<~TXT
      b inc 5 if a > 1
      a inc 1 if b < 5
      c dec -10 if a >= 1
      c inc -20 if c == 10
    TXT
    @part2_test_answer = 10
  end

  def part1(input)
    max = 0
    variables = input.split("\n").map{ _1.split(' ').first }.uniq
    operations = input.gsub('inc', '+=').gsub('dec', '-=').split("\n")
    variables.each { operations.prepend("#{_1} = 0") }
    operations << "max = [#{variables.join(', ')}].max"
    eval(operations.join("\n"))
    return max
  end

  def part2(input)
    max = 0
    variables = input.split("\n").map{ _1.split(' ').first }.uniq
    operations = input.gsub('inc', '+=').gsub('dec', '-=').split("\n")
    operations = operations.zip(Array.new(operations.length, "max = [max, #{variables.join(', ')}].max"))
    variables.each { operations.prepend("#{_1} = 0") }
    eval(operations.join("\n"))
    return max
  end
end
