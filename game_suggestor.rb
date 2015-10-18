require_relative 'game'
require_relative 'game_simulator'

class GameSuggestor
  def initialize(num_of_players, no_of_runs)
    @players_count = num_of_players
    @no_of_runs = no_of_runs
  end

  def run
    # Preferred Wolves Win Percentage
    pref_wolves_prob = 70
    wolves_count = 1
    absolute_diff = 1000
    best_wins = {}

    while true
      wins = GameSimulator.new(wolves_count, @players_count - wolves_count, @no_of_runs).run
      percent_wolves_win = (100.0*wins[Game::WOLF]/@no_of_runs)
      new_diff = (pref_wolves_prob - percent_wolves_win).abs
      if new_diff < absolute_diff
        absolute_diff = new_diff
        best_wins = wins
        wolves_count += 1
      else
        puts best_case_description(wolves_count - 1)
        puts "Probability of Wolves Winning:    #{100.0*(best_wins[Game::WOLF] || 0)/@no_of_runs}%"
        puts "Probability of Villagers Winning: #{100.0*(best_wins[Game::VILLAGER] || 0)/@no_of_runs}%"
        puts "Probability of Draw:              #{100.0*(best_wins[Game::DRAW] || 0)/@no_of_runs}%"
        break
      end
    end
  end
private
  def best_case_description(wolves_count)
    msg = "The best case is: #{wolves_count} Wolves;"
    msg += " 1 Cop;"
    msg += " 1 Doctor;" if @players_count - wolves_count > 1
    msg += " 1 Rogue;" if @players_count - wolves_count > 2
    msg += " #{@players_count - wolves_count - 3} Villagers" if @players_count - wolves_count > 3
  end
end

GameSuggestor.new(12, 100).run
