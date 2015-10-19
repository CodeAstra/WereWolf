class Doctor < Villager
  def choose_a_player_to_save(players)
    # Assumption: Doctor saves him/her self 50% of the times
    if rand < 0.5
      return self
    else
      return players.alive_players.sample
    end
  end
end
