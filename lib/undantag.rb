require "undantag/version"
require "undantag/exceptions"
require "undantag/configuration"
require "undantag/notifier"
require 'net/https'
require 'uri'

module Undantag
  def self.configure(params)
    Undantag::Configuration.api_key = params[:api_key]
    Undantag::Configuration.github_user = params[:github_user]
    Undantag::Configuration.github_repo = params[:github_repo]
  end
end
