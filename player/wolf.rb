require_relative 'player'

class Wolf < Player
  def accuse(players)
    players.alive_villagers.sample
  end
end
