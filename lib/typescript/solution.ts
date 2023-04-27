import * as fs from 'fs'
import { Buffer } from 'buffer'
import chalk from 'chalk'

export type TestCase = {
  input: string
  answer: string | number
}

export type ProblemInput = {
  input: string
  testCase: boolean
}

type RunInput = {
  input: string
  testCases: TestCase[]
  solution: (input: ProblemInput) => string | number
  part: number
  submit: boolean
}

function run({ testCases, solution, input, part, submit }: RunInput) {
  const data = Buffer.from(fs.readFileSync(input)).toString()
  let passed = 0
  testCases.forEach((testCase, index) => {
    const answer = solution({ input: testCase.input, testCase: true })
    if (answer === testCase.answer) {
      passed += 1
      console.log(chalk.green(`Test case ${index + 1}: ${answer} - passed`))
    } else {
      console.log(chalk.red(`Test case ${index + 1}: expected ${testCase.answer}, got ${answer}`))
    }
  })
  if (passed === testCases.length) {
    console.log(chalk.green(`${passed}/${testCases.length} test cases passed`))
    if (submit) {
      console.log(solution({ input: data, testCase: false }))
    }
  } else {
    console.log(chalk.red(`${passed}/${testCases.length} test cases passed`))
  }
}

type SolverInput = {
  input: string
  part1TestCases: TestCase[]
  part1Solution: (input: ProblemInput) => string | number
  part2TestCases: TestCase[]
  part2Solution: (input: ProblemInput) => string | number
}

export function solve({ input, part1TestCases, part1Solution, part2TestCases, part2Solution }: SolverInput): void {
  console.log('Part 1')
  if (part1TestCases.length > 0 && part2TestCases.length == 0) {
    run({ input, testCases: part1TestCases, solution: part1Solution, part: 1, submit: true })
  } else {
    run({ input, testCases: part1TestCases, solution: part1Solution, part: 1, submit: false })
    console.log('\nPart 2')
    run({ input, testCases: part2TestCases, solution: part2Solution, part: 2, submit: true })
  }
}
