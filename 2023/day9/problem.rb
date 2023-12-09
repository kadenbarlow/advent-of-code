require 'byebug'
class Solution < AbstractSolution
  def initialize
    super
    @part1_test_cases = [
      {
        answer: 114,
        input: <<~TXT
          0 3 6 9 12 15
          1 3 6 10 15 21
          10 13 16 21 30 45
        TXT
      },
      {
        answer: -5107,
        input: <<~TXT
          10 23 42 62 78 85 78 52 2 -77 -190 -342 -538 -783 -1082 -1440 -1862 -2353 -2918 -3562 -4290
        TXT
      }
    ]

    @part2_test_cases = [{
      answer: 2,
      input: <<~TXT
        0 3 6 9 12 15
        1 3 6 10 15 21
        10 13 16 21 30 45
      TXT
    }]
  end

  def create_sequences(history)
    sequences = [history.scan(/-*\d+/).map(&:to_i)]
    sequences << sequences.last.each_cons(2).map { _1[1] - _1[0] } until sequences.last.all?(&:zero?)
    sequences.reverse
  end

  def part1(input)
    input.split("\n").reduce(0) do |sum, history|
      sequences = create_sequences(history)
      sequences.each_with_index do |sequence, index|
        sequence << 0 if index.zero?
        sequence << (sequence.last + sequences[index - 1].last) unless index.zero?
      end
      sum + sequences.last.last
    end
  end

  def part2(input)
    input.split("\n").reduce(0) do |sum, history|
      sequences = create_sequences(history)
      sequences.each_with_index do |sequence, index|
        sequence.prepend(0) if index.zero?
        sequence.prepend(sequence.first - sequences[index - 1].first) unless index.zero?
      end
      sum + sequences.last.first
    end
  end
end
