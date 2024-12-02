export default function invertObject(obj) {
  return Object.entries(obj).reduce((result, [key, value]) => {
    result[value] = key
    return result
  }, {})
}
