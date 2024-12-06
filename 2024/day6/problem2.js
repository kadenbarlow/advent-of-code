import getIndexFromArray from "#lib/arrays/get-index-from-array.js"
import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"

const testCases = [
  {
    answer: 6,
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
  const set = {}
  let count = 0
  while (true) {
    const [r1, c1] = point
    set[[r1, c1]] = true
    const [r2, c2] = nextPoint(data, point)
    if (!data[r2]?.[c2]) return false
    else if (count - Object.keys(set).length > 50) return true

    if (data[r2][c2] === "#") {
      data[r1][c1] = getIndexFromArray(DIRECTIONS, DIRECTIONS.findIndex((d) => d === data[r1][c1]) + 1)
    } else {
      count++
      data[r2][c2] = data[r1][c1]
      data[r1][c1] = "X"
      point = [r2, c2]
    }
  }
}

function solve(args) {
  const { data } = args
  const start = data.flatMap((row, r) => row.flatMap((col, c) => col === "^" && [r, c])).filter(Boolean)
  const [r1, c1] = start

  return data.reduce((acc, row, r2) => {
    return (
      acc +
      row.reduce((acc, _col, c2) => {
        if (r1 === r2 && c1 === c2) return acc

        const map = [...data.map((row) => [...row])]
        map[r2][c2] = "#"
        return acc + (path(map, start) ? 1 : 0)
      }, 0)
    )
  }, 0)
}

submit({
  day: 6,
  inputFile: import.meta.url,
  part: 2,
  solution: (args) => pipe(parseInput, solve)(args),
  testCases,
  year: 2024,
})
