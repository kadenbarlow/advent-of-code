require 'byebug'
require_relative '../../lib/graph'
require_relative '../../lib/array'

class Solution < AbstractSolution
  def initialize
    super
    @part1_test_cases = [
      {
        answer: 2,
        input: <<~TXT
          RL

          AAA = (BBB, CCC)
          BBB = (DDD, EEE)
          CCC = (ZZZ, GGG)
          DDD = (DDD, DDD)
          EEE = (EEE, EEE)
          GGG = (GGG, GGG)
          ZZZ = (ZZZ, ZZZ)
        TXT
      }
    ]

    @part2_test_cases = [
      {
        answer: 6,
        input: <<~TXT
          LR

          11A = (11B, XXX)
          11B = (XXX, 11Z)
          11Z = (11B, XXX)
          22A = (22B, XXX)
          22B = (22C, 22C)
          22C = (22Z, 22Z)
          22Z = (22B, 22B)
          XXX = (XXX, XXX)
        TXT
      }
    ]
  end

  def parse_graph(input)
    pattern = input.split("\n").first
    graph = Graph.new
    input.split("\n")[2..].each do |node|
      name, left, right = node.scan(/(\w+) = \((\w+), (\w+)\)/).first
      graph.add_edge(from: name, to: left, weight: 1) if name != left
      graph.add_edge(from: name, to: right, weight: 1) if name != right
    end
    return pattern, graph
  end

  def part1(input)
    pattern, graph = parse_graph(input)
    return graph.shortest_path(from: 'AAA', to: 'ZZZ')[1].lcm(pattern.length)
  end

  def part2(input)
    pattern, graph = parse_graph(input)
    start_nodes = graph.nodes.select { _1.end_with?('A') }
    end_nodes = graph.nodes.select { _1.end_with?('Z') }
    start_nodes.reduce(pattern.length) do |answer, start_node|
      end_nodes.each do |end_node|
        shortest_path = graph.shortest_path(from: start_node, to: end_node)
        answer = answer.lcm(shortest_path[1]) if shortest_path
      end
      answer
    end
  end
end
