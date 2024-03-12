#!/usr/bin/env ruby

# Ye olde Trials simulation engine: Passage of Ferocity version
#
# INSTRUCTIONS: Look up your Trials win rate on destinytracker.com and enter it
# below. Maybe look at your seasonal win rate, and also your win rate in recent
# weekends, as they may be different. If your laptop is a potato, reduce the
# number of games.

WIN_RATE = 0.40
GAMES = 10_000_000

adepts = wins = locked_wins = 0

GAMES.times do
  if rand < WIN_RATE
    wins += 1
    locked_wins = wins - 1
    if wins == 7
      adepts += 1
      wins = locked_wins = 0
    end
  else
    if wins > locked_wins
      wins -= 1
    end
  end
end

printf("At this win rate, it took %0.1f games per adept weapon.\n", GAMES.to_f / adepts.to_f)
