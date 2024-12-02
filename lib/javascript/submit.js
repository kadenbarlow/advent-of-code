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
    passed: await Promise.all(
      testCases.map(async (testCase, index) => {
        const answer = await solution({ input: testCase.input, isTestCase: true })
        if (answer === testCase.answer) {
          console.log(chalk.green(`Test case ${index + 1} - passed`))
          return true
        } else {
          console.log(chalk.red(`Test case ${index + 1} - expected ${testCase.answer}, got ${answer}`))
          return false
        }
      }),
    ).then((passed) => passed.every(Boolean)),
  }
}

async function submitSolution(args) {
  const { data, day, dryRun, part, passed, solution, year } = args
  if (passed) {
    const answer = await solution({ input: data, isTestCase: false })
    if (dryRun) {
      console.log(chalk.green(`Dry Run Answer: ${answer}`))
      return
    }

    fetch(`https://adventofcode.com/${year}/day/${day}/answer`, {
      body: `level=${part}&answer=${answer}`,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        Cookie: `session=${process.env.SESSION_COOKIE}`,
      },
      method: "POST",
    })
      .then((response) => response.text())
      .then((result) => {
        // console.log(result)
        if (result.includes("That's the right answer!")) {
          console.log(chalk.green(`Answer ${answer} was correct`))
        } else {
          console.log(chalk.red(`Answer ${answer} was incorrect`))
        }
      })
  }
}

export default function submit(args) {
  pipe(loadDataFromInputFile, runTestCases, submitSolution)({ data: {}, passed: false, ...args })
}
