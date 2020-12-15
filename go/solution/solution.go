package solution

import (
	"fmt"
	"time"
)

type solutionFunction func(string) int

type TestCase struct {
	Input  string
	Answer int
	Skip   bool
}

type Problem struct {
	Test     TestCase
	Input    string
	Solution solutionFunction
}

func solve(problem *Problem, problemNumber int) {
	start := time.Now()
	result := problem.Solution(problem.Input)
	duration := float64(time.Since(start)) / float64(time.Millisecond)

	fmt.Printf("Part %d: %s in %f ms\n", problemNumber, magenta(result), duration)
}

func test(test *TestCase, testNumber int, fn solutionFunction) bool {
	if test.Skip {
		return true
	}

	start := time.Now()
	result := fn(test.Input)
	duration := float64(time.Since(start)) / float64(time.Millisecond)

	pass := result == test.Answer
	var passOutput string
	if pass {
		passOutput = green("Pass")
	} else {
		passOutput = red("Fail")
	}

	fmt.Printf("Test %d: %s in %f ms\n", testNumber, passOutput, duration)
	if !pass {
		fmt.Printf("Expected: %s, Got: %s\n\n", green(test.Answer), red(result))
	}

	return pass
}

func Solve(part1, part2 Problem) {
	passed := true
	passed = passed && test(&part1.Test, 1, part1.Solution)
	passed = passed && test(&part2.Test, 2, part2.Solution)

	if passed {
		fmt.Println(green("All Test Cases Passed!\n"))
	} else {
		fmt.Println(red("TEST CASES FAILED!\n"))
		return
	}

	solve(&part1, 1)
	solve(&part2, 2)
}
