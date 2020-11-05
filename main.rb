# frozen_string_literal: true

require 'pry'

words = %w[python awesome ruby rails book javascript space engineering laptop]

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
    # binding.pry()
    display_word

    until over
      character = ask_character
      check_character(character)
    end
  end

  def ask_character
    character = ''
    loop do
      puts 'Enter your guess character:'
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
      display_word(character)
    else
      self.turn -= 1
      puts "Wrong guess. you have now #{turn} turn left."
      game_over
    end
  end

  def display_word(character = nil)
    # binding.pry()
    self.failed = false
    hidden_word.each_char do |i|
      if guessed_characters.include?(i)
        print i
      else
        print '_'
        self.failed = true
      end
    end
    puts ''
    game_over
  end

  def game_over
    if failed
      if turn < 1
        puts "GAME OVER!! Better luck next time.\nThe word was #{hidden_word}"
        self.over = true
      end
    else
      puts 'You won the game. Congratulations!!'
      puts "The secret word is #{hidden_word}"
      self.over = true
    end
  end
end

player = Hangman.new(words.sample)

player.play
