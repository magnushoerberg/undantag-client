require "undantag/version"
require 'net/https'
require 'uri'

module Undantag
  module ConfigurationError
    class NoApiKey < Exception; end
  end
  class Configuration
    class << self
      attr_accessor :api_key, :github_user, :github_repo
      def to_hash
        { api_key: api_key, github_user: github_user, github_repo: github_repo }
      end
    end
  end
  class Notifier
    URL = "http://undantag.duh.se/exception"
    def self.notify exception
      unless Undantag::Configuration.api_key
        throw Undantag::ConfigurationError::NoApiKey
      end
      uri = URI(Notifier::URL)
      key = Undantag::Configuration.api_key
      post_params = Undantag::Configuration.to_hash.merge(title: 'test',
                                                          body: exception)
      Net::HTTP.post_form(uri, post_params)
    end
  end
  def self.configure(params)
    Undantag::Configuration.api_key = params[:api_key]
    Undantag::Configuration.github_user = params[:github_user]
    Undantag::Configuration.github_repo = params[:github_repo]
  end
end
