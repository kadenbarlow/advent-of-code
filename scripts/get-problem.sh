#! /usr/bin/env bash

if [[ -z "$1" ]] || [[ -z "$2" ]]; then
  echo "usage: ./get-problem.sh <year> <day> <language?>"
  echo "e.g. ./get-problem.sh 2020 7 typescript"
  exit 1
fi

directory="$1/day$2"
mkdir -p $directory

input_file="$directory/input.txt"
if [[ ! -f $input_file ]]; then
  touch $input_file
  curl "https://adventofcode.com/$1/day/$2/input" \
    -H 'authority: adventofcode.com' \
    -H 'cache-control: max-age=0' \
    -H 'upgrade-insecure-requests: 1' \
    -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36' \
    -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
    -H 'sec-fetch-site: same-origin' \
    -H 'sec-fetch-mode: navigate' \
    -H 'sec-fetch-user: ?1' \
    -H 'sec-fetch-dest: document' \
    -H 'referer: https://adventofcode.com/2020/day/10' \
    -H 'accept-language: en-US,en;q=0.9,es-US;q=0.8,es;q=0.7' \
    -H "cookie: _ga=GA1.2.1966960010.1606971231; session=$SESSION_COOKIE; _gid=GA1.2.121064554.1607096655; _gat=1" \
    --compressed > $input_file
fi

if [[ -z "$3" ]]; then
  problem_file="$directory/problem.rb"
  if [[ ! -f $problem_file ]]; then
    cat > $problem_file <<-EOF
require 'byebug'
class Solution < AbstractSolution
  def initialize
    super
    @part1_test_cases = [
      {
        answer: nil,
        input: <<~TXT
        TXT
      }
    ]

    @part2_test_cases = []
  end

  def part1(input)
  end

  def part2(input)
  end
end
EOF
  fi
elif [[ "$3" == "typescript" ]]; then
  problem_file="$directory/problem1.ts"
  if [[ ! -f $problem_file ]]; then
    cat > $problem_file <<-EOF
import pipe from "#lib/pipe.js"
import submit from "#lib/submit.js"

const testCases = [
  {
    answer: 0,
    input: "",
  },
]

function parseInput(args) {
  const { input } = args
  return { ...args, data: null }
}

function solve(args) {
  const {} = args
}

async function solution(args) {
  return await pipe(parseInput, solve)(args)
}

submit({
  inputFile: import.meta.url,
  solution,
  testCases,
})
EOF
    cp $directory/problem1.ts $directory/problem2.ts
  fi
fi
