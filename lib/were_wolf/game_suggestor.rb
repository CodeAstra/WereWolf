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
      wins = GameSimulator.new(wolves_count, @players_count - wolves_count, @no_of_runs).simulate
      percent_wolves_win = (100.0*wins[Game::WOLF]/@no_of_runs)
      new_diff = (pref_wolves_prob - percent_wolves_win).abs
      if new_diff < absolute_diff
        absolute_diff = new_diff
        best_wins = wins
        wolves_count += 1
      else
        return result(wolves_count - 1, best_wins)
      end
    end
  end
private
  def result(wolves_count, best_wins)
    players = {}
    players['wolves'] = wolves_count
    players['cops'] = 1
    players['doctors'] = 1 if @players_count - wolves_count > 1
    players['rogues'] = 1 if @players_count - wolves_count > 2
    players['witches'] = 1 if @players_count - wolves_count > 3
    players['little_girls'] = 1 if @players_count - wolves_count > 4
    players['cupid'] = 1 if @players_count - wolves_count > 5
    players['villagers'] = (@players_count - wolves_count - 6) if @players_count - wolves_count > 6

    probabilities = {}
    probabilities['wolves_win'] = (100.0*(best_wins[Game::WOLF] || 0)/@no_of_runs)
    probabilities['villagers_win'] = (100.0*(best_wins[Game::VILLAGER] || 0)/@no_of_runs)
    probabilities['draws'] = (100.0*(best_wins[Game::DRAW] || 0)/@no_of_runs)

    hsh = {players: players, probabilities: probabilities}

    return hsh
  end
end
