import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"

const testCases = [
  {
    answer: 31,
    input: `
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3`,
  },
]

function parseInput(args) {
  const { input } = args
  return {
    ...args,
    data: input
      .split("\n")
      .map((line) => line.match(/(\d+)/g)?.map(Number))
      .filter(Boolean)
      .reduce(
        (acc, numbers) => {
          numbers.forEach((n, i) => {
            acc[i][n] ??= 0
            acc[i][n] += 1
          })
          return acc
        },
        [{}, {}],
      ),
  }
}

function solve(args) {
  const { data } = args
  const [left, right] = data

  return Object.keys(left).reduce((acc, key) => acc + parseInt(key) * left[key] * (right[key] || 0), 0)
}

submit({
  day: 1,
  inputFile: import.meta.url,
  part: 2,
  solution: (args) => pipe(parseInput, solve)(args),
  testCases,
  year: 2024,
})
