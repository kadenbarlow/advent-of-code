import createObjectWithDefault from "#lib/objects/create-object-with-default.js"
import invertObjectSafely from "#lib/objects/invert-object-safely.js"

export default function runDijkstrasAlgorithm(graph, from) {
  const distances = createObjectWithDefault({}, Infinity)
  const previous = createObjectWithDefault({}, null)
  const nodes = Object.keys(graph)

  nodes.forEach((node) => distances[node] && previous[node])
  distances[from] = 0

  while (nodes.length > 0) {
    const minDistances = nodes.reduce((acc, node) => {
      acc[node] = distances[node]
      return acc
    }, {})
    const min = Math.min(...Object.values(minDistances))
    const node = invertObjectSafely(minDistances)[min][0]
    nodes.splice(nodes.indexOf(node), 1)

    Object.keys(graph[node].edges).forEach((neighbor) => {
      const distance = distances[node] + graph[node].weights[neighbor]
      if (distance < distances[neighbor]) {
        distances[neighbor] = distance
        previous[neighbor] = node
      }
    })
  }

  return { distances, previous }
}
