import objectWithDefault from "./object-with-default.js"

export default function tally(array) {
  return array.reduce(
    (result, value) => {
      result[value] += 1
      return result
    },
    objectWithDefault({}, 0),
  )
}
