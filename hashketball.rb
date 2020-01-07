
def game_hash
  {
    home: {
      team_name: "Brooklyn Nets",
      colors: ["Black","White"],
      players: [
        { player_name: "Alan Anderson",
          number: 0,
          shoe: 16,
          points: 22,
          rebounds: 12,
          assists: 12,
          steals: 3,
          blocks: 1,
          slam_dunks: 1},
        { player_name: "Reggie Evans",
          number: 30,
          shoe: 14,
          points: 12,
          rebounds: 12,
          assists: 12,
          steals: 12,
          blocks: 12,
          slam_dunks:7},
        { player_name: "Brook Lopez",
          number: 11,
          shoe: 17,
          points: 17,
          rebounds: 19,
          assists: 10,
          steals: 3,
          blocks: 1,
          slam_dunks:15},
        { player_name: "Mason Plumlee",
          number: 1,
          shoe: 19,
          points: 26,
          rebounds: 11,
          assists: 6,
          steals: 3,
          blocks: 8,
          slam_dunks:5},
        { player_name: "Jason Terry",
          number: 31,
          shoe: 15,
          points: 19,
          rebounds: 2,
          assists: 2,
          steals: 4,
          blocks: 11,
          slam_dunks:1}]
    },
    away: {
      team_name: "Charlotte Hornets",
      colors: ["Turquoise","Purple"],
      players: [
        { player_name: "Jeff Adrien",
          number: 4,
          shoe: 18,
          points: 10,
          rebounds: 1,
          assists: 1,
          steals: 2,
          blocks: 7,
          slam_dunks: 2},
        { player_name: "Bismack Biyombo",
          number: 0,
          shoe: 16,
          points: 12,
          rebounds: 4,
          assists: 7,
          steals: 22,
          blocks: 15,
          slam_dunks:10},
        { player_name: "DeSagna Diop",
          number: 2,
          shoe: 14,
          points: 24,
          rebounds: 12,
          assists: 12,
          steals: 4,
          blocks: 5,
          slam_dunks:5},
        { player_name: "Ben Gordon",
          number: 8,
          shoe: 15,
          points: 33,
          rebounds: 3,
          assists: 2,
          steals: 1,
          blocks: 1,
          slam_dunks:0},
        { player_name: "Kemba Walker",
          number: 33,
          shoe: 15,
          points: 6,
          rebounds: 12,
          assists: 12,
          steals: 7,
          blocks: 5,
          slam_dunks:12}]
    }
  }
end

# Small/Helper Methods - reduce verbosity

def search_players # This code was called a lot so I made it a method callable with yield
  game_hash.map {|team, info|
    game_hash[team][:players].map {|player|
      yield player
    }
  }
end

# TEST METHODS BELOW

def num_points_scored(pname)
  result = nil
  search_players {|player|
    if player[:player_name] == pname
      result = player[:points]
    end
  }
  result
end

def shoe_size(pname)
  result = nil
  search_players {|player|
    if player[:player_name] == pname
      result = player[:shoe]
    end
  }
  result
end

def team_colors(tname)
  game_hash.each {|team, info|
    if game_hash[team][:team_name] == tname
      return game_hash[team][:colors]
    end
  }
end

def team_names
  result = []
  game_hash.map {|team, info|
    result << game_hash[team][:team_name]
  }
  result
end

def player_numbers(tname)
  result = []
  game_hash.map {|team, info|
    if game_hash[team][:team_name] == tname
      game_hash[team][:players].map {|player|
        result << player[:number]
      }
    end
  }
  result
end

def player_stats(pname)
  search_players {|player|
    if player[:player_name] == pname
      return player.select {|k|
        k != :player_name
      }
    end
  }
end

def big_shoe_rebounds
  biggest_shoe = 0
  biggest_shoe_rebounds = 0
  search_players{ |player|
    if biggest_shoe < player[:shoe]
      biggest_shoe = player[:shoe]
      biggest_shoe_rebounds = player[:rebounds]
    end
  }
  biggest_shoe_rebounds
end

def most_points_scored
  highest_points = 0
  high_score_name = ""
  search_players {|player|
    if highest_points < player[:points]
      highest_points = player[:points]
      high_score_name = player[:player_name]
    end
  }
  high_score_name
end

# uses a hash to store point totals for teams - possible to improve?
def winning_team
  score = 0
  team_points = {}
  winning_team = ""
  game_hash.map {|team, info|
    game_hash[team][:players].map {|player|
      score += player[:points]
    }
    team_points[game_hash[team][:team_name]] = score
    score = 0
  }
  team_points.map {|team, total_points|
    if total_points > score
      score = total_points
      winning_team = team
    end
  }
  winning_team
end

def player_with_longest_name
  length = 0
  longest_name = ""
  search_players { |player|
    if player[:player_name].length > length
      length = player[:player_name].length
      longest_name = player[:player_name]
    end
  }
  longest_name
end

def player_with_most_steals
  number_of_steals = 0
  most_steals = ""
  search_players { |player|
    if player[:steals] > number_of_steals
      number_of_steals = player[:steals]
      most_steals = player[:player_name]
    end
  }
  most_steals
end

def long_name_steals_a_ton?
  long_name = player_with_longest_name
  steals_a_ton = player_with_most_steals
  if steals_a_ton == long_name
    return true
  else
    return false
  end
end

###################### Improving code?

# the following code was made to test my knowledge of yield
# once I understood how it worked, I implemented the method above
# and refactored all my code

def most_slam_dunks
  slam_numbers = 0
  slammers = ""
  search_players { |player|
    if player[:slam_dunks] > slam_numbers
      slam_numbers = player[:slam_dunks]
      slammers = player[:player_name]
    end
  }
  puts "#{slammers} has the most slam dunks at #{slam_numbers} dunks"
end

most_slam_dunks