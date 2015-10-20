require_relative 'player'

class Villager < Player
  def accuse(players)
    exceptions=[self]
    tough_guy=players.tough_guy
    exceptions+=[tough_guy] if tough_guy && tough_guy.isAttacked?
    (players.alive_players - exceptions).sample
  end
end
