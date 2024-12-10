import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"

const testCases = [
  {
    answer: 1928,
    input: "2333133121414131402",
  },
]

function parseInput(args) {
  const { input } = args
  return {
    ...args,
    data: input.split(""),
  }
}

function parseDiskMap(data) {
  return data.reduce(
    (acc, num, i) => {
      if (i % 2 === 0) {
        acc.result.push(...Array(parseInt(num)).fill(acc.id))
        acc.id++
      } else {
        acc.result.push(...".".repeat(num).split(""))
      }
      return acc
    },
    { id: 0, result: [] },
  ).result
}

function solve(args) {
  const { data } = args
  const parsedDiskMap = parseDiskMap(data)
  let y = parsedDiskMap.length - 1
  for (let x = 0; x < parsedDiskMap.length; x++) {
    if (parsedDiskMap[x] !== ".") continue
    while (parsedDiskMap[y] === ".") y--
    if (y <= x) break
    parsedDiskMap[x] = parsedDiskMap[y]
    parsedDiskMap[y] = "."
  }

  return parsedDiskMap.reduce((acc, id, pos) => {
    if (id === ".") return acc
    return acc + id * pos
  }, 0)
}

submit({
  day: 9,
  inputFile: import.meta.url,
  part: 1,
  solution: (args) => pipe(parseInput, solve)(args),
  testCases,
  year: 2024,
})
