class ToughGuy < Villager
def initialize
  self
  @is_Attacked=false
end
def attacked
  @is_Attacked=true
end
def isAttacked?
  @is_Attacked
end
end
