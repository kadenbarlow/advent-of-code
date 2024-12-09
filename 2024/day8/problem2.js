import getCombinations from "#lib/arrays/get-combinations.js"
import createObjectWithDefault from "#lib/objects/create-object-with-default.js"
import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"

const testCases = [
  {
    answer: 34,
    input: `............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............`,
  },
]

function parseInput(args) {
  const { input } = args
  return {
    ...args,
    data: input
      .split("\n")
      .filter(Boolean)
      .map((line) => line.split("")),
  }
}

function solve(args) {
  const { data } = args

  return Object.keys(
    Object.entries(
      data.reduce(
        (acc, row, r) => {
          row.forEach((col, c) => col !== "." && acc[col].push([r, c]))
          return acc
        },
        createObjectWithDefault({}, () => []),
      ),
    ).reduce((acc, [_frequency, points]) => {
      const combinations = getCombinations(points, 2)
      combinations.forEach(([[r1, c1], [r2, c2]]) => {
        ;[
          [
            [r1, c1],
            [r1 - r2, c1 - c2],
          ],
          [
            [r2, c2],
            [r2 - r1, c2 - c1],
          ],
        ].forEach(([point, [dr, dc]]) => {
          let [r, c] = point
          while (r >= 0 && r < data.length && c >= 0 && c < data[0].length) {
            acc[[r, c]] = true
            r += dr
            c += dc
          }
        })
      })

      return acc
    }, {}),
  ).length
}

submit({
  day: 8,
  inputFile: import.meta.url,
  part: 2,
  solution: (args) => pipe(parseInput, solve)(args),
  testCases,
  year: 2024,
})
