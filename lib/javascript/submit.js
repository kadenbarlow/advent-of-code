import { Buffer } from "buffer"
import chalk from "chalk"
import * as fs from "fs"
import path from "path"
import { fileURLToPath } from "url"
import pipe from "#lib/pipe.js"

function loadDataFromInputFile(args) {
  const { inputFile } = args
  const fileName = fileURLToPath(inputFile)
  const dirName = path.dirname(fileName)

  const data = Buffer.from(fs.readFileSync(`${dirName}/input.txt`)).toString()
  return { ...args, data }
}

async function runTestCases(args) {
  const { solution, testCases } = args
  return {
    ...args,
    passsed: testCases.every(async (testCase, index) => {
      const answer = await solution({ input: testCase.input, isTestCase: true })
      if (answer === testCase.answer) {
        console.log(chalk.green(`Test case ${index + 1} - passed`))
        return true
      } else {
        console.log(chalk.red(`Test case ${index + 1} - expected ${testCase.answer}, got ${answer}`))
        return false
      }
    }),
  }
}

function submitSolution(args) {
  const { data, passed, solution } = args
  if (passed) {
    const answer = solution({ input: data, isTestCase: false })
    console.log(answer)
  }
  return args
}

export default function submit(args) {
  const { inputFile, solution, testCases } = args
  pipe(loadDataFromInputFile, runTestCases, submitSolution)({ data: {}, inputFile, passed: false, solution, testCases })
}
