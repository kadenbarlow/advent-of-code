import objectWithDefault from "./object-with-default.js"

export default function safeInvert(obj) {
  return Object.entries(obj).reduce(
    (result, [key, value]) => {
      result[value].push(key)
      return result
    },
    objectWithDefault({}, []),
  )
}
