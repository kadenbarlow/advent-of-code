import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"

const testCases = []
// const testCases = [
//   {
//     answer: 55312,
//     input: "125 17",
//   },
// ]

function parseInput(args) {
  const { input } = args
  return {
    ...args,
    data: input.split(" ").filter(Boolean).map(Number),
  }
}

const cache = {}
function count(stone, blink) {
  if (blink === 75) return 1
  else if (cache[[stone, blink]]) return cache[[stone, blink]]
  else {
    const string = stone.toString()
    if (stone === 0) {
      cache[[stone, blink]] = count(1, blink + 1)
    } else if (string.length % 2 === 0) {
      const left = parseInt(string.slice(0, string.length / 2))
      const right = parseInt(string.slice(string.length / 2))
      cache[[stone, blink]] = count(left, blink + 1) + count(right, blink + 1)
    } else {
      cache[[stone, blink]] = count(stone * 2024, blink + 1)
    }
  }

  return cache[[stone, blink]]
}

function solve(args) {
  const { data } = args
  let result = 0
  for (let x = 0; x < data.length; x++) {
    result += count(data[x], 0)
  }

  return result
}

submit({
  day: 11,
  inputFile: import.meta.url,
  part: 2,
  solution: (args) => pipe(parseInput, solve)(args),
  testCases,
  year: 2024,
})
