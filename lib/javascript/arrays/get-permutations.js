export default function getPermutations(array, length) {
  const result = []

  const backtrack = (current) => {
    if (current.length === length) {
      result.push(current.join(""))
      return
    }

    array.forEach((item) => backtrack([...current, item]))
  }

  backtrack([])
  return result
}
