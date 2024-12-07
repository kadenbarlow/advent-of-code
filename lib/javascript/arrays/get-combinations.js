export default function getCombinations(array, length) {
  const result = []

  const backtrack = (start, current) => {
    if (current.length === length) {
      result.push([...current])
      return
    }

    for (let i = start; i < array.length; i++) {
      current.push(array[i])
      backtrack(i + 1, current)
      current.pop()
    }
  }

  backtrack(0, [])
  return result
}
