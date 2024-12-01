require_relative './hash'
require 'byebug'

class Graph
  def initialize
    @graph = Hash.new { |hash, key| hash[key] = GraphNode.new(name: key) }
  end

  def add_edge(from:, to:, weight:)
    @graph[from].edges[to] = @graph[to]
    @graph[from].weights[to] = weight
    return @graph[from]
  end

  def delete_edge(from:, to:)
    @graph[from].edges.delete(to)
    @graph[from].weights.delete(to)
  end

  def delete_node(name)
    @graph.delete(name)
    @graph.values
          .select { _1.edges[name] }
          .each do _1.edges.delete(name)
                   _1.weights.delete(name) end
  end

  def node(name) = @graph[name]
  def nodes = @graph.keys
  def to_h = @graph

  def dijkstras_algorithm(from:)
    distances = Hash.new { |hash, key| hash[key] = Float::INFINITY }
    previous = Hash.new { |hash, key| hash[key] = nil }
    @graph.each_key { distances[_1] && previous[_1] }
    distances[from] = 0
    nodes = @graph.keys.to_set

    until nodes.empty?
      min_distances = distances.values.sort
      options = distances.slice(*nodes).safe_invert
      min_distance = min_distances.find { !options[_1].nil? }
      node = options[min_distance].first
      nodes.delete(node)

      @graph[node].neighbors.each do |neighbor|
        distance = distances[node] + @graph[node].weights[neighbor]
        if distance < distances[neighbor]
          distances[neighbor] = distance
          previous[neighbor] = node
        end
      end
    end

    return distances, previous
  end

  def shortest_path(from:, to:)
    _, previous = dijkstras_algorithm(from:)
    distance = 0
    path = []
    target = to
    return nil unless previous[target]

    while target
      path << target
      target = previous[target]
      distance += @graph[target].weights[path.last] if @graph[target].weights[path.last]
    end

    return path, distance
  end
end

class GraphNode
  attr_accessor :name, :edges, :weights

  def initialize(name:)
    @name = name
    @edges = {}
    @weights = {}
  end

  def neighbors = @edges.keys
end
