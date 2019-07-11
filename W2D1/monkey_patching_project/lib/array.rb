# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
  def span
    return nil if self.empty?
    self.max - self.min
  end

  def average
    return nil if self.empty? 
    self.sum / self.length.to_f
  end

  def median
    return nil if self.empty?
    if self.length.odd? 
        self.sort[self.length/2]
    else
        (self.sort[self.length/2] + self.sort[self.length/2-1]) / 2.0
    end
  end

  def counts
    count = Hash.new(0)
    self.each do |ele|
        count[ele]+= 1
    end
    count
  end

  def my_count(char)
    count = 0
    self.each{ |ele| count += 1 if ele == char }
    count
  end

  def my_index(char)
    self.each_with_index { |ele, i| return i if ele == char  }
    nil
  end

  def my_uniq
    new_hash = Hash.new
    self.each {|ele| new_hash[ele] = true}
    new_hash.keys
  end

  def my_transpose
    # self.each_with_index do |e, i|
    #     self[i].each_with_index do |e2, i2|
    #         if i2 > i
    #             self[i][i2], self[i2][i] = self[i2][i], self[i][i2]
    #         end
    #     end
    # end

    new_arr = []
    
    (0...self.length).each do |i|
      sub_arr = []
      (0...self.length).each do |j|
        sub_arr << self[j][i]
      end
      new_arr << sub_arr
    end

    new_arr
  end
end
