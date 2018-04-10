#! /usr/bin/ruby

# A Census is just a list of letters and counts thereof.

class Census

  attr_reader :data

  def initialize(string)
    @data = string.chars.reduce(Hash::new(0)) do |h, c|
      h[c] += 1
      h
    end
  end

  # Census A is a subset of Census B if A contains everything in B at least.
  def subset?(other)
    return @data.keys.all? { |l| @data[l] <= other.data[l] }
  end

end
