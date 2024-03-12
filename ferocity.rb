#!/usr/bin/env ruby

# Ye olde Trials simulation engine: Passage of Ferocity version
#
# INSTRUCTIONS: Look up your Trials win rate on destinytracker.com and enter it
# below. Maybe look at your seasonal win rate, and also your win rate in recent
# weekends, as they may be different. If your laptop is a potato, reduce the
# number of games.

WIN_RATE = 0.40
GAMES = 10_000_000

adepts = wins = 0

GAMES.times do
  if rand < WIN_RATE
    wins += 1
    if wins == 7
      adepts += 1
      wins = 0
    end
  else
    if wins < 3
      wins = 0
    else
      wins = 3
    end
  end
end

puts "With this strategy, it took #{GAMES / adepts} games per adept weapon."
