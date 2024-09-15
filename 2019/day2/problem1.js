import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"

const testCases = [
  {
    answer: 3500,
    input: "1,9,10,3,2,3,11,0,99,30,40,50",
  },
]

function parseInput(args) {
  const { input } = args
  return { ...args, intcode: input.split(",").map(Number) }
}

function solve(args) {
  const { intcode, isTestCase } = args
  if (!isTestCase) {
    intcode[1] = 12
    intcode[2] = 2
  }

  for (let x = 0; x < intcode.length; x += 4) {
    const opcode = intcode[x]
    if (opcode === 1) {
      intcode[intcode[x + 3]] = intcode[intcode[x + 1]] + intcode[intcode[x + 2]]
    } else if (opcode === 2) {
      intcode[intcode[x + 3]] = intcode[intcode[x + 1]] * intcode[intcode[x + 2]]
    } else if (opcode === 99) {
      break
    }
  }
  return intcode[0]
}

async function solution(args) {
  return await pipe(parseInput, solve)(args)
}

submit({
  inputFile: import.meta.url,
  solution,
  testCases,
})
