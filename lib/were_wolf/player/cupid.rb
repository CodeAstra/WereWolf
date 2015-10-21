require_relative 'player_collection'
require_relative 'player'

class Cupid < Villager
  def brood_lovebirds (players)
    # Cupid is more likely to pick players who are both villagers.
    if rand < 0.7
      aim_lovebirds(players.alive_villagers - [self])
    # Cupid is less likely to pick players who could be any character.
    else
      aim_lovebirds(players.alive_players - [self])
    end

  end

  def aim_lovebirds (decision)
    lovebirds = []
    lovebirds = (decision).sample(2)
    lovebirds[0].fall_in_love_with(lovebirds[1])
    lovebirds[1].fall_in_love_with(lovebirds[0])
  end
end
