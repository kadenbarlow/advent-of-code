import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"

const testCases = [
  {
    answer: 3,
    input: `.....0.
..4321.
..5..2.
..6543.
..7..4.
..8765.
..9....`,
  },
  {
    answer: 13,
    input: `..90..9
...1.98
...2..7
6543456
765.987
876....
987....`,
  },
  {
    answer: 227,
    input: `012345
123456
234567
345678
4.6789
56789.`,
  },
  {
    answer: 81,
    input: `89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732`,
  },
]

function parseInput(args) {
  const { input } = args
  return {
    ...args,
    data: input
      .split("\n")
      .filter(Boolean)
      .map((line) => line.split("").map(Number)),
  }
}

function traversePath(data, [r, c], next = 1, peaks = {}) {
  if (data[r][c] === 9) {
    peaks[[r, c]] ??= 0
    peaks[[r, c]] += 1
    return
  }

  if (data[r - 1]?.[c] === next) traversePath(data, [r - 1, c], next + 1, peaks)
  if (data[r + 1]?.[c] === next) traversePath(data, [r + 1, c], next + 1, peaks)
  if (data[r]?.[c - 1] === next) traversePath(data, [r, c - 1], next + 1, peaks)
  if (data[r]?.[c + 1] === next) traversePath(data, [r, c + 1], next + 1, peaks)

  return peaks
}

function solve(args) {
  const { data } = args

  return data.reduce((acc, row, r) => {
    return (
      acc +
      row.reduce((acc, col, c) => {
        if (col !== 0) return acc
        else return acc + Object.values(traversePath(data, [r, c])).reduce((acc, v) => acc + v, 0)
      }, 0)
    )
  }, 0)
}

submit({
  day: 10,
  inputFile: import.meta.url,
  part: 2,
  solution: (args) => pipe(parseInput, solve)(args),
  testCases,
  year: 2024,
})
