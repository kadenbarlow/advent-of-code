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

function checkLevels(row, comparison) {
  return row.every((n, index) => {
    if (index === row.length - 1) return true
    const a = parseInt(n)
    const b = parseInt(row[index + 1])

    return comparison(a - b)
  })
}

function solve(args) {
  const { data } = args

  return data.reduce((acc, row) => {
    if (checkLevels(row, (n) => n > 0 && n <= 3)) acc++
    else if (checkLevels(row, (n) => n < 0 && n >= -3)) acc++

    return acc
  }, 0)
}

submit({
  day: 2,
  inputFile: import.meta.url,
  part: 1,
  solution: (args) => pipe(parseInput, solve)(args),
  testCases,
  year: 2024,
})
