words = %w[python awesome ruby rails book javascript space engineering laptop]

class Hangman
  attr_reader :hidden_word
  attr_accessor :turn, :over, :guessed_characters

  def initialize(word)
    @hidden_word = word
    @guessed_characters = []
    @turn = 5
    @over = false
  end

end

