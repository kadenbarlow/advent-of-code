export default function countArray(array, fn) {
  return array.reduce((acc, value, index) => {
    if (fn(value, index)) acc++
    return acc
  }, 0)
}
