require_relative 'player'

class Wolf < Player

  def initialize
  	is_well
  end

  def accuse(players)
    players.alive_villagers.sample
  end

  def fall_sick
  	@sick = true
  end

  def is_sick?
  	@sick
  end

  def is_well
  	@sick = false
  end

end
