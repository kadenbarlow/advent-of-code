import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"
import tally from "#lib/tally.js"

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
        (acc, [a, b]) => {
          acc[0].push(a)
          acc[1].push(b)
          return acc
        },
        [[], []],
      ),
  }
}

function solve(args) {
  const { data } = args
  const left = tally(data[0])
  const right = tally(data[1])

  return Object.keys(left).reduce((acc, key) => acc + parseInt(key) * left[key] * right[key], 0)
}

submit({
  day: 1,
  inputFile: import.meta.url,
  part: 2,
  solution: (args) => pipe(parseInput, solve)(args),
  testCases,
  year: 2024,
})
