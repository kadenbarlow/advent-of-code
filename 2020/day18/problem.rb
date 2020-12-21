require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      1 + 2 * 3 + 4 * 5 + 6
      1 + (2 * 3) + (4 * (5 + 6))
    TXT
    @part1_test_answer = 122

    @part2_test_input = <<~TXT
      1 + 2 * 3 + 4 * 5 + 6
      1 + (2 * 3) + (4 * (5 + 6))
    TXT
    @part2_test_answer = 282
  end

  def evaluate_part1(equation)
    equation = equation.split(' ')
    while equation.index('*') || equation.index('+')
      value = eval(equation[0..2].join(''))
      equation[0..2] = [value]
    end
    return equation.first.to_i
  end

  def solve_equation(equation, evaluate)
    while equation.index('(')
      closing = equation.index(')')
      opening = equation[0..closing].rindex('(')
      equation[opening..closing] = evaluate.call(equation[(opening + 1)...closing]).to_s
    end
    return evaluate.call(equation)
  end

  def part1(input)
    input.split("\n")
         .map { |equation| solve_equation(equation, method(:evaluate_part1)) }
         .reduce(&:+)
  end

  def evaluate_part2(equation)
    equation = equation.split(' ')
    operators = ['+', '*']
    operators.each do |operator|
      while equation.index(operator)
        index_of_operator = equation.index(operator)
        opening = index_of_operator - 1
        closing = index_of_operator + 1

        value = eval(equation[opening..closing].join(''))
        equation[opening..closing] = [value]
      end
    end
    return equation.first.to_i
  end

  def part2(input)
    input.split("\n")
         .map { |equation| solve_equation(equation, method(:evaluate_part2)) }
         .reduce(&:+)
  end
end
