import createObjectWithDefault from "./create-object-with-default.js"

export default function invertObjectSafely(obj) {
  return Object.entries(obj).reduce(
    (result, [key, value]) => {
      result[value].push(key)
      return result
    },
    createObjectWithDefault({}, []),
  )
}
