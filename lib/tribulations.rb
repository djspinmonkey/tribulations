class Tribulations
  DEFAULT_WIN_RATE = 40
  DEFAULT_GAMES = 10_000_000
  DEFAULT_TYPE = :all

  def initialize(win_rate: DEFAULT_WIN_RATE, games: DEFAULT_GAMES, type: DEFAULT_TYPE)
    @win_rate = win_rate.to_f / 100.0
    @games = games
    @type = type
  end

  def run
    case @type
    when :mercy
      run_mercy
    when :ferocity
      run_ferocity
    when :persistence
      run_persistence
    when :all
      <<~ALL
        Passage of Mercy
        #{run_mercy}

        Passage of Ferocity
        #{run_ferocity}

        Passage of Persistence
        #{run_persistence}
      ALL
    else
      "Unknown passage type: #{@type}"
    end
  end

  def run_mercy
    cards = adepts = wins = losses = 0

    @games.times do
      if rand < @win_rate
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

    games_per_adept_message(adepts) + "\n" +
    card_success_message(adepts, cards)
  end

  def run_ferocity
    adepts = wins = 0

    @games.times do
      if rand < @win_rate
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

    games_per_adept_message(adepts)
  end

  def run_persistence
    adepts = wins = locked_wins = 0

    @games.times do
      if rand < @win_rate
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

    games_per_adept_message(adepts)
  end

  def games_per_adept_message(adepts)
    "At this win rate, it took an average of #{sprintf("%0.1f", @games.to_f / adepts.to_f)} games per adept weapon."
  end

  def card_success_message(adepts, cards)
    "Each card has a #{sprintf("%0.1f", adepts.to_f / cards.to_f * 100.0)}% chance of success."
  end
end
