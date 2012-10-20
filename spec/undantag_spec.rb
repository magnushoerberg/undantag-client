require 'rspec'
require 'vcr'
require 'vcr_helper'
require './lib/undantag'

describe Undantag do
  let api_key = 'super seceret api key'
  let github_user = 'octocat'
  let github_repo = 'testify'

  it 'can be configured with a api key' do
    Undantag.configure(api_key: api_key)
    Undantag::Configuration.api_key.should == api_key
  end
  it 'can be configured with a github user' do
    Undantag.configure(github_user: github_user)
    Undantag::Configuration.github_user.should == github_user
  end
  it 'can be configured with a github repo' do
    Undantag.configure(github_repo: github_repo)
    Undantag::Configuration.github_repo.should == github_repo
  end
  it 'makes a post to the server when notify is called' do
    VCR.use_cassette("undantag-server-authorized") do
      Undantag.configure(api_key: ENV['UNDANTAG_API_KEY'],
                         github_user: ENV['GITHUB_USER'],
                         github_repo: ENV['GITHUB_REPO'])
      Undantag::Notifier.notify(Exception.to_s)
    end
  end
  it 'throws Undantag::NotAuthorized when a 401 is returned' do
    VCR.use_cassette("undantag-server-not-authorized") do
      Undantag.configure api_key: api_key
      expect { Undantag::Notifier.notify(Exception.to_s) }.to raise_error(Undantag::NotAuthorized)
    end
  end
  it 'throws "Undantag::ConfigurationError::NoApiKey" if send is called' do
    #temp hack
    Undantag.configure api_key: nil
    expect { Undantag::Notifier.notify(Exception.to_s) }.to raise_error(Undantag::ConfigurationError::NoApiKey)
  end
end
