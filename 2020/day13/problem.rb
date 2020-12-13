require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      939
      7,13,x,x,59,x,31,19
    TXT
    @part1_test_answer = 295

    @part2_test_input = <<~TXT
      939
      7,13,x,x,59,x,31,19
    TXT
    @part2_test_answer = 1_068_781
  end

  def part1(input)
    lines = input.split("\n")
    earliest_departure = lines.first.to_i
    bus_ids = (lines[1].split(',') - ['x']).map(&:to_i)

    departure = earliest_departure
    bus_id = nil
    Kernel.loop do
      bus_id = bus_ids.find { |id| (departure % id).zero? }
      break if bus_id

      departure += 1
    end
    return (departure - earliest_departure) * bus_id
  end

  def part2(input)
    lines = input.split("\n")
    bus_ids = lines[1].split(',')
    bus_ids_ints = (bus_ids - ['x']).map(&:to_i)
    period = bus_ids_ints.first
    departure = 0
    bus_ids_ints.each_with_index do |_, index|
      next_bus_id = bus_ids_ints[index + 1]
      departure += period while (departure + bus_ids.index(next_bus_id.to_s)) % next_bus_id != 0
      break if index == bus_ids_ints.length - 2

      first = departure
      departure += period
      departure += period while (departure + bus_ids.index(next_bus_id.to_s)) % next_bus_id != 0
      period = departure - first
    end
    return departure
  end
end
