#! /usr/bin/ruby
require 'zlib'
require 'colorize'
require 'pp'

require_relative 'census'
require_relative 'char_state'

UPPERCASE_CHARACTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
LOWERCASE_CHARACTERS = 'abcdefghijklmnopqrstuvwxyz'
HIDDEN_CHARACTERS = UPPERCASE_CHARACTERS + LOWERCASE_CHARACTERS

# Holds the data for a game in progress. Not responsible for user-facing I/O.
class Game
  def initialize
    @answer = Game::select_quote
    @char_states = @answer.chars.map do |c|
      HIDDEN_CHARACTERS.include?(c) ? Character_State::UNREVEALED
                                    : Character_State::REVEALED
    end
  end

  attr_reader :last_guess_successful

  def current_board
    return (0...quote_length).map { |i|
      case @char_states[i]
      when Character_State::UNREVEALED
        Game::hidden_letter_symbol(@answer[i])
      when Character_State::NEWLY_REVEALED
        @answer[i].colorize(:color => :light_green)
      when Character_State::REVEALED
        @answer[i]
      end
    }.join
  end

  def victory?
    return @char_states.none?{ |s| Character_State::IS_HIDDEN[s] }
  end

  def process_guess(input)
    @char_states.map!{ |s| Character_State::AGED_VERSION[s] }
    in_census = Census.new(input.gsub(/[^A-Za-z]/, '').downcase)
    @last_guess_successful = valid_guess?(in_census)
    if @last_guess_successful then
      reveal(in_census)
    end
  end

  private
  def quote_length
    return @answer.length
  end

  # A string containing only the still-hidden characters from the quotation.
  def hidden_letters
    return (0...quote_length).map { |i|
      Character_State::IS_HIDDEN[@char_states[i]] ? @answer[i].downcase : ''
    }.join
  end

  # A hash containing each unguessed letter in the quote and each index where
  # it is located.
  def hidden_directory
    return (0...quote_length).select do |i|
      Character_State::IS_HIDDEN[@char_states[i]]
    end.group_by do |i|
      @answer[i].downcase
    end
  end

  def valid_guess?(request_census)
    return request_census.subset?(Census.new(hidden_letters))
  end

  def reveal(request_census)
    dir = hidden_directory
    request_census.data.each do |letter, count|
      dir[letter].sample(count).each do |i|
        @char_states[i] = Character_State::NEWLY_REVEALED
      end
    end
  end

  def self.select_quote
    all_quotes = Zlib::Inflate.inflate(File.read('.data/quotes.dat')).split("\n")
    return all_quotes.sample
  end

  def self.hidden_letter_symbol(letter)
    return UPPERCASE_CHARACTERS.include?(letter) ? '‗' : '_'
  end

end
