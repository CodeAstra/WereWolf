require_relative 'wolf'
require_relative 'villager'

# game = Game.new(3, 9)
# game.simulate
class Game
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
      day_mode

      puts "Status: #{@villagers.select(&:alive?).count} Villagers & #{@wolves.select(&:alive?).count} Wolves"
    end

    declare_result
  end

private
  def over?
    @villagers.select(&:alive?).empty? || @wolves.select(&:alive?).empty?
  end

  def declare_result
    if @villagers.select(&:alive?).empty?
      puts "Wolves Win!"
    else
      puts "Villagers Win"
    end
  end

  def night_mode
    @villagers.sample.kill!
  end

  def day_mode
    (@villagers + @wolves).sample.kill!
  end
end

Game.new(3, 6).simulate
