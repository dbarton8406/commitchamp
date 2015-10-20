require "httparty"
require "pry"

require "commitchamp/commitment.rb"

module Commitchamp
  class App
    include Commitment
    def initialize
    end

    def mainfunction
      auth_token = get_auth_token
      repo_name = get_repo
      owner_repo =  repo_name.split('/')
      result = gets_repo_contributions_stats(auth_token, owner_repo[0], owner_repo[1])
      contributions =[]

      result.each do |x|
        contributor = x["author"]["login"]
        additions= 0
        deletions = 0
        commits = 0
        x["weeks"].each do |week|
          additions = week["a"] + additions
          deletions = week["d"] + deletions
          commits = week["c"] + commits
        end

        # Create hash
        contribution = Hash.new
        #add properties to hash
        contribution["name"] = contributor
        contribution["additions"] = additions
        contribution["deletions"] = deletions
        contribution["commits"] = commits
        #add hash to contributions
        contributions << contribution
        #print contributor, total, additions, deletions
      end
      sorted_contributions = sort_by_deletions(contributions)
      print_repo_contributions(sorted_contributions)
    end

    def get_auth_token
      #prompt user for auth token.
      puts "you need to put in your key"
      gets.chomp
    end

    def get_repo
      #prompt for repo
      puts "Which repo would you like to look at?"
      gets.chomp
    end

    def sort_by_additions(contributions)
      contributions.sort_by { |contribution|
        contribution["additions"]
      }
    end

    def sort_by_deletions(contributions)
      contributions.sort_by { |contribution|
        contribution["deletions"]
      }
    end

    def sort_by_commits(contributions)
      contributions.sort_by { |contribution|
        contribution["commits"]
      }
    end

    def gets_repo_contributions_stats(auth_token, owner, repo)
      #fetches users contributions and stats
      data = Commitment::Github.new(auth_token)
      data.get_contributions_stats(owner, repo)
    end

    def sorts_repo_contributions
      puts "What order would you like to sort in?"
      puts "(A)dditions, (D)eletions, or (C)hanges"
      sort_repo = gets.chomp


      #additions,deltions,changes are sorted?
    end
    def print_repo_contributions(contributions)
      # # print contributor, total, additions, deletions
      printf("%s  %15s %15s %15s\n", "Contributor", "Additions", "Deletions", "Commits")
      puts "============================================================"
      contributions.each do |contribution|
        printf("%-20s %7d  %14d  %14d \n", contribution["name"], contribution["additions"], contribution["deletions"], contribution["commits"])
      end
      # print values of contribution
    end
  end
end

app = Commitchamp::App.new
app.mainfunction


#put some way to (F)etch repo, (Q)uit, or (S)ort data

# Get the list of contributions for the specified repo. Figure out how many lines the user added, deleted, and their commit count. You don't have to track contributions by week, just sum them to get a total.

# Once all the contributions have been collected for a repo, offer to sort them by:

# 1) lines added 2) lines deleted 3) total lines changed 4) commits made

# Then print the commit counts in a table as below:

# ## Contributions for 'owner/repo'

# Username      Additions     Deletions     Changes
# User 1            13534          2954        6249
# User 2             6940           913        1603
# ...
# Finally, ask the user if they'd like to sort the data differently, fetch another repo, or quit.
