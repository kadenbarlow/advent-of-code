require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      Monkey 0:
        Starting items: 79, 98
        Operation: new = old * 19
        Test: divisible by 23
          If true: throw to monkey 2
          If false: throw to monkey 3

      Monkey 1:
        Starting items: 54, 65, 75, 74
        Operation: new = old + 6
        Test: divisible by 19
          If true: throw to monkey 2
          If false: throw to monkey 0

      Monkey 2:
        Starting items: 79, 60, 97
        Operation: new = old * old
        Test: divisible by 13
          If true: throw to monkey 1
          If false: throw to monkey 3

      Monkey 3:
        Starting items: 74
        Operation: new = old + 3
        Test: divisible by 17
          If true: throw to monkey 0
          If false: throw to monkey 1
    TXT
    @part1_test_answer = 10605

    @part2_test_input = @part1_test_input
    @part2_test_answer = 2713310158
  end

  def parse_input(input)
    monkeys = Hash.new { |hash, key| hash[key] = Hash.new }
    input.split("\n\n").each do |monkey|
      id, starting_items, operation, test, condition_one, condition_two = monkey.split("\n")
      id = id[/.*(\d+)/,1]
      monkeys[id][:items] = starting_items.split(':').last.split(',').map(&:to_i)
      monkeys[id][:operation] = eval("lambda { |old| #{operation.split(':').last} }")
      monkeys[id][:test] = test.split(' ').last.to_i
      monkeys[id][:true] = condition_one[/.*(\d+)/, 1]
      monkeys[id][:false] = condition_two[/.*(\d+)/, 1]
    end
    return monkeys
  end

  def part1(input)
    monkeys = parse_input(input)
    inspections = Hash.new { |hash, key| hash[key] = 0 }

    20.times do
      monkeys.each do |id, monkey|
        monkey[:items].count.times do
          inspections[id] += 1
          item = monkey[:items].shift
          item = monkey[:operation].call(item) / 3
          (item % monkey[:test]).zero? ? monkeys[monkey[:true]][:items] << item : monkeys[monkey[:false]][:items] << item
        end
      end
    end
    return inspections.values.sort.reverse[0..1].reduce(:*)
  end

  def part2(input)
    monkeys = parse_input(input)
    inspections = Hash.new { |hash, key| hash[key] = 0 }
    tests = monkeys.values.map{ _1[:test] }.reduce(:*)

    10000.times do
      monkeys.each do |id, monkey|
        monkey[:items].count.times do
          inspections[id] += 1
          item = monkey[:items].shift
          item = monkey[:operation].call(item) % tests
          (item % monkey[:test]).zero? ? monkeys[monkey[:true]][:items] << item : monkeys[monkey[:false]][:items] << item
        end
      end
    end
    return inspections.values.sort.reverse[0..1].reduce(:*)
  end
end
