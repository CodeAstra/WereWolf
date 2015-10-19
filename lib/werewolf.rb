require "werewolf/version"
require_relative 'game'
require_relative 'game_simulator'
require_relative 'game_suggestor'

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
