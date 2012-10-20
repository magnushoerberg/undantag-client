require 'rspec'
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
  it 'makes a post to example.com when notify is called' do
    Undantag.configure api_key: api_key
    resp = Undantag::Notifier.notify(Exception.to_s)
  end
  it 'throws "Undantag::ConfigurationError::NoApiKey" if send is called' do
    #temp hack
    Undantag.configure api_key: nil
    expect { Undantag::Notifier.notify(Exception.to_s) }.to raise_error
  end
end
