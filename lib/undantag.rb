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
      Net::HTTP.post_form(uri, {exception: exception, api_key: key})
    end
  end
  def self.configure(params)
    Undantag::Configuration.api_key = params[:api_key]
    Undantag::Configuration.github_user = params[:github_user]
    Undantag::Configuration.github_repo = params[:github_repo]
  end
end
