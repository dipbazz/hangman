require 'pry'

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

  def play
    # binding.pry()

    character = ask_character

    until self.over
      if valid_character?(character)
        check_character(character)
      end
      ask_character
    end
  end

  def ask_character
    puts "Enter your guess character:"
    gets.chomp
  end

  def valid_character?(character)
    if character.length == 1
      return true
    else
      puts "#{character} is not valid please enter only one character between a-z."
    end
    false
  end

  def check_character(character)
    if hidden_word.include?(character)
      puts "yes it includes it"
    else
      self.turn -= 1
      game_over?
      puts "No this character is not here."
    end
  end

  def game_over?
    if self.turn < 1
      self.over = true
    end
    self.over
  end

end


player = Hangman.new(words.sample)

player.play
