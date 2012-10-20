module Undantag
  class Configuration
    class << self
      attr_accessor :api_key, :github_user, :github_repo
      def to_hash
        { api_key: api_key, github_user: github_user, github_repo: github_repo }
      end
    end
  end
end
