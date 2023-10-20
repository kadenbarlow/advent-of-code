require 'byebug'
require 'uri'
require 'net/http'

class String
  def black = "\e[30m#{self}\e[0m"
  def red = "\e[31m#{self}\e[0m"
  def green = "\e[32m#{self}\e[0m"
  def brown = "\e[33m#{self}\e[0m"
  def blue = "\e[34m#{self}\e[0m"
  def magenta = "\e[35m#{self}\e[0m"
  def cyan = "\e[36m#{self}\e[0m"
  def gray = "\e[37m#{self}\e[0m"

  def bg_black = "\e[40m#{self}\e[0m"
  def bg_red = "\e[41m#{self}\e[0m"
  def bg_green = "\e[42m#{self}\e[0m"
  def bg_brown = "\e[43m#{self}\e[0m"
  def bg_blue = "\e[44m#{self}\e[0m"
  def bg_magenta = "\e[45m#{self}\e[0m"
  def bg_cyan = "\e[46m#{self}\e[0m"
  def bg_gray = "\e[47m#{self}\e[0m"

  def bold = "\e[1m#{self}\e[22m"
  def italic = "\e[3m#{self}\e[23m"
  def underline = "\e[4m#{self}\e[24m"
  def blink = "\e[5m#{self}\e[25m"
  def reverse_color = "\e[7m#{self}\e[27m"
end

class AbstractSolution
  def solve(input, year:, day:, skip_test_cases: false)
    unless skip_test_cases
      pass = true
      test_case = 0
      unless @part1_test_cases.nil? || @part1_test_cases.empty?
        pass &= @part1_test_cases.all? do |test|
          test_case += 1
          test(test[:input], test[:answer], method(:part1), test_case)
        end
      end

      unless @part2_test_cases.nil? || @part2_test_cases.empty?
        pass &= @part2_test_cases.all? do |test|
          test_case += 1
          test(test[:input], test[:answer], method(:part2), test_case)
        end
      end

      # Single test inputs and answers are deprecated but are left here for backwards compatibility
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
    part1 = run(input, method(:part1), 1)
    part2 = run(input, method(:part2), 2)

    print 'Submit Answer? [Y/N] '
    submit = STDIN.gets.chomp
    return unless submit.downcase == 'y'

    answer = @part2_test_answer.nil? && (@part2_test_cases.nil? || @part2_test_cases.empty?) ? part1 : part2

    url = URI("https://adventofcode.com/#{year}/day/#{day}/answer")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request['Content-Type'] = 'application/x-www-form-urlencoded'
    request['Cookie'] = "session=#{ENV.fetch('SESSION_COOKIE', nil)};"
    request.body = "level=#{answer == part1 ? '1' : '2'}&answer=#{answer}"
    response = https.request(request)

    if response.read_body.include?('not the right answer')
      puts "#{answer.to_s.magenta.bold} was #{'incorrect!'.red}\n\n"
    else
      puts "#{answer.to_s.magenta.bold} was #{'correct!'.green}\n\n"
    end
  end

  def run(input, method, number)
    start_time = Time.now
    result = method.call(input)
    end_time = Time.now
    ms = ((end_time - start_time) * 1000).round(3)

    puts "Part #{number}: #{result.to_s.magenta.bold} in #{ms} ms"
    return result
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
