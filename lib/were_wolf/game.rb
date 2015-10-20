require_relative 'player/player_collection'

# game = Game.new(3, 9)
# game.simulate
class Game
  DRAW = 0
  WOLF = 1
  VILLAGER = 2

  def initialize(no_of_wolves, no_of_villagers)
    @players = PlayerCollection.new(no_of_wolves, no_of_villagers)
  end

  def run
    until over?
      night_mode
      day_mode unless over?
    end

    return DRAW if @draw

    return villagers_alive.empty? ? WOLF : VILLAGER
  end

private
  def over?
    villagers_alive.empty? || wolves_alive.empty?
  end

  def night_mode
    # Cop identifies a person
    cop = @players.cop
    cop.identify_a_player(@players) if cop
    saved_people = []
    # Doctor chooses to save a person
    doctor = @players.doctor
    saved_people.push(doctor.choose_a_player_to_save(@players)) if doctor
    # Witch chooses to save a person once in the entire game
    witch = @players.witch
    person_saved_by_witch = witch.choose_a_player_to_save(@players) if witch
    saved_people.push(person_saved_by_witch) if witch && person_saved_by_witch
    # Wolves kill a villager
    wolves_victim = villagers_alive.sample
    # Rogue kills a players once in the entire game
    rogue = @players.rogue
    rogues_victim = rogue.choose_victim(@players) if rogue

    # Don't kill the person if the doctor saved the person
    @players.kill(wolves_victim) unless saved_people.include?(wolves_victim)
    # Don't kill the person again, if the wolves have already killed the person
    @players.kill(rogues_victim) unless (saved_people.include?(rogues_victim)) || (rogues_victim == wolves_victim)
  end

  def day_mode
    # Witch can kill a player once in the entire game
    witch = @players.witch
    if witch
      witchs_victim = witch.choose_a_player_to_kill(@players)
      if witchs_victim
        @players.kill(witchs_victim) if witchs_victim
        return if over?
      end
    end

    # Run voting to kick out a player
    victim = run_voting
    if victim == DRAW
      @draw = true
    else
      @players.kill(victim)
    end
  end

  def run_voting
    if (villagers_count == 1 && wolves_count == 1)
      return DRAW
    end

    votes = Hash.new(0)

    players_alive.each do |player|
      accused = player.accuse(@players)
      votes[accused] += 1
    end

    max_votes = votes.values.max
    winners = []
    votes.keys.each do |player|
      winners.push(player) if votes[player] == max_votes
    end

    if winners.count == 1
      return winners.first
    else
      return run_voting
    end
  end

  def villagers_alive
    @players.alive_villagers
  end

  def villagers_count
    villagers_alive.count
  end

  def wolves_alive
    @players.alive_wolves
  end

  def wolves_count
    wolves_alive.count
  end

  def players_alive
    @players.alive_players
  end
end
