require 'byebug'
require 'set'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
      trh fvjkl sbzzf mxmxvkd (contains dairy)
      sqjhc fvjkl (contains soy)
      sqjhc mxmxvkd sbzzf (contains fish)
    TXT
    @part1_test_answer = 5

    @part2_test_input = <<~TXT
      mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
      trh fvjkl sbzzf mxmxvkd (contains dairy)
      sqjhc fvjkl (contains soy)
      sqjhc mxmxvkd sbzzf (contains fish)
    TXT
    @part2_test_answer = 'mxmxvkd,sqjhc,fvjkl'
  end

  def solution(input)
    results = Hash.new { |hash, key| hash[key] = Array.new }
    counts = Hash.new { |hash, key| hash[key] = 0 }
    answers = {}

    input.split("\n").each do |line|
      ingredients = Set.new(line[/(.*) \(/, 1].split(' '))
      ingredients.each { |ingredient| counts[ingredient] += 1 }
      allergens = line[/\(contains (.*)\)/, 1].split(', ')
      allergens.each { |allergen| results[allergen] << ingredients }
    end

    results = results.map { |ingredient, lists| [ingredient, lists.reduce(&:&)] }.to_h
    while results.values.map(&:count).reduce(&:+).positive?
      answers.values.each { |allergen| results.each_key { |ingredient| results[ingredient] -= [allergen] } }
      results.select { |_, allergens| allergens.count == 1 }
             .each { |ingredient, value| answers[ingredient] = value.first }
    end

    return answers, counts
  end

  def part1(input)
    answers, counts = solution(input)
    return counts.slice(*(counts.keys - answers.values)).values.reduce(&:+)
  end

  def part2(input)
    answers, _ = solution(input)
    return answers.keys.sort.map { |allergen| answers[allergen] }.join(',')
  end
end
