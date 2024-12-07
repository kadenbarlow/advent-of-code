import runDijkstrasAlgorithm from "./run-dijkstras-algorithm.js"

export default function getShortestPath(graph, { from, to }) {
  const path = []
  const { previous } = runDijkstrasAlgorithm(graph, from)
  if (!previous[to]) return { distance: Infinity, path }

  let distance = 0
  let target = to
  while (target) {
    path.push(target)
    target = previous[target]
    const weight = graph[target].weights[path[path.length - 1]]
    if (weight) distance += weight
  }

  return { distance, path: path.reverse() }
}
