#! /usr/bin/env bash

if [[ -z "$1" ]]; then
  echo "usage: ./get-problem.sh <day-number>"
  echo "e.g. ./get-problem.sh 7"
  exit 1
fi

directory="day$1"
mkdir -p $directory

input_file="$directory/input.txt"
if [[ ! -f $input_file ]]; then
  touch $input_file
  curl "https://adventofcode.com/2020/day/$1/input" \
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
    -H 'cookie: _ga=GA1.2.1966960010.1606971231; session=53616c7465645f5f8810cfa47d54f9903da2bf8d6fad1425f704e0f7092a84fc3ab942f390139683afbda9b31db98ebd; _gid=GA1.2.121064554.1607096655; _gat=1' \
    --compressed > $input_file
fi

problem_file="$directory/problem.rb"
if [[ ! -f $problem_file ]]; then
  cat > $problem_file <<-EOF
#! /usr/bin/env ruby

f = File.open('./input.txt')

def part1()
end

puts part1()
EOF
fi
