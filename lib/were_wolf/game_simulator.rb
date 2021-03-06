require_relative 'game'

class GameSimulator
  def initialize(no_of_wolves, no_of_villagers, no_of_runs)
    @no_of_wolves = no_of_wolves
    @no_of_villagers = no_of_villagers
    @no_of_runs = no_of_runs
  end

  def simulate
    wins = Hash.new(0)
    @no_of_runs.times do
      wins[Game.new(@no_of_wolves, @no_of_villagers).run] += 1
    end

    return wins
  end
end
