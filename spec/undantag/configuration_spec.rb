require 'rspec'
require './lib/undantag/configuration'

describe Undantag::Configuration do
  it 'returns a hash when to_hash is called' do

    Undantag::Configuration.api_key = 'api_key'
    Undantag::Configuration.github_user = 'github_user'
    Undantag::Configuration.github_repo = 'github_repo'
    expected_result = {
      api_key: 'api_key',
      github_user: 'github_user',
      github_repo: 'github_repo'
    }
    Undantag::Configuration.to_hash.should == expected_result
  end
end

