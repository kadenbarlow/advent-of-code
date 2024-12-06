import getIndexFromArray from "#lib/arrays/get-index-from-array.js"
import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"

const DIRECTIONS = ["^", ">", "v", "<"]

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

function path(data, point) {
  const set = {}
  let repeat = 0
  while (true) {
    const [r1, c1] = point
    const [r2, c2] = nextPoint(data, point)
    if (!data[r2]?.[c2]) return false
    else if (repeat > 750) return true // This is the hackiest way to detect a cycle

    if (data[r2][c2] === "#") {
      data[r1][c1] = getIndexFromArray(DIRECTIONS, DIRECTIONS.findIndex((d) => d === data[r1][c1]) + 1)
    } else {
      if (set[[r1, c1]]) repeat++
      set[[r1, c1]] = true
      data[r2][c2] = data[r1][c1]
      data[r1][c1] = "X"
      point = [r2, c2]
    }
  }
}

function adjacentToPath(data, point) {
  const [r, c] = point
  const adj =
    data[r - 1]?.[c] === "X" || data[r + 1]?.[c] === "X" || data[r]?.[c - 1] === "X" || data[r]?.[c + 1] === "X"
  return adj
}

function solve(args) {
  const { data } = args
  const start = data.flatMap((row, r) => row.flatMap((col, c) => col === "^" && [r, c])).filter(Boolean)
  const [r1, c1] = start
  const originalPath = [...data.map((row) => [...row])]
  path(originalPath, start)

  return data.reduce((acc, row, r2) => {
    return (
      acc +
      row.reduce((acc, _col, c2) => {
        if (r1 === r2 && c1 === c2) return acc
        else if (data[r2][c2] === "#") return acc
        else if (!adjacentToPath(originalPath, [r2, c2])) return acc

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
