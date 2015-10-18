require_relative 'wolf'

class Cop < Villager
  def initialize
    super
    forget_all
  end

  def identify_a_player(players)
    identified_player = (players.alive_players - @identified_wolves - @identified_villagers - [self]).sample
    if identified_player.is_a?(Wolf)
      @identified_wolves.push(identified_player)
    else
      @identified_villagers.push(identified_player)
    end
  end

  def accuse(players)
    if @identified_wolves.any?
      return @identified_wolves.sample
    else
      return (players.alive_players - [self] - @identified_villagers).sample
    end
  end

  def forget_all
    @identified_wolves = []
    @identified_villagers = []
  end

  def forget(player)
    if player.is_a?(Wolf)
      @identified_wolves.delete(player)
    else
      @identified_villagers.delete(player)
    end
  end
end
