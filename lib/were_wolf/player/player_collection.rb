require_relative 'wolf'
require_relative 'villager'
require_relative 'cop'
require_relative 'doctor'
require_relative 'rogue'
require_relative 'witch'
require_relative 'little_girl'
require_relative 'diseased'

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
      elsif i == 2
        villager = Doctor.new
        @doctor = villager
      elsif i == 3
        villager = Rogue.new
        @rogue = villager
      elsif i == 4
        villager = Witch.new
        @witch = villager
      elsif i == 5
        villager = LittleGirl.new
        @little_girl = villager
      elsif i == 6
        villager = Diseased.new
        @diseased = villager
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
      promote_rogue_to_wolf
    else
      @cop = nil if player.is_a?(Cop)
      @doctor = nil if player.is_a?(Doctor)
      @rogue = nil if player.is_a?(Rogue)
      @witch = nil if player.is_a?(Witch)
      @little_girl = nil if player.is_a?(LittleGirl)      
      @diseased = nil if player.is_a?(Diseased)
      collection = @villagers
    end
    collection.delete(player)
    @players.delete(player)
    @cop.forget(player) if @cop
    @little_girl.forget(player) if @little_girl
    @wolves[0].fall_sick if player.is_a?(Diseased)
  end

  def cop
    @cop
  end

  def doctor
    @doctor
  end

  def rogue
    @rogue
  end

  def witch
    @witch
  end

  def little_girl
    @little_girl
  end

  def diseased
    @diseased
  end

  def wolves
    @wolves
  end

private
  def promote_rogue_to_wolf
    return if @wolves.count > 0

    if @rogue
      kill(@rogue)
      new_wolf = Wolf.new
      @wolves.push(new_wolf)
      @players.push(new_wolf)
    end

    @cop.forget_all!
    @little_girl.forget_all!
  end
end
