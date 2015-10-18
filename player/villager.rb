require_relative 'player'

class Villager < Player
  def accuse(players)
    (players.alive_players - [self]).sample
  end
end
