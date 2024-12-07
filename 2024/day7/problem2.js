import getPermutations from "#lib/arrays/get-permutations.js"
import createObjectWithDefault from "#lib/objects/create-object-with-default.js"
import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"

const testCases = [
  {
    answer: 11387,
    input: `190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20`,
  },
]

function parseInput(args) {
  const { input } = args

  return {
    ...args,
    data: input
      .split("\n")
      .filter(Boolean)
      .map((line) => [...line.match(/(\d+)/g)].map(Number)),
  }
}

function solve(args) {
  const { data } = args
  const permutations = createObjectWithDefault({}, (key) => getPermutations(["+", "*", "|"], parseInt(key)))

  return data.reduce((acc, equation) => {
    const [result, ...nums] = equation
    const numberOfOperations = nums.length - 1
    const valid = permutations[numberOfOperations].some((operations) => {
      return (
        operations.split("").reduce((acc, operation, i) => {
          if (operation === "|") return parseInt(`${acc}${nums[i + 1]}`)

          return eval(`${acc} ${operation} ${nums[i + 1]}`)
        }, nums[0]) === result
      )
    })
    return acc + (valid ? result : 0)
  }, 0)
}

submit({
  day: 7,
  dryRun: true,
  inputFile: import.meta.url,
  part: 2,
  solution: (args) => pipe(parseInput, solve)(args),
  testCases,
  year: 2024,
})
