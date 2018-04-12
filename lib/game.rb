#! /usr/bin/ruby
require 'zlib'

require_relative 'census'

UPPERCASE_CHARACTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
LOWERCASE_CHARACTERS = 'abcdefghijklmnopqrstuvwxyz'
HIDDEN_CHARACTERS = UPPERCASE_CHARACTERS + LOWERCASE_CHARACTERS

# Holds the data for a game in progress. Not responsible for user-facing I/O.
class Game
  def initialize
    @answer = Game::select_quote
    @found_chars = Array::new(quote_length, false)
    (0...quote_length).each do |i|
      @found_chars[i] ||= !HIDDEN_CHARACTERS.include?(@answer[i])
    end
  end

  attr_reader :last_guess_successful

  def current_board
    return (0...quote_length).map { |i|
      @found_chars[i] ? @answer[i]
                      : Game::hidden_letter_symbol(@answer[i])
    }.join
  end

  def victory?
    return @found_chars.all?
  end

  def process_guess(input)
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
      @found_chars[i] ? '' : @answer[i].downcase
    }.join
  end

  # A hash containing each unguessed letter in the quote and each index where
  # it is located.
  def hidden_directory
    return (0...quote_length).reject do |i|
      @found_chars[i]
    end.group_by do |i|
      @answer[i].downcase
    end
  end

  def valid_guess?(request_census)
    return request_census.subset?(Census.new(hidden_letters))
  end

  def reveal(request_census)
    dir = hidden_directory
    new_reveals = Array::new(quote_length, false)
    request_census.data.each do |letter, count|
      dir[letter].sample(count).each { |i| @found_chars[i] = true }
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
