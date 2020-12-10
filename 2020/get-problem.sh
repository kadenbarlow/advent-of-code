#! /usr/bin/env bash

if [[ -z "$1" ]]; then
  echo "usage: ./get-problem.sh <day-number>"
  echo "e.g. ./get-problem.sh 7"
  exit 1
fi

directory="day$1"
mkdir -p $directory

input_file="$directory/input.txt"
touch $input_file
# if [[ ! -f $input_file ]]; then
#   curl "https://adventofcode.com/2020/day/$1/input" --output $input_file
# fi

touch "$directory/sample.txt"

problem_file="$directory/problem.rb"
if [[ ! -f $problem_file ]]; then
  cat > $problem_file <<-EOF
#! /usr/bin/env ruby

f = File.open('./sample.txt')
# f = File.open('./input.txt')

def part1()
end

puts part1()
EOF
fi
