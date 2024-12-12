import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"

const testCases = [
  {
    answer: 55312,
    input: "125 17",
  },
]

function parseInput(args) {
  const { input } = args
  return {
    ...args,
    data: input.split(" ").filter(Boolean).map(Number),
  }
}

function solve(args) {
  const { data } = args
  for (let x = 0; x < 25; x++) {
    for (let y = 0; y < data.length; y++) {
      const string = data[y].toString()
      if (data[y] === 0) {
        data[y] = 1
      } else if (string.length % 2 === 0) {
        data.splice(y, 1, parseInt(string.slice(0, string.length / 2)), parseInt(string.slice(string.length / 2)))
        y++
      } else {
        data[y] *= 2024
      }
    }
  }

  return data.length
}

submit({
  day: 11,
  inputFile: import.meta.url,
  part: 1,
  solution: (args) => pipe(parseInput, solve)(args),
  testCases,
  year: 2024,
})
