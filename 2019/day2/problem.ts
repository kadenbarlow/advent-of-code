import { solve, TestCase, ProblemInput } from '../../lib/typescript'

const part1TestCases: TestCase[] = [
  {
    input: '1,9,10,3,2,3,11,0,99,30,40,50',
    answer: 3500,
  },
]
function part1Solution({ input, testCase }: ProblemInput): number {
  const intcode = input.split(',').map(Number)
  if (!testCase) {
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

const part2TestCases: TestCase[] = [
  {
    input: '1,0,0,0,99',
    answer: 2,
  },
]
function part2Solution({ input }: ProblemInput): number {
  return 0
}

solve({ input: `${__dirname}/input.txt`, part1TestCases, part1Solution, part2TestCases, part2Solution })
