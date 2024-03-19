#!/usr/bin/env ruby

# Ye olde Trials simulation engine: Passage of Mercy version
#
# INSTRUCTIONS: Look up your Trials win rate on destinytracker.com and enter it
# below. Maybe look at your seasonal win rate, and also your win rate in recent
# weekends, as they may be different. If you want to try a different strategy
# for resetting, edit the reset conditions. If your laptop is a potato, reduce
# the number of games.

WIN_RATE = 0.40
GAMES = 10_000_000

cards = adepts = wins = losses = 0

GAMES.times do
  if rand < WIN_RATE
    wins += 1
    if wins == 7
      cards += 1
      adepts += 1
      wins = losses = 0
    end
  else
    losses += 1
    if losses == 3 or wins < 2 or (wins == 2 and losses == 2)
      cards += 1
      wins = losses = 0
    end
  end
end

puts "With this strategy, it took #{GAMES / adepts} games per adept weapon."
puts "Each card has a #{sprintf("%0.1f", adepts.to_f / cards.to_f * 100.0)}% chance of success."
