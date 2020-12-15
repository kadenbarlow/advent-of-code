package main

import (
	"advent-of-code/go/solution"
	"io/ioutil"
)

func part1(input string) int {
	floor := 0
	for _, char := range input {
		if char == '(' {
			floor += 1
		} else if char == ')' {
			floor -= 1
		}
	}
	return floor
}

func part2(input string) int {
	floor := 0
	for index, char := range input {
		if char == '(' {
			floor += 1
		} else if char == ')' {
			floor -= 1
		}

		if floor == -1 {
			return index + 1
		}
	}
	return 0
}

func main() {
	data, _ := ioutil.ReadFile("./input.txt")
	input := string(data)

	problem1 := solution.Problem{
		Test: solution.TestCase{
			Input:  `)())())`,
			Answer: -3,
		},
		Input:    input,
		Solution: part1,
	}

	problem2 := solution.Problem{
		Test: solution.TestCase{
			Input:  `()())`,
			Answer: 5,
			Skip:   true,
		},
		Input:    input,
		Solution: part2,
	}

	solution.Solve(problem1, problem2)
}
