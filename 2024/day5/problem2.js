import invertObject from "#lib/objects/invert-object.js"
import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"

const testCases = [
  {
    answer: 123,
    input: `47|53
      97|13
      97|61
      97|47
      75|29
      61|13
      75|53
      29|13
      97|29
      53|29
      61|53
      97|53
      61|29
      47|13
      75|47
      97|75
      47|61
      75|61
      47|29
      75|13
      53|13

      75,47,61,53,29
      97,61,53,29,13
      75,29,13
      75,97,47,61,53
      61,13,29
      97,13,75,29,47`,
  },
]

function parseInput(args) {
  const { input } = args
  const [rules, updates] = input.split("\n\n")

  return {
    ...args,
    data: {
      rules: rules.split("\n").map((line) => line.split("|").map(Number)),
      updates: updates.split("\n").map((line) => line.split(",").map(Number)),
    },
  }
}

function solve(args) {
  const { data } = args
  const pageRules = data.rules.reduce((acc, [a, b]) => {
    acc[a] ??= {}
    acc[a][b] = true
    return acc
  }, {})

  return data.updates
    .map((update) => {
      return update.reduce((acc, n, index) => {
        acc[n] = index
        return acc
      }, {})
    })
    .filter((update) => {
      return !Object.entries(update).every(([item, index]) => {
        return (
          !pageRules[item] ||
          Object.keys(pageRules[item]).every((value) => update[value] === undefined || update[value] > index)
        )
      })
    })
    .map((update) => {
      return Object.keys(update).sort((a, b) => {
        if (pageRules[a][b]) return -1
        else if (pageRules[b][a]) return 1
        else return 0
      })
    })
    .reduce((acc, update) => {
      return acc + parseInt(update[Math.floor(update.length / 2)])
    }, 0)
}

submit({
  day: 5,
  inputFile: import.meta.url,
  part: 2,
  solution: (args) => pipe(parseInput, solve)(args),
  testCases,
  year: 2024,
})
