words = %w[python awesome ruby rails book javascript space engineering laptop]

#   This is a class for Hangman. Where users can play the game.
#
#   for eg:
#     player = Hangman.new('some_word')
#     player.play()
class Hangman
  attr_reader :hidden_word
  attr_accessor :turn, :over, :guessed_characters, :guess, :failed

  def initialize(word)
    @hidden_word = word
    @guessed_characters = ''
    @turn = 5
    @over = false
    @failed = false
  end

  def play
    display_word

    until over
      character = ask_character
      check_character(character)
    end
  end

  def ask_character
    character = ''
    loop do
      puts "\nEnter your guess character:"
      character = gets.chomp

      if valid_character?(character)
        self.guessed_characters += character
        break
      end
    end
    character
  end

  def valid_character?(character)
    if character.length == 1
      if guessed_characters.include?(character)
        puts "#{character} have already been entered. Please enter some other character."
        return false
      end
    else
      puts "#{character} is not valid please enter only one character between a-z."
      return false
    end
    true
  end

  def check_character(character)
    if hidden_word.include?(character)
      display_word
    else
      self.turn -= 1
      puts "Wrong guess. you have now #{turn} turn left."
      game_over
    end
  end

  def display_word
    self.failed = false
    hidden_word.each_char do |i|
      if guessed_characters.include?(i)
        print i
      else
        print '_'
        self.failed = true
      end
    end
    game_over
  end

  def game_over
    if failed
      if turn < 1
        puts "\nGAME OVER!! Better luck next time.\nThe word was #{hidden_word}"
        self.over = true
      end
    else
      puts "\nYou won the game. Congratulations!!"
      puts "The secret word is #{hidden_word}"
      self.over = true
    end
  end
end

player = Hangman.new(words.sample)
player.play
