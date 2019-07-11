class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, '_')
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    indices = []
    @secret_word.each_char.with_index do |ele, index|
      if ele == char
        indices << index
      end
    end
    indices
  end

  def fill_indices(char, indices)
    indices.each do |index|
      @guess_word[index] = char
    end
  end

  def try_guess(char)
    if self.already_attempted?(char)
      p "that has already been attempted"
      return false
    end

    matching_indcies = self.get_matching_indices(char)
    
    if matching_indcies.empty?
      @remaining_incorrect_guesses -= 1
    end

    self.fill_indices(char, matching_indcies)

    @attempted_chars << char
    true
  end

  def ask_user_for_guess
    p "Enter a char:"
    self.try_guess(gets.chomp)
  end

  def win?
    if @guess_word == @secret_word.split("")
      p "WIN"
      true
    else
      false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      p "LOSE"
      true
    else
      false
    end
  end

  def game_over?
    if self.win? || self.lose?
      p @secret_word
      true
    else
      false
    end
  end
end
