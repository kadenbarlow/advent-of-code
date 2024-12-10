import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"

const testCases = [
  {
    answer: 2858,
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
  for (let x = parsedDiskMap.length - 1; x >= 0; x--) {
    if (parsedDiskMap[x] === ".") continue
    let startOfFile = x
    while (startOfFile >= 0 && parsedDiskMap[startOfFile] === parsedDiskMap[x]) startOfFile--
    const lengthOfFile = x - startOfFile
    for (let y = 0; y < x; y++) {
      if (parsedDiskMap[y] !== ".") continue
      let endOfFreeSpace = y
      while (endOfFreeSpace < parsedDiskMap.length && parsedDiskMap[endOfFreeSpace] === ".") endOfFreeSpace++
      const lengthOfFreeSpace = endOfFreeSpace - y
      if (lengthOfFile <= lengthOfFreeSpace) {
        parsedDiskMap.splice(y, lengthOfFile, ...parsedDiskMap.slice(startOfFile + 1, x + 1))
        parsedDiskMap.splice(startOfFile + 1, lengthOfFile, ...".".repeat(lengthOfFile).split(""))
        break
      } else {
        y = endOfFreeSpace
      }
    }
    x = startOfFile + 1
  }

  return parsedDiskMap.reduce((acc, id, pos) => {
    if (id === ".") return acc
    return acc + id * pos
  }, 0)
}

submit({
  day: 9,
  inputFile: import.meta.url,
  part: 2,
  solution: (args) => pipe(parseInput, solve)(args),
  testCases,
  year: 2024,
})
