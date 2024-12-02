import objectWithDefault from "./with-default.js"

export default function tally(array) {
  return array.reduce(
    (tally, value) => {
      tally[value] += 1
      return tally
    },
    objectWithDefault({}, 0),
  )
}
