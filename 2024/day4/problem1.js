import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"

const testCases = [
  {
    answer: 18,
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

function countWords(data, word, pos, next) {
  const [row, col] = pos

  if (!data[row]) return 0
  else if (!data[row][col]) return 0
  else if (data[row][col] !== word[0]) return 0
  else if (word.length === 1) return 1
  else return countWords(data, word.slice(1), next(pos), next)
}

function solve(args) {
  const { data } = args

  return data.reduce((acc, line, row) => {
    return (
      acc +
      line.reduce((acc, _letter, col) => {
        return (
          acc +
          countWords(data, "XMAS", [row, col], ([r, c]) => [r, c + 1]) +
          countWords(data, "XMAS", [row, col], ([r, c]) => [r, c - 1]) +
          countWords(data, "XMAS", [row, col], ([r, c]) => [r + 1, c]) +
          countWords(data, "XMAS", [row, col], ([r, c]) => [r - 1, c]) +
          countWords(data, "XMAS", [row, col], ([r, c]) => [r + 1, c + 1]) +
          countWords(data, "XMAS", [row, col], ([r, c]) => [r - 1, c - 1]) +
          countWords(data, "XMAS", [row, col], ([r, c]) => [r + 1, c - 1]) +
          countWords(data, "XMAS", [row, col], ([r, c]) => [r - 1, c + 1])
        )
      }, 0)
    )
  }, 0)
}

submit({
  day: 4,
  inputFile: import.meta.url,
  part: 1,
  solution: (args) => pipe(parseInput, solve)(args),
  testCases,
  year: 2024,
})
