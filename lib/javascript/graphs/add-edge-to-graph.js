export default function addEdgeToGraph(graph, { from, to, weight }) {
  graph[from].edges[to] = graph[to]
  graph[from].weights[to] = weight
  return graph[from]
}
