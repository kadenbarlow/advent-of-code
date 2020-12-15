package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func main() {
	data, _ := ioutil.ReadFile("./input.txt")
	input := string(data)

	answer, _ := part1(input)
	fmt.Printf("Part 1: %d\n", answer)

	fmt.Printf("Part 2: %d\n", part2(input))
}

func part1(input string) (int, bool) {
	lines := strings.Split(input, "\n")
	numbers := make([]int, 0, len(lines))
	for _, number := range lines {
		integer, _ := strconv.Atoi(number)
		numbers = append(numbers, integer)
	}

	for _, a := range numbers {
		for _, b := range numbers {
			if a+b == 2020 {
				return a * b, true
			}
		}
	}
	return 0, false
}

func part2(input string) int {
	return 0
}
