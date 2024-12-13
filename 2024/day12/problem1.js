import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"

const testCases = [
  {
    answer: 140,
    input: `AAAA
BBCD
BBCC
EEEC`,
  },
  {
    answer: 772,
    input: `OOOOO
OXOXO
OOOOO
OXOXO
OOOOO`,
  },
  {
    answer: 1930,
    input: `RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE`,
  },
]

function parseInput(args) {
  const { input } = args
  return {
    ...args,
    data: input
      .split("\n")
      .filter(Boolean)
      .map((line) => line.split("").filter(Boolean)),
  }
}

let visited = {}
function calculate(data, point, value) {
  const [r, c] = point
  const val = data[r]?.[c]
  if (val === undefined) return { area: 0, perimeter: 0 }
  else if (visited[[r, c]]) return { area: 0, perimeter: 0 }
  else if (val !== value) return { area: 0, perimeter: 0 }

  visited[[r, c]] = true

  const neighbors = [
    [r + 1, c],
    [r - 1, c],
    [r, c + 1],
    [r, c - 1],
  ]

  const matchingNeighbors = neighbors.filter((v) => data[v[0]]?.[v[1]] === val)

  const perimeter = 4 - matchingNeighbors.length
  return neighbors
    .filter((n) => !visited[[n[0], n[1]]])
    .reduce(
      (acc, n) => {
        const { area, perimeter } = calculate(data, n, val)
        return { area: acc.area + area, perimeter: acc.perimeter + perimeter }
      },
      { area: 1, perimeter },
    )
}

function solve(args) {
  const { data } = args
  visited = {}
  return data.reduce((acc, row, r) => {
    return (
      acc +
      row.reduce((acc, col, c) => {
        const { area, perimeter } = calculate(data, [r, c], col)
        return acc + area * perimeter
      }, 0)
    )
  }, 0)
}

submit({
  day: 12,
  inputFile: import.meta.url,
  part: 1,
  solution: (args) => pipe(parseInput, solve)(args),
  testCases,
  year: 2024,
})
