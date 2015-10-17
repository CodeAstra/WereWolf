class Villager
  def initialize
    @alive = true
  end

  def kill!
    @alive = false
  end

  def alive?
    @alive
  end
end
