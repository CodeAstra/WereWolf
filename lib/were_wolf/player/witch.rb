class Witch < Doctor
  def initialize
    super
    @save_power_used = false
    @kill_power_used = false
  end

  def choose_a_player_to_save(players)
    return if @save_power_used

    if choose_to_use_power?(players)
      # Choose a person to save
      @save_power_used = true
      return super(players)
    else
      # Save the save power for a later round
      return nil
    end
  end

  def choose_a_player_to_kill(players)
    return if @kill_power_used

    if choose_to_use_power?(players)
      @kill_power_used = true
      return (players.alive_players - [self]).sample
    else
      return
    end
  end

private
  def choose_to_use_power?(players)
    # Always use the power if there is only one another player in the game,
    # as the other player should be a wolf
    return true if players.alive_players.count == 2

    rand < (1.0/(players.alive_wolves.count + 1))
  end
end
