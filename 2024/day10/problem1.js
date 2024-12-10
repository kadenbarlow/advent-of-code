import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"

const testCases = [
  {
    answer: 2,
    input: `...0...
...1...
...2...
6543456
7.....7
8.....8
9.....9`,
  },
  {
    answer: 4,
    input: `..90..9
...1.98
...2..7
6543456
765.987
876....
987....`,
  },
  {
    answer: 3,
    input: `10..9..
2...8..
3...7..
4567654
...8..3
...9..2
.....01`,
  },
  {
    answer: 36,
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
    peaks[[r, c]] = true
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
        else return acc + Object.keys(traversePath(data, [r, c])).length
      }, 0)
    )
  }, 0)
}

submit({
  day: 10,
  inputFile: import.meta.url,
  part: 1,
  solution: (args) => pipe(parseInput, solve)(args),
  testCases,
  year: 2024,
})
