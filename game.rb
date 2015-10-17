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

      puts "Status: #{villagers_count} Villagers & #{wolves_count} Wolves"
    end

    declare_result
  end

private
  def over?
    villagers_alive.empty? || wolves_alive.empty?
  end

  def declare_result
    if villagers_alive.empty?
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

Game.new(3, 6).simulate
