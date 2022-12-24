require 'byebug'

class CircularArray < Array
  def initialize(array = [])
    super()
    concat(array)
  end

  def insert(index, *obj)
    return concat(obj) if size.zero?

    circular_index = index % size
    circular_index = size if circular_index.zero? && !index.zero?
    super(circular_index, *obj)
  end

  def delete_at(index)
    return nil if size.zero?
    super(index % size)
  end

  def [](index)
    return nil if empty?

    case index
    when Range
      # handle cases like array[n..] or array[..n]
      return super(index) if index.size == Float::INFINITY

      if index.first > index.last # Range goes backwards?
        if index.first % size > index.last % size
          # we don't need to combine two subarrays for these cases where we return the
          # reverse array # e.g array[-1..-3] or array[8..2] because there is no wrapping
          # where array = (0..10).to_a, normal arrays don't support this
          return slice((index.last % size)..(index.first % size)).reverse
        end

        # otherwise we are wrapping backwards around 0
        return wrap_forwards(((index.last % size)..(index.first % size))).reverse
      elsif !in_bounds?(index.first) || !in_bounds?(index.last)
        if ((index.first < 0 && index.last < 0) || (index.first >= size && index.last >= size)) &&
           ((index.first % size) < (index.last % size))
          # similarly to the case above if both are in range and don't wrap around the end
          # we can just return a normal subarray e.g array[11..12] or array[-6..-5]
          # where array = (0..10).to_a
          return slice((index.first % size)..(index.last % size))
        end

        return wrap_forwards(index)
      else
        # It's a normal forward in bounds range, let normal array class handle it
        return super(index)
      end
    when Integer
      return super(index % size) # allow wrapping when looking up a single element
    end
  end

  private

  def in_bounds?(index)
    (0..(size - 1)).cover?(index)
  end

  def wrap_forwards(range)
    a = (range.first % size)
    b = range.last.negative? ? size + range.last : size - 1

    c = range.last.negative? ? (size + range.last + 1) : 0
    d = b == ((range.last % size) + 1) ? a : (range.last % size) + 1
    d = [a, d].min

    return slice(a..b).concat((c - d).zero? ? [] : slice(c, d))
  end
end
