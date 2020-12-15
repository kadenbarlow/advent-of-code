#! /usr/bin/env ruby

require 'optparse'
require 'date'
require './abstract_solution.rb'

def main(options)
  day = ARGV[0]
  year = options[:year] || Date.today.year

  if options[:generate]
    `./get-problem.sh #{year} #{day}`
  else
    directory = "#{year}/day#{day}"
    require "./#{year}/day#{day}/problem.rb"
    f = File.open("#{directory}/input.txt")
    Solution.new.solve(f.read, skip_test_cases: options[:skip])
  end
end

options = {}
OptionParser.new do |opts|
  opts.banner = 'Usage: solve.rb 12'
  opts.on('-yYEAR', '--year YEAR', 'Year (Defaults to Current Year)') { |y| options[:year] = y }
  opts.on('-g', '--get-problem', 'Download Problem and Set Up Directory') { options[:generate] = true }
  opts.on('-s', '--skip', 'Skip Test Cases') { options[:skip] = true }
end.parse!

main options
