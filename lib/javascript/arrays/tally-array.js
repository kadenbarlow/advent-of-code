import createObjectWithDefault from "./create-object-with-default.js"

export default function tallyArray(array) {
  return array.reduce(
    (tally, value) => {
      tally[value] += 1
      return tally
    },
    createObjectWithDefault({}, 0),
  )
}
