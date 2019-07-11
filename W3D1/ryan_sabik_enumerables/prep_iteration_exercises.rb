# ### Factors
#
# Write a method `factors(num)` that returns an array containing all the
# factors of a given number.

def factors(num)
  (1..num).select {|val| num % val == 0}
end

# ### Bubble Sort
#
# http://en.wikipedia.org/wiki/bubble_sort
#
# Implement Bubble sort in a method, `Array#bubble_sort!`. Your method should
# modify the array so that it is in sorted order.
#
# > Bubble sort, sometimes incorrectly referred to as sinking sort, is a
# > simple sorting algorithm that works by repeatedly stepping through
# > the list to be sorted, comparing each pair of adjacent items and
# > swapping them if they are in the wrong order. The pass through the
# > list is repeated until no swaps are needed, which indicates that the
# > list is sorted. The algorithm gets its name from the way smaller
# > elements "bubble" to the top of the list. Because it only uses
# > comparisons to operate on elements, it is a comparison
# > sort. Although the algorithm is simple, most other algorithms are
# > more efficient for sorting large lists.
#
# Hint: Ruby has parallel assignment for easily swapping values:
# http://rubyquicktips.com/post/384502538/easily-swap-two-variables-values
#
# After writing `bubble_sort!`, write a `bubble_sort` that does the same
# but doesn't modify the original. Do this in two lines using `dup`.
#
# Finally, modify your `Array#bubble_sort!` method so that, instead of
# using `>` and `<` to compare elements, it takes a block to perform the
# comparison:
#
# ```ruby
# [1, 3, 5].bubble_sort! { |num1, num2| num1 <=> num2 } #sort ascending
# [1, 3, 5].bubble_sort! { |num1, num2| num2 <=> num1 } #sort descending
# ```
#
# #### `#<=>` (the **spaceship** method) compares objects. `x.<=>(y)` returns
# `-1` if `x` is less than `y`. If `x` and `y` are equal, it returns `0`. If
# greater, `1`. For future reference, you can define `<=>` on your own classes.
#
# http://stackoverflow.com/questions/827649/what-is-the-ruby-spaceship-operator
require "byebug"
class Array
  def bubble_sort!(&prc)
    sorted = true
    prc ||= Proc.new {|a,b| a <=> b}
    (0...self.length).each do |i|
      sorted = true
      (0...self.length-1-i).each do |i2|
        if prc.call(self[i2],self[i2+1]) == 1
          self[i2], self[i2+1] = self[i2+1], self[i2]
          sorted = false
        end
      end
      break if sorted == true
    end
  end

  def bubble_sort(&prc)
    new_arr = self.clone

    sorted = true
    prc ||= Proc.new {|a,b| a <=> b}
    (0...new_arr.length).each do |i|
      sorted = true
      (0...new_arr.length-1-i).each do |i2|
        if prc.call(new_arr[i2],new_arr[i2+1]) == 1
          new_arr[i2], new_arr[i2+1] = new_arr[i2+1], new_arr[i2]
          sorted = false
        end
      end
      break if sorted == true
    end
    new_arr
  end
end

# array = [0, 3, 2, 5, -2]

# p array.bubble_sort

# ### Substrings and Subwords
#
# Write a method, `substrings`, that will take a `String` and return an
# array containing each of its substrings. Don't repeat substrings.
# Example output: `substrings("cat") => ["c", "ca", "cat", "a", "at",
# "t"]`.
#
# Your `substrings` method returns many strings that are not true English
# words. Let's write a new method, `subwords`, which will call
# `substrings`, filtering it to return only valid words. To do this,
# `subwords` will accept both a string and a dictionary (an array of
# words).

def substrings(string)
  new_arr = []
  string.each_char.with_index do |char, i|
    new_arr << char
    (i+1...string.length).each do |i2|
      new_arr << string[i..i2]
    end
  end
  new_arr
end

# p substrings("cat")

def subwords(word, dictionary)
  substrings(word).select {|substring| dictionary.include?(substring)}
end

# p subwords("acatl", ["cat"])

# ### Doubler
# Write a `doubler` method that takes an array of integers and returns an
# array with the original elements multiplied by two.

def doubler(array)
  array.map! {|num| num * 2}
end

#p doubler([4, 5, 8])

# ### My Each
# Extend the Array class to include a method named `my_each` that takes a
# block, calls the block on every element of the array, and then returns
# the original array. Do not use Enumerable's `each` method. I want to be
# able to write:
#
# ```ruby
# # calls my_each twice on the array, printing all the numbers twice.
# return_value = [1, 2, 3].my_each do |num|
#   puts num
# end.my_each do |num|
#   puts num
# end
# # => 1
#      2
#      3
#      1
#      2
#      3
#
# p return_value # => [1, 2, 3]
# ```

require "byebug"

class Array
  def my_each(&prc)
    #debugger
    new_array = []
    self.length.times {|ele| new_array << prc.call(self[ele])}
    new_array
  end
end

# array = [5, 7, 9]

# new_array = array.my_each do |ele| 
#   ele * 3
# end

# ### My Enumerable Methods
# * Implement new `Array` methods `my_map` and `my_select`. Do
#   it by monkey-patching the `Array` class. Don't use any of the
#   original versions when writing these. Use your `my_each` method to
#   define the others. Remember that `each`/`map`/`select` do not modify
#   the original array.
# * Implement a `my_inject` method. Your version shouldn't take an
#   optional starting argument; just use the first element. Ruby's
#   `inject` is fancy (you can write `[1, 2, 3].inject(:+)` to shorten
#   up `[1, 2, 3].inject { |sum, num| sum + num }`), but do the block
#   (and not the symbol) version. Again, use your `my_each` to define
#   `my_inject`. Again, do not modify the original array.

class Array
  def my_map(&prc)
    new_arr = []
    self.my_each {|val| new_arr << prc.call(val)}
    new_arr
  end

  def my_select(&prc)
    new_arr = []
    self.my_each {|val| new_arr << val if prc.call(val)}
    new_arr
  end

  def my_inject(&blk) # [(5..10).inject { |sum, n| sum + n }     
    #$acc = self[0]
    acc = self[0]
    skip = true
    self.my_each do |val|
      if skip
        skip = false
        next
      end
      acc = blk.call(acc, val)
    end
    return acc
    
    #return self[0] if self.empty?

    #acc = self[0]
    #acc = acc + my_inject(self[1..-1])
    
  end
end

 arra = [5, 7, 9]
#p arra.my_map {|ele| ele * 4}
#p arra.my_select {|ele| ele % 3 == 0}

# ### Concatenate
# Create a method that takes in an `Array` of `String`s and uses `inject`
# to return the concatenation of the strings.
#
# ```ruby
# concatenate(["Yay ", "for ", "strings!"])
# # => "Yay for strings!"
# ```

def concatenate(strings)
  strings.my_inject {|first_word, other_words| first_word + other_words}
end

p concatenate(["Yay ", "for ", "strings!"])
