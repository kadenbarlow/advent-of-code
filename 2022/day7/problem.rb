require 'byebug'
class Solution < AbstractSolution
  def initialize
    @part1_test_input = <<~TXT
      $ cd /
      $ ls
      dir a
      14848514 b.txt
      8504156 c.dat
      dir d
      $ cd a
      $ ls
      dir e
      29116 f
      2557 g
      62596 h.lst
      $ cd e
      $ ls
      584 e
      $ cd ..
      $ cd ..
      $ cd d
      $ ls
      4060174 j
      8033020 d.log
      5626152 d.ext
      7214296 k
    TXT
    @part1_test_answer = 95_437

    @part2_test_input = @part1_test_input
    @part2_test_answer = 24_933_642
  end

  def part1(input)
    current_dir = []
    dirs = Hash.new { |hash, key| hash[key] = 0 }
    input.split("\n").each do |line|
      current_dir.pop and next if line.include?('$ cd ..')
      current_dir << line.split(' ').last and next if line.include?('$ cd')

      next unless line[0] != '$'

      current_dir.each_with_index do |_cd, i|
        dirs[current_dir[0..i].join('-')] += line.scan(/\d+/).first.to_i
      end
    end
    dirs.values.map(&:to_i).select{ _1 <= 100_000 }.sum
  end

  def part2(input)
    current_dir = []
    dirs = Hash.new { |hash, key| hash[key] = 0 }
    input.split("\n").each do |line|
      current_dir.pop and next if line.include?('$ cd ..')
      current_dir << line.split(' ').last and next if line.include?('$ cd')

      next unless line[0] != '$'

      current_dir.each_with_index do |_cd, i|
        dirs[current_dir[0..i].join('-')] += line.scan(/\d+/).first.to_i
      end
    end
    values = dirs.values.map(&:to_i)
    total = dirs['/']
    values.select { 70_000_000 - total + _1 >= 30_000_000 }.min
  end
end
