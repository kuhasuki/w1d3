def range(val1, val2)
  return [] if val1 >= val2
   [val1] + range(val1 + 1, val2 - 1) + [val2]
end

# p range(2, 2)
# p range(2, 8)
# p range(1, 2)
# p range(5, 2)


def recursive_sum(arr)
  return arr.first if arr.length == 1
  arr.shift + recursive_sum(arr)
end


# puts recursive_sum([1,1,1,1])
#
# puts recursive_sum([7])
# puts recursive_sum([1,6,4,2])

def iterative_sum(arr)
  arr.inject(0) {|val, el| val + el}
end
#
# puts iterative_sum([1,1,1,1])
#
# puts iterative_sum([7])
# puts iterative_sum([1,6,4,2])

def exp_1(base, power)
  return 1 if power == 0
  base * exp_1(base, power - 1)
end

# p exp_1(5, 2)
# p exp_1(2, 4)
# p exp_1(2, 20)
# p exp_1(1, 0)
# p exp_1(1, 10)

def exp_2(base, power)
  return 1 if power == 0
  return base if power == 1
  if power.even?
    exp_2(base, power / 2) * exp_2(base, power / 2)
  else
    base * (exp_2(base, (power - 1) / 2)) * (exp_2(base, (power - 1) / 2))
  end
end

# p exp_2(5, 2)
# p exp_2(2, 4)
# p exp_2(2, 20)
# p exp_2(1, 0)
# p exp_2(1, 10)

class Array
  def deep_dup
    return self.dup unless self.any? { |el| el.is_a?(Array) }
    duped = []
    self.each do |el|
      if el.is_a?(Array)
        duped << el.deep_dup
      else
        duped << el
      end
    end
    duped
  end
end
#
# robot_parts = [
#   ["nuts", "bolts", "washers"],
#   ["capacitors", "resistors", "inductors"]
# ]
#
# robot_parts_copy = robot_parts.deep_dup
# p robot_parts
# p robot_parts_copy
# puts ""
# # shouldn't modify robot_parts
# robot_parts_copy[1] << "LEDs"
# # wtf?
# robot_parts[1] # => ["capacitors", "resistors", "inductors", "LEDs"]
# puts ""
# p robot_parts
# p robot_parts_copy

def fibonacci(n)
  return [] if n == 0
  return [1] if n == 1
  [fib_num(n - 1)] + fibonacci(n - 1)
end

def fib_num(n)
  return 1 if n == 0
  return 1 if n == 1
  fib_num(n - 1) + fib_num(n - 2)
end

def iterative_fib(n)
  num = 1
  next_num = 1
  nexter_num = 0
  n.times do |i|
    nexter_num = num + next_num
    num = next_num
    next_num = nexter_num
  end
num
end

def iterative_fibarray(n)
  answer = []
  n.times do |idx|
    answer << iterative_fib(idx)
  end
  answer
end
# p iterative_fibarray(0)
# p iterative_fibarray(1)
# p iterative_fibarray(2)
# p iterative_fibarray(5)
# p fibonacci(0)
# p fibonacci(1)
# p fibonacci(2)
# p fibonacci(6)
#
# p fib_num(0)
# p fib_num(1)
# p fib_num(2)
# p fib_num(3)
# p fib_num(4)

def bsearch(array, target)
  return nil if array.empty?
  # return 0 if array[0] == target
  # return nil if array.length == 1
  half_point = (array.length / 2)

  case array[half_point] <=> target
    when -1
      maybe_index = bsearch(array[(half_point + 1)..-1], target)
      unless maybe_index.nil?
        1 + half_point + maybe_index
      end
    when 0
      return half_point
    when 1
        bsearch(array[0...half_point], target)
  end
end

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

# def make_change(total, coin_values)
#   coin_values = coin_values.sort.reverse
#   coins = []
#   #least_quantity = []
#   return [] if total == 0
#   if coin_values.length == 1
#     total.times do
#       coins << 1
#     end
#     return coins
#   end
#
#   max_value = coin_values.shift
#   amount = total/max_value
#   amount.times do
#     coins << max_value
#   end
#
#   coins + make_change(total % max_value, coin_values)
# end


# def make_change(total, coin_values)
#   coin_values = coin_values.sort.reverse
#   coins = []
#   least_quantity = []
#   return [] if total == 0
#   if coin_values.length == 1
#     total.times do
#       coins << 1
#     end
#     return coins
#   end
#   max_value_coin = coin_values.find {|coin| coin <= total}
#   coins_remaining = coin_values.select{ |coin| coin <= max_value_coin}
#   coins << max_value_coin
#
#   coins + make_change(total - max_value_coin, coins_remaining)
# end

def make_change(total, coin_values)
  coin_values = coin_values.sort.reverse
  coins = []
  least_quantity = nil
  return [] if total == 0
  if coin_values.length == 1
    total.times do
      coins << 1
    end
    return coins
  end

  coins_remaining = coin_values.select{ |coin| coin <= total}
  coins_remaining.each do |coin|
    current = ([coin] + make_change(total - coin, coins_remaining))
    if least_quantity.nil?
      least_quantity = current
    elsif least_quantity && current.length < least_quantity.length
      least_quantity = current
    end
  end
  least_quantity
end

# p "coins:#{coins}"
# p "max:#{max_value_coin}"
# p "remain:#{coins_remaining}"
  # p make_change(50, [25, 10, 5, 1])
  # p make_change(5, [25, 10, 5, 1])
  # p make_change(1, [25, 10, 5, 1])
  # p make_change(14, [10, 7, 1])

class Array
  def merge_sort
    return self if self.length <= 1
    midpoint = self.length / 2
    left_half = self[0...midpoint]
    right_half = self[midpoint..-1]
    merged_left = left_half.merge_sort
    merged_right = right_half.merge_sort
    merged_left.merge(merged_right)

  end

  def merge(arr)
    merged_array = []
    while !self.empty? && !arr.empty?
      if self.first <= arr.first
        merged_array << self.shift
      else
        merged_array << arr.shift
      end
    end
    while self.length > 0
      merged_array << self.shift
    end
    while arr.length > 0
      merged_array << arr.shift
    end
    merged_array
  end
end

def subsets(arr) #[1]
  return [[]] if arr.empty?
  element = arr.last
  # first we get the subsets of the array WITHOUT the last element
  old_subs = subsets(arr[0...-1]) # [[]]
  old_subs + old_subs.map{|subs| subs.dup << arr.last}
end

p subsets([]) # => [[]]
p subsets([1]) # => [[], [1]]
p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
p subsets([1, 2, 3])









# => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]




















  # master_array = []
  # apprentice_array = []
  # master_array = master_array + arr
  # arr.each_with_index do |elem, idx|
  #   duplicate = arr.dup
  #   duplicate.delete_at(idx)
  #   # p duplicate
  #   apprentice_array.push(duplicate)
  # end
  # p apprentice_array
  # master_array = master_array + apprentice_array
  # apprentice_array.each do |el|
  #   master_array += subsets(el)
  # end


#
