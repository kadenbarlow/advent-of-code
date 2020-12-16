require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      class: 1-3 or 5-7
      row: 6-11 or 33-44
      seat: 13-40 or 45-50

      your ticket:
      7,1,14

      nearby tickets:
      7,3,47
      40,4,50
      55,2,20
      38,6,12
    TXT
    @part1_test_answer = 71

    @part2_test_input  = <<~TXT
    TXT
    @part2_test_answer = nil
  end

  def part1(input)
    sections = input.split("\n\n")
    inputs = []
    sections.first.split("\n").each do |rule|
      rule.scan(/(\d*-\d*)/).flatten.each do |range|
        values = range.split('-').map(&:to_i)
        inputs << (values[0]..values[1])
      end
    end

    invalid_inputs = []
    sections.last.split("\n")[1..].each do |ticket|
      values = ticket.split(',').map(&:to_i)
      values.each do |num|
        invalid_inputs << num unless inputs.any? { |range| range.include?(num) }
      end
    end
    return invalid_inputs.reduce(:+)
  end

  def part2(input)
    sections = input.split("\n\n")
    inputs = {}
    sections.first.split("\n").each do |rule|
      key = rule[/([a-zA-Z\s]*):/, 1]
      inputs[key] = []

      rule.scan(/(\d*-\d*)/).flatten.each do |range|
        values = range.split('-').map(&:to_i)
        inputs[key] << (values[0]..values[1])
      end
    end
    input_ranges = inputs.values.flatten

    # Create a list of possible fields at each location
    possible_fields = {}
    sections.last.split("\n")[1..].each do |ticket|
      values = ticket.split(',').map(&:to_i)

      # Check to see if the ticket is even valid
      valid = true
      values.each { |num| valid = false unless input_ranges.any? { |range| range.include?(num) } }
      next unless valid

      values.each_with_index do |num, index|
        options = []
        inputs.each { |key, ranges| ranges.each { |range| options << key if range.include? num } }
        possible_fields[index].nil? ? possible_fields[index] = options : possible_fields[index] &= options
      end
    end

    positions = {}
    departure_locations = []

    # Now deduce which field is actually in each spot by working backwards from the fields we know
    # each time we iterate there should be a new field that has a single possibility left
    until possible_fields.keys.empty?
      counts = Hash.new { |hash, key| hash[key] = Array.new }
      possible_fields.each { |key, value| counts[value.length] << key }

      known_position = counts[counts.keys.min].first
      known_field = possible_fields[known_position]
      positions[known_position] = known_field[0]
      possible_fields.delete(known_position)

      departure_locations << known_position if known_field[0].include?('departure')

      # Further narrow down the options by removing it from the positions we don't know yet
      possible_fields.each { |key, value| possible_fields[key] -= known_field unless value.length == 1 }
    end

    my_ticket = sections[1].split("\n")[1].split(',').map(&:to_i)
    return departure_locations.map{ |location| my_ticket[location] }.reduce(:*)
  end
end
