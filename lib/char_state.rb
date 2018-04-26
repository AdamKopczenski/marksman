#! /usr/bin/ruby
require 'zlib'

module Character_State
  UNREVEALED = 0
  REVEALED = 1

  IS_HIDDEN = {
    UNREVEALED => true,
    REVEALED => false
  }

end
