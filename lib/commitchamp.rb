require "httparty"
require "pry"

require "commitment/GitHub"

module Commitchamp
  class App
    def initialize 
    end

    def mainfunction
    	auth_token = get_auth_token
        repo_name = get_repo
      #put some way to (F)etch repo, (Q)uit, or (S)ort data
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

    def gets_repo_contributions
    	#fetches users contributions and gathers their stats?
    end	

    def sorts_repo_contributions
        #additions,deltions,changes are sorted?
    end	
    def print_repo_contributions
    	#prints contributions 
    end	
 end
end

app = Commitchamp::App.new
app.mainfunction



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

