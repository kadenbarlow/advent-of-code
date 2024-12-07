import createObjectWithDefault from "#lib/objects/create-object-with-default.js"

export default function createGraph() {
  return createObjectWithDefault({}, (key) => ({
    edges: {},
    name: key,
    weights: {},
  }))
}
