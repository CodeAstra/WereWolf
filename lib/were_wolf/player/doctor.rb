class Doctor < Villager
  def initialize
    super
    forget_all!
  end

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

  def remember_innocent(player)
    @known_innocents.push(player)
  end

  def accuse(players)
    forget_all! if players.alive_players.count == @known_innocents.count + 1

    return (players.alive_players - [self] - @known_innocents).sample
  end

  def forget_all!
    @known_innocents = []
  end
end
