#! /usr/bin/ruby

module Character_State
  UNREVEALED = 0
  REVEALED = 1
  NEWLY_REVEALED = 2

  IS_HIDDEN = {
    UNREVEALED => true,
    REVEALED => false,
    NEWLY_REVEALED => false
  }

  AGED_VERSION = {
    UNREVEALED => UNREVEALED,
    REVEALED => REVEALED,
    NEWLY_REVEALED => REVEALED
  }
end
