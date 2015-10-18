require_relative 'wolf'
require_relative 'villager'

# game = Game.new(3, 9)
# game.simulate
class Game
  DRAW = 0
  WOLF = 1
  VILLAGER = 2

  def initialize(no_of_wolves, no_of_villagers)
    @wolves = []
    no_of_wolves.times do
      @wolves.push(Wolf.new)
    end
    @villagers = []
    no_of_villagers.times do
      @villagers.push(Villager.new)
    end
  end

  def simulate
    until over?
      night_mode
      day_mode unless over?
    end

    return DRAW if @draw

    return villagers_alive.empty? ? WOLF : VILLAGER
  end

private
  def over?
    villagers_alive.empty? || wolves_alive.empty?
  end

  def night_mode
    victim = villagers_alive.sample
    victim.kill!
  end

  def day_mode
    victim = run_voting
    if victim == DRAW
      @draw = true
    else
      victim.kill!
    end
  end

  def run_voting
    if (villagers_count == 1 && wolves_count == 1)
      return DRAW
    end

    votes = Hash.new(0)

    wolves_alive.each do
      player = villagers_alive.sample
      votes[player] += 1
    end
    villagers_alive.each do |villager|
      player = (villagers_alive + wolves_alive - [villager]).sample
      votes[player] += 1
    end

    max_votes = votes.values.max
    winners = []
    votes.keys.each do |player|
      winners.push(player) if votes[player] == max_votes
    end

    if winners.count == 1
      return winners.first
    else
      return run_voting
    end
  end

  def villagers_alive
    @villagers.select(&:alive?)
  end

  def villagers_count
    villagers_alive.count
  end

  def wolves_alive
    @wolves.select(&:alive?)
  end

  def wolves_count
    wolves_alive.count
  end
end
