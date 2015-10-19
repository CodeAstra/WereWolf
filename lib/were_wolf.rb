require 'were_wolf/version'
require 'were_wolf/game'
require 'were_wolf/game_simulator'
require 'were_wolf/game_suggestor'

module WereWolf
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
