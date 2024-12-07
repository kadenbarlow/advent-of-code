import assert from "node:assert"
import addEdgeToGraph from "./add-edge-to-graph.js"
import createGraph from "./create-graph.js"
import deleteEdgeFromGraph from "./delete-edge-from-graph.js"
import deleteNodeFromGraph from "./delete-node-from-graph.js"
import getShortestPath from "./get-shortest-path.js"

const graph = createGraph()
addEdgeToGraph(graph, { from: "a", to: "b", weight: 1 })
addEdgeToGraph(graph, { from: "b", to: "c", weight: 2 })
addEdgeToGraph(graph, { from: "a", to: "c", weight: 1 })
addEdgeToGraph(graph, { from: "c", to: "d", weight: 5 })
addEdgeToGraph(graph, { from: "d", to: "e", weight: 2 })
addEdgeToGraph(graph, { from: "b", to: "e", weight: 2 })

assert.strictEqual(getShortestPath(graph, { from: "a", to: "e" }).distance, 3)
assert.strictEqual(getShortestPath(graph, { from: "a", to: "d" }).distance, 6)
assert.strictEqual(getShortestPath(graph, { from: "b", to: "e" }).distance, 2)
assert.strictEqual(getShortestPath(graph, { from: "e", to: "b" }).distance, Infinity)
assert.deepEqual(getShortestPath(graph, { from: "a", to: "d" }).path, ["a", "c", "d"])

deleteEdgeFromGraph(graph, { from: "a", to: "c" })
assert.strictEqual(getShortestPath(graph, { from: "a", to: "d" }).distance, 8)
deleteNodeFromGraph(graph, "c")
assert.strictEqual(getShortestPath(graph, { from: "a", to: "d" }).distance, Infinity)
