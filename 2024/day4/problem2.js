import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"

const testCases = [
  {
    answer: 9,
    input: `
      MMMSXXMASM
      MSAMXMSMSA
      AMXSXMAAMM
      MSAMASMSMX
      XMASAMXAMM
      XXAMMXXAMA
      SMSMSASXSS
      SAXAMASAAA
      MAMMMXMMMM
      MXMXAXMASX`,
  },
]

function parseInput(args) {
  const { input } = args
  return {
    ...args,
    data: input
      .split("\n")
      .map((line) => line.match(/[a-zA-Z]/g))
      .filter(Boolean),
  }
}

function isXMAS(data, pos) {
  const [row, col] = pos
  const middle = data[row]?.[col]
  const diagnol1 = [data[row + 1]?.[col + 1], data[row - 1]?.[col - 1]].filter(Boolean)
  const diagnol2 = [data[row - 1]?.[col + 1], data[row + 1]?.[col - 1]].filter(Boolean)

  return (
    middle === "A" &&
    diagnol1.includes("M") &&
    diagnol2.includes("S") &&
    diagnol2.includes("M") &&
    diagnol1.includes("S")
  )
}

function solve(args) {
  const { data } = args

  return data.reduce((acc, line, row) => {
    return (
      acc +
      line.reduce((acc, _letter, col) => {
        return acc + isXMAS(data, [row, col])
      }, 0)
    )
  }, 0)
}

submit({
  day: 4,
  inputFile: import.meta.url,
  part: 2,
  solution: (args) => pipe(parseInput, solve)(args),
  testCases,
  year: 2024,
})
