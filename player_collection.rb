require_relative 'wolf'
require_relative 'villager'

class PlayerCollection
  def initialize(no_of_wolves, no_of_villagers)
    @players = []
    @wolves = []
    @villagers = []
    no_of_wolves.times do
      wolf = Wolf.new
      @wolves.push(wolf)
      @players.push(wolf)
    end
    @villagers  = []
    no_of_villagers.times do
      villager = Villager.new
      @villagers.push(villager)
      @players.push(villager)
    end
  end

  def alive_villagers
    @villagers
  end

  def alive_wolves
    @wolves
  end

  def alive_players
    @players
  end

  def kill(player)
    if player.is_a?(Wolf)
      collection = @wolves
    else
      collection = @villagers
    end
    collection.delete(player)
    @players.delete(player)
  end
end
