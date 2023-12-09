require 'byebug'
class Solution < AbstractSolution
  def initialize
    super
    @part1_test_cases = [
      {
        answer: 6440,
        input: <<~TXT
          32T3K 765
          T55J5 684
          KK677 28
          KTJJT 220
          QQQJA 483
        TXT
      }
    ]

    @part2_test_cases = [
      {
        answer: 5905,
        input: <<~TXT
          32T3K 765
          T55J5 684
          KK677 28
          KTJJT 220
          QQQJA 483
        TXT
      }
    ]
  end

  PART1_CARD_VALUES = { 'A' => 14, 'K' => 13, 'Q' => 12, 'J' => 11, 'T' => 10, '9' => 9, '8' => 8, '7' => 7, '6' => 6,
                        '5' => 5, '4' => 4, '3' => 3, '2' => 2 }.freeze
  PART2_CARD_VALUES = PART1_CARD_VALUES.dup.merge('J' => 1).freeze

  def compare_hands(a, b, values) = 5.times { |i| return values[a[i]] <=> values[b[i]] unless a[i] == b[i] }

  def rank_hand(hand)
    groups = hand.chars.tally.values.tally
    return 6 if groups[5]
    return 5 if groups[4]
    return 4 if groups[3] && groups[2]
    return 3 if groups[3] && groups[1] == 2
    return 2 if groups[2] == 2 && groups[1]
    return 1 if groups[2] == 1 && groups[1] == 3

    return 0
  end

  def rank_hand_with_jokers(hand)
    jokers = hand.chars.count('J')
    return rank_hand(hand) if jokers.zero? || jokers == 5

    tally = (hand.chars - ['J']).tally
    return rank_hand(hand.dup.gsub('J', tally.invert[tally.values.max]))
  end

  def play_game(input:, jokers: false)
    rank_function_name = jokers ? :rank_hand_with_jokers : :rank_hand
    rank = method(rank_function_name)
    values = jokers ? PART2_CARD_VALUES : PART1_CARD_VALUES

    hands = input.split("\n").to_h { [_1.split.first, _1.split.last.to_i] }
    hands.keys
         .sort { (a = rank.call(_1)) == (b = rank.call(_2)) ? compare_hands(_1, _2, values) : a <=> b }
         .each_with_index
         .reduce(0) { |sum, (key, multiplier)| sum + ((multiplier + 1) * hands[key]) }
  end

  def part1(input)
    play_game(input:)
  end

  def part2(input)
    play_game(input:, jokers: true)
  end
end
