require_relative 'wolf'
require_relative 'villager'
require_relative 'cop'

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
    (1..no_of_villagers).each do |i|
      if i == 1
        villager = Cop.new
        @cop = villager
      else
        villager = Villager.new
      end
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
      @cop = nil if player.is_a?(Cop)
      collection = @villagers
    end
    collection.delete(player)
    @players.delete(player)
    @cop.forget(player) if @cop
  end

  def cop
    @cop
  end
end
