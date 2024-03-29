 class GuessingGame
  def initialize(min, max)
    @min = min
    @max = max
    @secret_num = rand(min..max)
    @num_attempts = 0
    @game_over = false
  end

  def num_attempts
    @num_attempts
  end

  def game_over?
    @game_over
  end

  def check_num(attempt)
    @num_attempts += 1
    if attempt == @secret_num
        @game_over = true
        p "you win"
    elsif attempt > @secret_num
        p "too big"
    else
        p "too small"
    end
  end

  def ask_user
    p "enter a number"
    num = gets.chomp.to_i
    self.check_num(num)
  end
end
