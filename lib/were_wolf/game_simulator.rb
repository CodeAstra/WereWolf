require_relative 'game'

class GameSimulator
  def initialize(no_of_wolves, no_of_villagers, no_of_runs)
    @no_of_wolves = no_of_wolves
    @no_of_villagers = no_of_villagers
    @no_of_runs = no_of_runs
  end

  def simulate
    wins = Hash.new(0)
    processes=Array.new
    @no_of_runs.times do
      processes << Process.fork{
        Game.new(@no_of_wolves, @no_of_villagers).run
    }
    end
    processes.each do |pid|
      Process.waitpid(pid)
      wins[$?.exitstatus]+=1
    end
    return wins
  end
end
