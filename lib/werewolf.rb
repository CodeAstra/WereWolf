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
      return game.run
    end

    # Returns a hash with the following keys and value pairs:
    # => 0, <no of draws>
    # => 1, <no of tiems wolves won>
    # => 2, <no of tiems vilalgers won>
    def simulate(wolves_count, villagers_count, runs_count = 100)
      simulator = GameSimulator.new(wolves_count, villagers_count, runs_count)
      return simulator.simulate
    end

    def suggest(players_count, runs_count = 100)
      suggestor = GameSuggestor.new(players_count, runs_count)
      return suggestor.run
    end
  end
end
