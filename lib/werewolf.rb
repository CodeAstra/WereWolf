require "werewolf/version"
require 'werewolf/game'
require 'werewolf/game_simulator'
require 'werewolf/game_suggestor'

module Werewolf
  class << self
    # Return:
    # => 0 if the game is draw
    # => 1 if wolves win
    # => 2 if villagers win
    def run(wolves_count, villagers_count)
      game = Game.new(wolves_count, villagers_count)
      return game.simulate
    end

    def simulate

    end

    def suggest

    end
  end
end
