module Commitment
  class Github
    
    include HTTParty
    base_uri "https://api.github.com"


    def initialize(auth_token)
      @auth = {
          "Authorization" =>  "token #{auth_token}",
          "User-Agent"    =>  "HTTParty"
      }
    end

    def get_org_repo(org, options={})
    	 self.class.get("/orgs/#{org}/repos",
                    :headers => @header,
                     body: options.to_jason)
    end

    def get_contributors(owner, repo)
        self.class.get("/repos/#{owner}/#{repo}/contributors",
                     :headers => @auth
    end	
    

    def get_contributions_stats(owner, repo)
    	self.class.get("/repos/#{owner}/#{repo}/stats/contributors",
    		          :headers => @auth)
    end

