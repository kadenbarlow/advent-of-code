import countArray from "#lib/arrays/count-array.js"
import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"

const testCases = [
  {
    answer: 2,
    input: `
        1 1 2
        2 6 1`,
  },
]

function parseInput(args) {
  const { input } = args
  return {
    ...args,
    data: input
      .split("\n")
      .map((line) => line.match(/(\d+)/g))
      .filter(Boolean),
  }
}

function isSafe(row) {
  const differences = []

  for (let i = 1; i < row.length; i++) {
    differences.push(row[i] - row[i - 1])
  }

  const increasing = differences.every((d) => d >= 1 && d <= 3)
  const decreasing = differences.every((d) => d <= -1 && d >= -3)

  return increasing || decreasing
}

function solve(args) {
  const { data } = args

  return countArray(data, (row) => {
    for (let i = 0; i < row.length; i++) {
      const removed = [...row.slice(0, i), ...row.slice(i + 1)]

      if (isSafe(removed)) return true
    }
    return isSafe(row)
  })
}

submit({
  day: 2,
  inputFile: import.meta.url,
  part: 2,
  solution: (args) => pipe(parseInput, solve)(args),
  testCases,
  year: 2024,
})
