class Rogue < Villager
  def initialize
    super
    @killing_power_used = false
  end

  def choose_victim(players)
    return nil if @killing_power_used

    if (rand < (1.0/(players.alive_wolves.count + 1)))
      # Choose a victim
      @killing_power_used = true
      return (players.alive_players - [self]).sample
    else
      # Save the power for a later round
      return nil
    end
  end
end
