import countArray from "#lib/arrays/count-array.js"
import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"

const testCases = [
  {
    answer: 2,
    input: `
      7 6 4 2 1
      1 2 7 8 9
      9 7 6 2 1
      1 3 2 4 5
      8 6 4 4 1
      1 3 6 7 9`,
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
  return countArray(data, isSafe)
}

submit({
  day: 2,
  inputFile: import.meta.url,
  part: 1,
  solution: (args) => pipe(parseInput, solve)(args),
  testCases,
  year: 2024,
})
