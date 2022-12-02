require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      A Y
      B X
      C Z
    TXT
    @part1_test_answer = 15

    @part2_test_input = <<~TXT
      A Y
      B X
      C Z
    TXT
    @part2_test_answer = 12
  end

  SCORE = {
    'A' => 1,
    'B' => 2,
    'C' => 3,
    'X' => 1,
    'Y' => 2,
    'Z' => 3
  }

  ROCK = %w(A X)
  PAPER = %w(B Y)
  SCISSORS = %w(C Z)

  def score(opponent, player)
    row = [opponent, player]
    return 3 + SCORE[player] if OPPONENT.index(opponent) == PLAYER.index(player)

    if (row - ROCK).empty? || (row - PAPER).empty? || (row - SCISSORS).empty?
      return 3 + SCORE[player]
    end

    return 6 + SCORE[player] if ROCK.include?(player) && SCISSORS.include?(opponent)
    return 6 + SCORE[player] if PAPER.include?(player) && ROCK.include?(opponent)
    return 6 + SCORE[player] if SCISSORS.include?(player) && PAPER.include?(opponent)

    return SCORE[player]
  end

  def part1(input)
    input.split("\n").reduce(0) do |sum, row|
      opponent = row.split(' ').first
      player = row.split(' ').last
      sum + score(opponent, player)
    end
  end

  OPTIONS = %w(A C B)
  OFFSET = {
    'X' => 1, # Loss
    'Y' => 0, # Draw
    'Z' => -1 # Win
  }

  def part2(input)
    input.split("\n").reduce(0) do |sum, row|
      opponent = row.split(' ').first
      player = row.split(' ').last
      player = OPTIONS[(OPTIONS.index(opponent) + OFFSET[player])%3]
      sum + score(opponent, player)
    end
  end
end
