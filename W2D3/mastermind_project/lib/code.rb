require "byebug"

class Code

  attr_reader :pegs

  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(arr)
    arr.all? { |chars| POSSIBLE_PEGS.has_key?(chars.upcase)}
  end

  
  def initialize(pegs)
    if Code.valid_pegs?(pegs)
      @pegs = pegs.map(&:upcase)
    else
      raise 'invalid pegs'
    end
  end

  def self.random(length)
    keys = POSSIBLE_PEGS.keys
    new_pegs = Array.new(length) {keys[rand(3)]}
    Code.new(new_pegs)
  end

  def self.from_string(pegs)
    Code.new(pegs.split(""))
  end

  def [](idx)
    @pegs[idx]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(code)
    count = 0
    code.pegs.each_with_index { |peg, idx| count += 1 if code.pegs[idx] == self.pegs[idx]}
    count
  end

  def num_near_matches(guess)
    counting_hash = Hash.new { |h, k| h[k] = Array.new(2, 0) }
    
    guess.length.times do |i|
      if guess[i] != self[i]
        counting_hash[guess[i]][0] += 1
        counting_hash[self[i]][1] += 1
      end
    end

    counting_hash.values.sum {|val| val.min} 

  end

  def ==(code)
    self.num_exact_matches(code) == code.length
  end

end


