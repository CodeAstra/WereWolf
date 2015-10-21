class Player
  def initialize
    @in_love_with = false
  end

  def fall_in_love_with (fellow_lover)
    @in_love_with = fellow_lover
    puts "#{self} loves #{fellow_lover}"
  end

  def in_love_with?
    @in_love_with
  end

  def reset_love!
    @in_love_with = false
  end
end
