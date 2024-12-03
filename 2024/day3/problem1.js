import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"

const testCases = [
  {
    answer: 161,
    input: "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))",
  },
]

function parseInput(args) {
  const { input } = args

  return {
    ...args,
    data: [...input.matchAll(/mul\((\d+),(\d+)\)/g)],
  }
}

function solve(args) {
  const { data } = args

  return data.reduce((acc, pair) => {
    const [_, a, b] = pair
    return acc + a * b
  }, 0)
}

submit({
  day: 3,
  inputFile: import.meta.url,
  part: 1,
  solution: (args) => pipe(parseInput, solve)(args),
  testCases,
  year: 2024,
})
