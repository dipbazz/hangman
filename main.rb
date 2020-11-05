# frozen_string_literal: true

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
        guessed_characters << character
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
      puts 'No this character is not here.'
      self.turn -= 1
      if turn < 1
        self.over = true
        game_over
      end
    end
  end

  def display_word(character = nil)
    hidden_word.each_char { |i| print i == character ? i : '_' }
    puts ''
  end

  def game_over
    puts "GAME OVER!! Better luck next time.\nThe word was #{hidden_word}"
  end
end

player = Hangman.new(words.sample)

player.play
