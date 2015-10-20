class Doctor < Villager
  def choose_a_player_to_save(players)
    # Save myself when ther eare only 2 players,a s the other player
    # should be a wolf
    return self if players.alive_players.count == 2
    # Assumption: Doctor saves him/her self 50% of the times
    if rand < 0.5
      return self
    else
      return players.alive_players.sample
    end
  end
end
