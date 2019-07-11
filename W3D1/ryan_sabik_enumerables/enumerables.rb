require "byebug"

class Array
    def my_each(&prc)
        
        (self.length).times {|i| prc.call(self[i])}

        self
    end

    def my_select(&prc)
        select_array = []
        self.my_each {|val| select_array << val if prc.call(val)}
        select_array
    end

    def my_reject(&prc)
        reject_arr = []
        self.my_each {|val| reject_arr << val unless prc.call(val)}
        reject_arr
    end

    def my_any?(&prc)
        self.my_each {|val| return true if prc.call(val)}
        false
    end

    def my_all?(&prc)
        self.my_each {|val| return false unless prc.call(val)}
        true
    end


    def my_flatten
        #return [] if self.kind_of?(Array)
        flattened_array = []
        self.my_each do |val|
            unless val.class == Array
                flattened_array << val
            else
                flattened_array += val.my_flatten
            end
        end
        flattened_array
    end

    def my_zip(*args)
        #[self[0] + a[0] + b[0]]
        #[self[1] + a[1] + b[1]]
        #[self[2] ...

        #debugger 
        return_array = Array.new(self.length) {Array.new(args.length+1)}
        self.length.times do |i|
            return_array[i][0] = self[i]
            args.length.times do |i2| 
                return_array[i][i2+1] = args[i2][i]
            end
        end
        return_array

        # return_array = Array.new(self.length) {Array.new(args.length+1)}
        # return_array.length.times do |outer_index|
        #     return_array[outer_index][0] = self[outer_index]            
        #     args.length.times do |inner_index|
        #         return_array[outer_index][inner_index + 1] = args[inner_index][outer_index]
        #     end
        # end

        #self = []
        #args [[], []]
        #[[self[0], a[0], b[0]]]
    end

    def my_rotate(shift=1)
        new_array = Array.new(self.length)
        #negative is RIGHT
        #rotate = current index + shift % length
        if shift < 0
            shift *= -1
            self.length.times do |i|
                rotate = (i + shift) % length
                new_array[rotate] = self[i]
            end
        else
            self.length.times do |i|
                rotate = (i - shift) % length
                new_array[rotate] = self[i]
            end
        end
        new_array
    end

    def my_join(separator="")
        my_string = ""
        if separator == ""
            return self.join("")
        else
            self.my_each {|val| my_string << val + separator}
        end
        my_string[0..-2]
    end

    def my_reverse
        reversed_array = []
        self.each do |val|
            #unshift, shift : front
            #push, pop : back
            reversed_array.unshift(val)
        end
        reversed_array
    end
end





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

# p return_value  # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []

# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true

# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

# a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"
# \
p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]