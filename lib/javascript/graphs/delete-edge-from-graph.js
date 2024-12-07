export default function deleteEdgeFromGraph(graph, { from, to }) {
  delete graph[from].edges[to]
  delete graph[from].weights[to]
}
