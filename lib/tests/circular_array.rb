require_relative '../array'
require 'byebug'

class CircularArrayTest < MiniTest::Unit::TestCase
  def test_circular_subsets
    array = (0..10).to_a.circular
    assert_equal 0, array[0]
    assert_equal 0, array[11]
    assert_equal array[0..2], [0, 1, 2]
    assert_equal [8, 9, 10, 0, 1, 2], array[-3..2]
    assert_equal [8, 9, 10], array[-3..-1]
    assert_equal [10, 0, 1, 2, 3, 4, 5], array[-1..5]
    assert_equal array[0..11], array
    assert_equal [8, 9, 10, 0, 1, 2, 3, 4, 5, 6, 7], array[-3..20]
    assert_equal [10, 9, 8], array[-1..-3]
    assert_equal [8, 7, 6, 5, 4, 3, 2], array[8..2]
    assert_equal [5, 4, 3, 2, 1, 0, 10], array[5..-1]
    assert_equal [5, 4, 3, 2], array[5..-20]
    assert_equal [10, 0], array[-1..0]
    assert_equal [10, 0, 1], array[-1..1]

    assert_equal [0, 10], array[0..-1]
    assert_equal array, array[0..]
    assert_equal [0, 10, 9], array[0..-2]
    assert_equal (0..9).to_a, array[..-2]

    assert_equal [6, 5], array[-5..-6]
    assert_equal [8, 9, 10], array[-3..]
    assert_equal [5, 6], array[-6..-5]
    assert_equal [0, 1], array[11..12]

    assert_equal [10, 0], array[21..22]
    assert_equal [1, 0, 10, 9, 8], array[12..8]
    assert_equal [0, 10], array[-11..-12]
  end

  def test_circular_insertion
    array = [].circular
    array.insert(0, 1)
    assert_equal [1], array
    array.insert(0, 0)
    assert_equal [0, 1], array
    array.insert(2, 2)
    assert_equal [0, 1, 2], array
    array.insert(-1, -1)
    assert_equal [0, 1, -1, 2], array
    array.insert(array.size, 3)
    assert_equal [0, 1, -1, 2, 3], array
    array << 4
    assert_equal [0, 1, -1, 2, 3, 4], array
    array.insert(-2, -2)
    assert_equal [0, 1, -1, 2, -2, 3, 4], array
  end

  def test_circular_deletion
    array = (0..10).to_a.circular
    array.delete_at(-1)
    assert_equal (0..9).to_a, array
    array.delete_at(10)
    assert_equal (1..9).to_a, array
    array.delete_at(127)
    assert_equal [1].concat((3..9).to_a), array
  end
end
