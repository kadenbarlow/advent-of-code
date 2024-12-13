import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"

const testCases = [
  {
    answer: 80,
    input: `AAAA
BBCD
BBCC
EEEC`,
  },
  {
    answer: 436,
    input: `OOOOO
OXOXO
OOOOO
OXOXO
OOOOO`,
  },
  {
    answer: 236,
    input: `EEEEE
EXXXX
EEEEE
EXXXX
EEEEE`,
  },
  {
    answer: 368,
    input: `AAAAAA
AAABBA
AAABBA
ABBAAA
ABBAAA
AAAAAA`,
  },
  {
    answer: 1206,
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
  if (val === undefined) return { area: 0, corners: 0 }
  else if (visited[[r, c]]) return { area: 0, corners: 0 }
  else if (val !== value) return { area: 0, corners: 0 }

  visited[[r, c]] = true

  const neighbors = [
    [r + 1, c],
    [r - 1, c],
    [r, c + 1],
    [r, c - 1],
  ]

  const cornerPoints = [
    [
      [r + 1, c],
      [r, c - 1],
      [r + 1, c - 1],
    ],
    [
      [r + 1, c],
      [r, c + 1],
      [r + 1, c + 1],
    ],
    [
      [r - 1, c],
      [r, c - 1],
      [r - 1, c - 1],
    ],
    [
      [r - 1, c],
      [r, c + 1],
      [r - 1, c + 1],
    ],
  ]

  const cornerValues = cornerPoints.map((points) => points.map((p) => data[p[0]]?.[p[1]]))
  const corners = cornerValues.reduce((acc, [a, b, c]) => {
    if (a === val && a === b && a !== c) return acc + 1
    else if (a !== val && b !== val) return acc + 1
    return acc
  }, 0)

  const matchingNeighbors = neighbors.filter((n) => data[n[0]]?.[n[1]] === val)

  return matchingNeighbors
    .filter((n) => !visited[[n[0], n[1]]])
    .reduce(
      (acc, n) => {
        const { area, corners } = calculate(data, n, val)
        return { area: acc.area + area, corners: acc.corners + corners }
      },
      { area: 1, corners },
    )
}

function solve(args) {
  const { data } = args
  visited = {}
  return data.reduce((acc, row, r) => {
    return (
      acc +
      row.reduce((acc, col, c) => {
        const { area, corners } = calculate(data, [r, c], col)
        if (area !== 0) console.log(col, area, corners)
        return acc + area * corners
      }, 0)
    )
  }, 0)
}

submit({
  day: 12,
  inputFile: import.meta.url,
  part: 2,
  solution: (args) => pipe(parseInput, solve)(args),
  testCases,
  year: 2024,
})
