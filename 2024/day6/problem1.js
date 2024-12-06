import getIndexFromArray from "#lib/arrays/get-index-from-array.js"
import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"

const testCases = [
  {
    answer: 41,
    input: `....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...`,
  },
]

function parseInput(args) {
  const { input } = args
  return {
    ...args,
    data: input.split("\n").map((line) => line.split("")),
  }
}

function nextPoint(data, point) {
  const [r, c] = point
  if (data[r][c] === "^") return [r - 1, c]
  if (data[r][c] === ">") return [r, c + 1]
  if (data[r][c] === "v") return [r + 1, c]
  if (data[r][c] === "<") return [r, c - 1]
}

const DIRECTIONS = ["^", ">", "v", "<"]

function path(data, point) {
  while (true) {
    const [r1, c1] = point
    const [r2, c2] = nextPoint(data, point)
    if (!data[r2]?.[c2]) {
      data[r1][c1] = "X"
      return data
    }

    if (data[r2][c2] === "#") {
      data[r1][c1] = getIndexFromArray(DIRECTIONS, DIRECTIONS.findIndex((d) => d === data[r1][c1]) + 1)
    } else {
      data[r2][c2] = data[r1][c1]
      data[r1][c1] = "X"
      point = [r2, c2]
    }
  }
}

function solve(args) {
  const { data } = args
  const start = data.flatMap((row, r) => row.flatMap((col, c) => col === "^" && [r, c])).filter(Boolean)

  return path(data, start).reduce((acc, row) => {
    return (
      acc +
      row.reduce((acc, col) => {
        return acc + (col === "X" ? 1 : 0)
      }, 0)
    )
  }, 0)
}

submit({
  day: 6,
  inputFile: import.meta.url,
  part: 1,
  solution: (args) => pipe(parseInput, solve)(args),
  testCases,
  year: 2024,
})
