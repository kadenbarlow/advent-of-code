require 'byebug'
class String
  def black;          "\e[30m#{self}\e[0m" end
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def brown;          "\e[33m#{self}\e[0m" end
  def blue;           "\e[34m#{self}\e[0m" end
  def magenta;        "\e[35m#{self}\e[0m" end
  def cyan;           "\e[36m#{self}\e[0m" end
  def gray;           "\e[37m#{self}\e[0m" end

  def bg_black;       "\e[40m#{self}\e[0m" end
  def bg_red;         "\e[41m#{self}\e[0m" end
  def bg_green;       "\e[42m#{self}\e[0m" end
  def bg_brown;       "\e[43m#{self}\e[0m" end
  def bg_blue;        "\e[44m#{self}\e[0m" end
  def bg_magenta;     "\e[45m#{self}\e[0m" end
  def bg_cyan;        "\e[46m#{self}\e[0m" end
  def bg_gray;        "\e[47m#{self}\e[0m" end

  def bold;           "\e[1m#{self}\e[22m" end
  def italic;         "\e[3m#{self}\e[23m" end
  def underline;      "\e[4m#{self}\e[24m" end
  def blink;          "\e[5m#{self}\e[25m" end
  def reverse_color;  "\e[7m#{self}\e[27m" end
end

class AbstractSolution
  def solve(input, skip_test_cases: false)
    unless skip_test_cases
      pass = true
      pass &= test(@part1_test_input, @part1_test_answer, method(:part1), 1) unless @part1_test_answer.nil?
      pass &= test(@part2_test_input, @part2_test_answer, method(:part2), 2) unless @part2_test_answer.nil?
      if pass
        puts 'All Test Cases Passed!'.green.bold
      else
        puts "TEST CASES FAILED!\n".red.bold
      end
      return unless pass
    end

    puts "\n" unless skip_test_cases
    run(input, method(:part1), 1)
    run(input, method(:part2), 2)
  end

  def run(input, method, number)
    start_time = Time.now
    result = method.call(input)
    end_time = Time.now
    ms = ((end_time - start_time) * 1000).round(3)

    puts "Part #{number}: #{result.to_s.magenta.bold} in #{ms} ms"
  end

  def test(input, answer, method, number)
    start_time = Time.now
    result = method.call(input)
    end_time = Time.now

    pass = result == answer
    ms = ((end_time - start_time) * 1000).round(3)

    puts "Test #{number}: #{pass ? 'Pass'.green : 'Fail'.red} in #{ms} ms"
    puts "Expected: #{answer.to_s.green}, Got: #{result.to_s.red}\n\n" unless pass

    return pass
  end
end
