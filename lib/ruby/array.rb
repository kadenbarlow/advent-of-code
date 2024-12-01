require_relative 'circular_array'
class Array
  def circular = CircularArray.new(self)
end
