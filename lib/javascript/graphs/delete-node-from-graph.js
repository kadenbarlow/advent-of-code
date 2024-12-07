export default function deleteNodeFromGraph(graph, name) {
  delete graph[name]
  Object.values(graph).forEach((node) => {
    delete node.edges[name]
    delete node.weights[name]
  })
}
